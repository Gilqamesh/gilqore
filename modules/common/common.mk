common_path_curdir                  := $(dir $(lastword $(MAKEFILE_LIST)))
common_name_curdir                  := $(notdir $(patsubst %/,%,$(common_path_curdir)))
common_child_makefiles              := $(wildcard $(common_path_curdir)*/*mk)
common_names                        := $(basename $(notdir $(common_child_makefiles)))
common_all_targets                  := $(foreach common,$(common_names),$(common)_all)
common_strip_targets                := $(foreach common,$(common_names),$(common)_strip)
common_clean_targets                := $(foreach common,$(common_names),$(common)_clean)
common_install_path                 := $(PATH_INSTALL)/$(common_name_curdir)
common_install_path_static          := $(common_install_path)$(EXT_LIB_STATIC)
common_install_path_shared          := $(common_install_path)$(EXT_LIB_SHARED)
common_install_path_implib          :=
common_shared_lflags                := -shared
ifeq ($(PLATFORM), WINDOWS)
common_install_path_implib          := $(PATH_INSTALL)/lib$(common_name_curdir)dll.a
common_shared_lflags                += -Wl,--out-implib=$(common_install_path_implib)
endif
common_sources                      := $(wildcard $(common_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
common_sources                      += $(wildcard $(common_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
common_sources                      += $(wildcard $(common_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
common_sources                      += $(wildcard $(common_path_curdir)platform_specific/mac/*.c)
endif
common_static_objects               := $(patsubst %.c, %_static.o, $(common_sources))
common_shared_objects               := $(patsubst %.c, %_shared.o, $(common_sources))
common_depends                      := $(patsubst %.c, %.d, $(common_sources))
common_depends_modules              :=  
common_depends_libs_static_path     = $(foreach module_base,$(common_depends_modules),$($(module_base)_path_curdir))
common_depends_libs_static_src      = $(foreach path,$(common_depends_libs_static_path),$(wildcard $(path)*.c))
ifeq ($(PLATFORM), WINDOWS)
common_depends_libs_static_src      += $(foreach path,$(common_depends_libs_static_path),$(wildcard $(path)platform_specific/windows/*.c))
else ifeq ($(PLATFORM), LINUX)
common_depends_libs_static_src      += $(foreach path,$(common_depends_libs_static_path),$(wildcard $(path)platform_specific/linux/*.c))
else ifeq ($(PLATFORM), MAC)
common_depends_libs_static_src      += $(foreach path,$(common_depends_libs_static_path),$(wildcard $(path)platform_specific/mac/*.c))
endif
common_depends_libs_static          = $(patsubst %.c, %_static.o, $(common_depends_libs_static_src))
common_depends_libs_shared          := $(foreach module,$(common_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
common_depends_libs_rules           := $(foreach module,$(common_depends_modules),$(module)_all)
common_clean_files                  := 
common_clean_files                  += $(common_install_path_implib)
common_clean_files                  += $(common_install_path_static) 
common_clean_files                  += $(common_install_path_shared)
common_clean_files                  += $(common_static_objects)
common_clean_files                  += $(common_shared_objects) 
common_clean_files                  += $(common_depends) 

include $(common_child_makefiles)

$(common_path_curdir)%_static.o: $(common_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(common_path_curdir)%_shared.o: $(common_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(common_install_path_static): | $(common_depends_libs_rules)
$(common_install_path_static): $(common_static_objects)
	ar -rcs $@ $(common_static_objects) $(common_depends_libs_static)

$(common_install_path_shared): | $(common_depends_libs_rules)
$(common_install_path_shared): $(common_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(common_shared_lflags) $(common_shared_objects) $(common_depends_libs_shared)

.PHONY: common_all
common_all: $(common_all_targets) ## build and install all common static and shared libraries
ifneq ($(common_shared_objects),)
common_all: $(common_install_path_shared)
common_all: $(common_install_path_static)
endif

.PHONY: common_clean
common_clean: $(common_clean_targets) ## remove and deinstall all common static and shared libraries
common_clean:
	- $(RM) $(common_clean_files)

.PHONY: common_re
common_re: common_clean
common_re: common_all

.PHONY: common_strip
common_strip: $(common_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
common_strip:
	- strip --strip-all $(common_install_path_shared)

-include $(common_depends)
