modules_path_curdir                  := $(dir $(lastword $(MAKEFILE_LIST)))
modules_name_curdir                  := $(notdir $(patsubst %/,%,$(modules_path_curdir)))
modules_child_makefiles              := $(wildcard $(modules_path_curdir)*/*mk)
modules_names                        := $(basename $(notdir $(modules_child_makefiles)))
modules_all_targets                  := $(foreach modules,$(modules_names),$(modules)_all)
modules_strip_targets                := $(foreach modules,$(modules_names),$(modules)_strip)
modules_clean_targets                := $(foreach modules,$(modules_names),$(modules)_clean)
modules_install_path                 := $(PATH_INSTALL)/$(modules_name_curdir)
modules_install_path_static          := $(modules_install_path)$(EXT_LIB_STATIC)
modules_install_path_shared          := $(modules_install_path)$(EXT_LIB_SHARED)
modules_install_path_implib          :=
modules_shared_lflags                := -shared
ifeq ($(PLATFORM), WINDOWS)
modules_install_path_implib          := $(PATH_INSTALL)/lib$(modules_name_curdir)dll.a
modules_shared_lflags                += -Wl,--out-implib=$(modules_install_path_implib)
endif
modules_sources                      := $(wildcard $(modules_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
modules_sources                      += $(wildcard $(modules_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
modules_sources                      += $(wildcard $(modules_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
modules_sources                      += $(wildcard $(modules_path_curdir)platform_specific/mac/*.c)
endif
modules_static_objects               := $(patsubst %.c, %_static.o, $(modules_sources))
modules_shared_objects               := $(patsubst %.c, %_shared.o, $(modules_sources))
modules_depends                      := $(patsubst %.c, %.d, $(modules_sources))
modules_depends_modules              :=  
modules_depends_libs_static_path     = $(foreach module_base,$(modules_depends_modules),$($(module_base)_path_curdir))
modules_depends_libs_static_src      = $(foreach path,$(modules_depends_libs_static_path),$(wildcard $(path)*.c))
ifeq ($(PLATFORM), WINDOWS)
modules_depends_libs_static_src      += $(foreach path,$(modules_depends_libs_static_path),$(wildcard $(path)platform_specific/windows/*.c))
else ifeq ($(PLATFORM), LINUX)
modules_depends_libs_static_src      += $(foreach path,$(modules_depends_libs_static_path),$(wildcard $(path)platform_specific/linux/*.c))
else ifeq ($(PLATFORM), MAC)
modules_depends_libs_static_src      += $(foreach path,$(modules_depends_libs_static_path),$(wildcard $(path)platform_specific/mac/*.c))
endif
modules_depends_libs_static          = $(patsubst %.c, %_static.o, $(modules_depends_libs_static_src))
modules_depends_libs_shared          := $(foreach module,$(modules_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
modules_depends_libs_rules           := $(foreach module,$(modules_depends_modules),$(module)_all)
modules_clean_files                  := 
modules_clean_files                  += $(modules_install_path_implib)
modules_clean_files                  += $(modules_install_path_static) 
modules_clean_files                  += $(modules_install_path_shared)
modules_clean_files                  += $(modules_static_objects)
modules_clean_files                  += $(modules_shared_objects) 
modules_clean_files                  += $(modules_depends) 

include $(modules_child_makefiles)

$(modules_path_curdir)%_static.o: $(modules_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(modules_path_curdir)%_shared.o: $(modules_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(modules_install_path_static): | $(modules_depends_libs_rules)
$(modules_install_path_static): $(modules_static_objects)
	ar -rcs $@ $(modules_static_objects) $(modules_depends_libs_static)

$(modules_install_path_shared): | $(modules_depends_libs_rules)
$(modules_install_path_shared): $(modules_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(modules_shared_lflags) $(modules_shared_objects) $(modules_depends_libs_shared)

.PHONY: modules_all
modules_all: $(modules_all_targets) ## build and install all modules static and shared libraries
ifneq ($(modules_shared_objects),)
modules_all: $(modules_install_path_shared)
modules_all: $(modules_install_path_static)
endif

.PHONY: modules_clean
modules_clean: $(modules_clean_targets) ## remove and deinstall all modules static and shared libraries
modules_clean:
	- $(RM) $(modules_clean_files)

.PHONY: modules_re
modules_re: modules_clean
modules_re: modules_all

.PHONY: modules_strip
modules_strip: $(modules_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
modules_strip:
	- strip --strip-all $(modules_install_path_shared)

-include $(modules_depends)
