mod_path_curdir                  := $(dir $(lastword $(MAKEFILE_LIST)))
mod_name_curdir                  := $(notdir $(patsubst %/,%,$(mod_path_curdir)))
mod_child_makefiles              := $(wildcard $(mod_path_curdir)*/*mk)
mod_names                        := $(basename $(notdir $(mod_child_makefiles)))
mod_all_targets                  := $(foreach mod,$(mod_names),$(mod)_all)
mod_strip_targets                := $(foreach mod,$(mod_names),$(mod)_strip)
mod_clean_targets                := $(foreach mod,$(mod_names),$(mod)_clean)
mod_install_path                 := $(PATH_INSTALL)/$(mod_name_curdir)
mod_install_path_static          := $(mod_install_path)$(EXT_LIB_STATIC)
mod_install_path_shared          := $(mod_install_path)$(EXT_LIB_SHARED)
mod_install_path_implib          :=
mod_shared_lflags                := -shared
ifeq ($(PLATFORM), WINDOWS)
mod_install_path_implib          := $(PATH_INSTALL)/lib$(mod_name_curdir)dll.a
mod_shared_lflags                += -Wl,--out-implib=$(mod_install_path_implib)
endif
mod_sources                      := $(wildcard $(mod_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
mod_sources                      += $(wildcard $(mod_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
mod_sources                      += $(wildcard $(mod_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
mod_sources                      += $(wildcard $(mod_path_curdir)platform_specific/mac/*.c)
endif
mod_static_objects               := $(patsubst %.c, %_static.o, $(mod_sources))
mod_shared_objects               := $(patsubst %.c, %_shared.o, $(mod_sources))
mod_depends                      := $(patsubst %.c, %.d, $(mod_sources))
mod_depends_modules              :=  
mod_depends_libs_static_path     = $(foreach module_base,$(mod_depends_modules),$($(module_base)_path_curdir))
mod_depends_libs_static_src      = $(foreach path,$(mod_depends_libs_static_path),$(wildcard $(path)*.c))
ifeq ($(PLATFORM), WINDOWS)
mod_depends_libs_static_src      += $(foreach path,$(mod_depends_libs_static_path),$(wildcard $(path)platform_specific/windows/*.c))
else ifeq ($(PLATFORM), LINUX)
mod_depends_libs_static_src      += $(foreach path,$(mod_depends_libs_static_path),$(wildcard $(path)platform_specific/linux/*.c))
else ifeq ($(PLATFORM), MAC)
mod_depends_libs_static_src      += $(foreach path,$(mod_depends_libs_static_path),$(wildcard $(path)platform_specific/mac/*.c))
endif
mod_depends_libs_static          = $(patsubst %.c, %_static.o, $(mod_depends_libs_static_src))
mod_depends_libs_shared          := $(foreach module,$(mod_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
mod_depends_libs_rules           := $(foreach module,$(mod_depends_modules),$(module)_all)
mod_clean_files                  := 
mod_clean_files                  += $(mod_install_path_implib)
mod_clean_files                  += $(mod_install_path_static) 
mod_clean_files                  += $(mod_install_path_shared)
mod_clean_files                  += $(mod_static_objects)
mod_clean_files                  += $(mod_shared_objects) 
mod_clean_files                  += $(mod_depends) 

include $(mod_child_makefiles)

$(mod_path_curdir)%_static.o: $(mod_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(mod_path_curdir)%_shared.o: $(mod_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(mod_install_path_static): | $(mod_depends_libs_rules)
$(mod_install_path_static): $(mod_static_objects)
	ar -rcs $@ $(mod_static_objects) $(mod_depends_libs_static)

$(mod_install_path_shared): | $(mod_depends_libs_rules)
$(mod_install_path_shared): $(mod_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(mod_shared_lflags) $(mod_shared_objects) $(mod_depends_libs_shared)

.PHONY: mod_all
mod_all: $(mod_all_targets) ## build and install all mod static and shared libraries
ifneq ($(mod_shared_objects),)
mod_all: $(mod_install_path_shared)
mod_all: $(mod_install_path_static)
endif

.PHONY: mod_clean
mod_clean: $(mod_clean_targets) ## remove and deinstall all mod static and shared libraries
mod_clean:
	- $(RM) $(mod_clean_files)

.PHONY: mod_re
mod_re: mod_clean
mod_re: mod_all

.PHONY: mod_strip
mod_strip: $(mod_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
mod_strip:
	- strip --strip-all $(mod_install_path_shared)

-include $(mod_depends)
