clamp_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
clamp_name_curdir          := $(notdir $(patsubst %/,%,$(clamp_path_curdir)))
clamp_child_makefiles      := $(wildcard $(clamp_path_curdir)*/*mk)
clamp_names                := $(basename $(notdir $(clamp_child_makefiles)))
clamp_all_targets          := $(foreach clamp,$(clamp_names),$(clamp)_all)
clamp_strip_targets        := $(foreach clamp,$(clamp_names),$(clamp)_strip)
clamp_clean_targets        := $(foreach clamp,$(clamp_names),$(clamp)_clean)
clamp_install_path         := $(PATH_INSTALL)/$(clamp_name_curdir)
clamp_install_path_static  := $(clamp_install_path)$(EXT_LIB_STATIC)
clamp_install_path_shared  := $(clamp_install_path)$(EXT_LIB_SHARED)
clamp_sources              := $(wildcard $(clamp_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
clamp_sources              += $(wildcard $(clamp_path_curdir)/platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
clamp_sources              += $(wildcard $(clamp_path_curdir)/platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
clamp_sources              += $(wildcard $(clamp_path_curdir)/platform_specific/mac/*.c)
endif
clamp_static_objects       := $(patsubst %.c, %_static.o, $(clamp_sources))
clamp_shared_objects       := $(patsubst %.c, %_shared.o, $(clamp_sources))
clamp_depends              := $(patsubst %.c, %.d, $(clamp_sources))
clamp_depends_modules      := v2 v3 v4 compare
clamp_depends_libs_static  := $(foreach module,$(clamp_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
clamp_depends_libs_shared  := $(foreach module,$(clamp_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
clamp_depends_libs_rules   := $(foreach module,$(clamp_depends_modules),$(module)_all)

include $(clamp_child_makefiles)

$(clamp_path_curdir)%_static.o: $(clamp_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(clamp_path_curdir)%_shared.o: $(clamp_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(clamp_install_path_static): | $(clamp_depends_libs_rules)
$(clamp_install_path_static): $(clamp_static_objects)
	ar -rcs $@ $^ $(clamp_depends_libs_static)

$(clamp_install_path_shared): | $(clamp_depends_libs_rules)
$(clamp_install_path_shared): $(clamp_shared_objects)
	$(CC) -o $@ $^ $(LFLAGS) -shared $(clamp_depends_libs_shared)

.PHONY: clamp_all
clamp_all: $(clamp_all_targets) ## build and install all clamp static and shared libraries
ifneq ($(clamp_shared_objects),)
clamp_all: $(clamp_install_path_shared)
endif
ifneq ($(clamp_static_objects),)
clamp_all: $(clamp_install_path_static)
endif

.PHONY: clamp_clean
clamp_clean: $(clamp_clean_targets) ## remove and deinstall all clamp static and shared libraries
clamp_clean:
	- $(RM) $(clamp_install_path_static) $(clamp_install_path_shared) $(clamp_static_objects) $(clamp_shared_objects) $(clamp_depends)

.PHONY: clamp_strip
clamp_strip: $(clamp_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
clamp_strip:
	strip --strip-all $(clamp_install_path_shared)

-include $(clamp_depends)
