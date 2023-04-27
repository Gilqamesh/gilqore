libc_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
libc_name_curdir          := $(notdir $(patsubst %/,%,$(libc_path_curdir)))
libc_child_makefiles      := $(wildcard $(libc_path_curdir)*/*mk)
libc_names                := $(basename $(notdir $(libc_child_makefiles)))
libc_all_targets          := $(foreach libc,$(libc_names),$(libc)_all)
libc_strip_targets        := $(foreach libc,$(libc_names),$(libc)_strip)
libc_clean_targets        := $(foreach libc,$(libc_names),$(libc)_clean)
libc_install_path         := $(PATH_INSTALL)/$(libc_name_curdir)
libc_install_path_static  := $(libc_install_path)$(EXT_LIB_STATIC)
libc_install_path_shared  := $(libc_install_path)$(EXT_LIB_SHARED)
libc_sources              := $(wildcard $(libc_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
libc_sources              += $(wildcard $(libc_path_curdir)/platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
libc_sources              += $(wildcard $(libc_path_curdir)/platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
libc_sources              += $(wildcard $(libc_path_curdir)/platform_specific/mac/*.c)
endif
libc_static_objects       := $(patsubst %.c, %_static.o, $(libc_sources))
libc_shared_objects       := $(patsubst %.c, %_shared.o, $(libc_sources))
libc_depends              := $(patsubst %.c, %.d, $(libc_sources))
libc_depends_modules      := common
libc_depends_libs_static  := $(foreach module,$(libc_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
libc_depends_libs_shared  := $(foreach module,$(libc_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
libc_depends_libs_rules   := $(foreach module,$(libc_depends_modules),$(module)_all)

include $(libc_child_makefiles)

$(libc_path_curdir)%_static.o: $(libc_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(libc_path_curdir)%_shared.o: $(libc_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(libc_install_path_static): | $(libc_depends_libs_rules)
$(libc_install_path_static): $(libc_static_objects)
	ar -rcs $@ $^ $(libc_depends_libs_static)

$(libc_install_path_shared): | $(libc_depends_libs_rules)
$(libc_install_path_shared): $(libc_shared_objects)
	$(CC) -o $@ $^ $(LFLAGS) -shared $(libc_depends_libs_shared)

.PHONY: libc_all
libc_all: $(libc_all_targets) ## build and install all libc static and shared libraries
ifneq ($(libc_shared_objects),)
libc_all: $(libc_install_path_shared)
endif
ifneq ($(libc_static_objects),)
libc_all: $(libc_install_path_static)
endif

.PHONY: libc_clean
libc_clean: $(libc_clean_targets) ## remove and deinstall all libc static and shared libraries
libc_clean:
	- $(RM) $(libc_install_path_static) $(libc_install_path_shared) $(libc_static_objects) $(libc_shared_objects) $(libc_depends)

.PHONY: libc_strip
libc_strip: $(libc_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
libc_strip:
	strip --strip-all $(libc_install_path_shared)

-include $(libc_depends)
