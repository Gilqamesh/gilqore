random_path_curdir                  := $(dir $(lastword $(MAKEFILE_LIST)))
random_name_curdir                  := $(notdir $(patsubst %/,%,$(random_path_curdir)))
random_child_makefiles              := $(wildcard $(random_path_curdir)*/*mk)
random_names                        := $(basename $(notdir $(random_child_makefiles)))
random_all_targets                  := $(foreach random,$(random_names),$(random)_all)
random_strip_targets                := $(foreach random,$(random_names),$(random)_strip)
random_clean_targets                := $(foreach random,$(random_names),$(random)_clean)
random_install_path                 := $(PATH_INSTALL)/$(random_name_curdir)
random_install_path_static          := $(random_install_path)$(EXT_LIB_STATIC)
random_install_path_shared          := $(random_install_path)$(EXT_LIB_SHARED)
random_install_path_implib          :=
random_shared_lflags                := -shared
ifeq ($(PLATFORM), WINDOWS)
random_install_path_implib          := $(PATH_INSTALL)/lib$(random_name_curdir)dll.a
random_shared_lflags                += -Wl,--out-implib=$(random_install_path_implib)
endif
random_sources                      := $(wildcard $(random_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
random_sources                      += $(wildcard $(random_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
random_sources                      += $(wildcard $(random_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
random_sources                      += $(wildcard $(random_path_curdir)platform_specific/mac/*.c)
endif
random_static_objects               := $(patsubst %.c, %_static.o, $(random_sources))
random_shared_objects               := $(patsubst %.c, %_shared.o, $(random_sources))
random_depends                      := $(patsubst %.c, %.d, $(random_sources))
random_depends_modules              :=  
random_depends_libs_static_path     = $(foreach module_base,$(random_depends_modules),$($(module_base)_path_curdir))
random_depends_libs_static_src      = $(foreach path,$(random_depends_libs_static_path),$(wildcard $(path)*.c))
ifeq ($(PLATFORM), WINDOWS)
random_depends_libs_static_src      += $(foreach path,$(random_depends_libs_static_path),$(wildcard $(path)platform_specific/windows/*.c))
else ifeq ($(PLATFORM), LINUX)
random_depends_libs_static_src      += $(foreach path,$(random_depends_libs_static_path),$(wildcard $(path)platform_specific/linux/*.c))
else ifeq ($(PLATFORM), MAC)
random_depends_libs_static_src      += $(foreach path,$(random_depends_libs_static_path),$(wildcard $(path)platform_specific/mac/*.c))
endif
random_depends_libs_static          = $(patsubst %.c, %_static.o, $(random_depends_libs_static_src))
random_depends_libs_shared          := $(foreach module,$(random_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
random_depends_libs_rules           := $(foreach module,$(random_depends_modules),$(module)_all)
random_clean_files                  := 
random_clean_files                  += $(random_install_path_implib)
random_clean_files                  += $(random_install_path_static) 
random_clean_files                  += $(random_install_path_shared)
random_clean_files                  += $(random_static_objects)
random_clean_files                  += $(random_shared_objects) 
random_clean_files                  += $(random_depends) 

include $(random_child_makefiles)

$(random_path_curdir)%_static.o: $(random_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(random_path_curdir)%_shared.o: $(random_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(random_install_path_static): | $(random_depends_libs_rules)
$(random_install_path_static): $(random_static_objects)
	ar -rcs $@ $(random_static_objects) $(random_depends_libs_static)

$(random_install_path_shared): | $(random_depends_libs_rules)
$(random_install_path_shared): $(random_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(random_shared_lflags) $(random_shared_objects) $(random_depends_libs_shared)

.PHONY: random_all
random_all: $(random_all_targets) ## build and install all random static and shared libraries
ifneq ($(random_shared_objects),)
random_all: $(random_install_path_shared)
random_all: $(random_install_path_static)
endif

.PHONY: random_clean
random_clean: $(random_clean_targets) ## remove and deinstall all random static and shared libraries
random_clean:
	- $(RM) $(random_clean_files)

.PHONY: random_re
random_re: random_clean
random_re: random_all

.PHONY: random_strip
random_strip: $(random_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
random_strip:
	- strip --strip-all $(random_install_path_shared)

-include $(random_depends)
