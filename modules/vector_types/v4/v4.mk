v4_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
v4_name_curdir          := $(notdir $(patsubst %/,%,$(v4_path_curdir)))
v4_child_makefiles      := $(wildcard $(v4_path_curdir)*/*mk)
v4_names                := $(basename $(notdir $(v4_child_makefiles)))
v4_all_targets          := $(foreach v4,$(v4_names),$(v4)_all)
v4_strip_targets        := $(foreach v4,$(v4_names),$(v4)_strip)
v4_clean_targets        := $(foreach v4,$(v4_names),$(v4)_clean)
v4_install_path         := $(PATH_INSTALL)/$(v4_name_curdir)
v4_install_path_static  := $(v4_install_path)$(EXT_LIB_STATIC)
v4_install_path_shared  := $(v4_install_path)$(EXT_LIB_SHARED)
v4_sources              := $(wildcard $(v4_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
v4_sources              += $(wildcard $(v4_path_curdir)/platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
v4_sources              += $(wildcard $(v4_path_curdir)/platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
v4_sources              += $(wildcard $(v4_path_curdir)/platform_specific/mac/*.c)
endif
v4_static_objects       := $(patsubst %.c, %_static.o, $(v4_sources))
v4_shared_objects       := $(patsubst %.c, %_shared.o, $(v4_sources))
v4_depends              := $(patsubst %.c, %.d, $(v4_sources))
v4_depends_modules      := 
v4_depends_libs_static  := $(foreach module,$(v4_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
v4_depends_libs_shared  := $(foreach module,$(v4_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
v4_depends_libs_rules   := $(foreach module,$(v4_depends_modules),$(module)_all)

include $(v4_child_makefiles)

$(v4_path_curdir)%_static.o: $(v4_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(v4_path_curdir)%_shared.o: $(v4_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(v4_install_path_static): | $(v4_depends_libs_rules)
$(v4_install_path_static): $(v4_static_objects)
	ar -rcs $@ $^ $(v4_depends_libs_static)

$(v4_install_path_shared): | $(v4_depends_libs_rules)
$(v4_install_path_shared): $(v4_shared_objects)
	$(CC) -o $@ $^ $(LFLAGS) -shared $(v4_depends_libs_shared)

.PHONY: v4_all
v4_all: $(v4_all_targets) ## build and install all v4 static and shared libraries
ifneq ($(v4_shared_objects),)
v4_all: $(v4_install_path_shared)
endif
ifneq ($(v4_static_objects),)
v4_all: $(v4_install_path_static)
endif

.PHONY: v4_clean
v4_clean: $(v4_clean_targets) ## remove and deinstall all v4 static and shared libraries
v4_clean:
	- $(RM) $(v4_install_path_static) $(v4_install_path_shared) $(v4_static_objects) $(v4_shared_objects) $(v4_depends)

.PHONY: v4_strip
v4_strip: $(v4_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
v4_strip:
	strip --strip-all $(v4_install_path_shared)

-include $(v4_depends)
