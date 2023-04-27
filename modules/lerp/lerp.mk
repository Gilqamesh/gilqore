lerp_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
lerp_name_curdir          := $(notdir $(patsubst %/,%,$(lerp_path_curdir)))
lerp_child_makefiles      := $(wildcard $(lerp_path_curdir)*/*mk)
lerp_names                := $(basename $(notdir $(lerp_child_makefiles)))
lerp_all_targets          := $(foreach lerp,$(lerp_names),$(lerp)_all)
lerp_strip_targets        := $(foreach lerp,$(lerp_names),$(lerp)_strip)
lerp_clean_targets        := $(foreach lerp,$(lerp_names),$(lerp)_clean)
lerp_install_path         := $(PATH_INSTALL)/$(lerp_name_curdir)
lerp_install_path_static  := $(lerp_install_path)$(EXT_LIB_STATIC)
lerp_install_path_shared  := $(lerp_install_path)$(EXT_LIB_SHARED)
lerp_sources              := $(wildcard $(lerp_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
lerp_sources              += $(wildcard $(lerp_path_curdir)/platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
lerp_sources              += $(wildcard $(lerp_path_curdir)/platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
lerp_sources              += $(wildcard $(lerp_path_curdir)/platform_specific/mac/*.c)
endif
lerp_static_objects       := $(patsubst %.c, %_static.o, $(lerp_sources))
lerp_shared_objects       := $(patsubst %.c, %_shared.o, $(lerp_sources))
lerp_depends              := $(patsubst %.c, %.d, $(lerp_sources))
lerp_depends_modules      := color
lerp_depends_libs_static  := $(foreach module,$(lerp_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
lerp_depends_libs_shared  := $(foreach module,$(lerp_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
lerp_depends_libs_rules   := $(foreach module,$(lerp_depends_modules),$(module)_all)

include $(lerp_child_makefiles)

$(lerp_path_curdir)%_static.o: $(lerp_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(lerp_path_curdir)%_shared.o: $(lerp_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(lerp_install_path_static): | $(lerp_depends_libs_rules)
$(lerp_install_path_static): $(lerp_static_objects)
	ar -rcs $@ $^ $(lerp_depends_libs_static)

$(lerp_install_path_shared): | $(lerp_depends_libs_rules)
$(lerp_install_path_shared): $(lerp_shared_objects)
	$(CC) -o $@ $^ $(LFLAGS) -shared $(lerp_depends_libs_shared)

.PHONY: lerp_all
lerp_all: $(lerp_all_targets) ## build and install all lerp static and shared libraries
ifneq ($(lerp_shared_objects),)
lerp_all: $(lerp_install_path_shared)
endif
ifneq ($(lerp_static_objects),)
lerp_all: $(lerp_install_path_static)
endif

.PHONY: lerp_clean
lerp_clean: $(lerp_clean_targets) ## remove and deinstall all lerp static and shared libraries
lerp_clean:
	- $(RM) $(lerp_install_path_static) $(lerp_install_path_shared) $(lerp_static_objects) $(lerp_shared_objects) $(lerp_depends)

.PHONY: lerp_strip
lerp_strip: $(lerp_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
lerp_strip:
	strip --strip-all $(lerp_install_path_shared)

-include $(lerp_depends)
