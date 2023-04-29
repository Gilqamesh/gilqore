sqrt_path_curdir                  := $(dir $(lastword $(MAKEFILE_LIST)))
sqrt_name_curdir                  := $(notdir $(patsubst %/,%,$(sqrt_path_curdir)))
sqrt_child_makefiles              := $(wildcard $(sqrt_path_curdir)*/*mk)
sqrt_names                        := $(basename $(notdir $(sqrt_child_makefiles)))
sqrt_all_targets                  := $(foreach sqrt,$(sqrt_names),$(sqrt)_all)
sqrt_strip_targets                := $(foreach sqrt,$(sqrt_names),$(sqrt)_strip)
sqrt_clean_targets                := $(foreach sqrt,$(sqrt_names),$(sqrt)_clean)
sqrt_install_path                 := $(PATH_INSTALL)/$(sqrt_name_curdir)
sqrt_install_path_static          := $(sqrt_install_path)$(EXT_LIB_STATIC)
sqrt_install_path_shared          := $(sqrt_install_path)$(EXT_LIB_SHARED)
sqrt_install_path_implib          :=
sqrt_shared_lflags                := -shared
ifeq ($(PLATFORM), WINDOWS)
sqrt_install_path_implib          := $(PATH_INSTALL)/lib$(sqrt_name_curdir)dll.a
sqrt_shared_lflags                += -Wl,--out-implib=$(sqrt_install_path_implib)
endif
sqrt_sources                      := $(wildcard $(sqrt_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
sqrt_sources                      += $(wildcard $(sqrt_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
sqrt_sources                      += $(wildcard $(sqrt_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
sqrt_sources                      += $(wildcard $(sqrt_path_curdir)platform_specific/mac/*.c)
endif
sqrt_static_objects               := $(patsubst %.c, %_static.o, $(sqrt_sources))
sqrt_shared_objects               := $(patsubst %.c, %_shared.o, $(sqrt_sources))
sqrt_depends                      := $(patsubst %.c, %.d, $(sqrt_sources))
sqrt_depends_modules              :=  
sqrt_depends_libs_static_path     = $(foreach module_base,$(sqrt_depends_modules),$($(module_base)_path_curdir))
sqrt_depends_libs_static_src      = $(foreach path,$(sqrt_depends_libs_static_path),$(wildcard $(path)*.c))
ifeq ($(PLATFORM), WINDOWS)
sqrt_depends_libs_static_src      += $(foreach path,$(sqrt_depends_libs_static_path),$(wildcard $(path)platform_specific/windows/*.c))
else ifeq ($(PLATFORM), LINUX)
sqrt_depends_libs_static_src      += $(foreach path,$(sqrt_depends_libs_static_path),$(wildcard $(path)platform_specific/linux/*.c))
else ifeq ($(PLATFORM), MAC)
sqrt_depends_libs_static_src      += $(foreach path,$(sqrt_depends_libs_static_path),$(wildcard $(path)platform_specific/mac/*.c))
endif
sqrt_depends_libs_static          = $(patsubst %.c, %_static.o, $(sqrt_depends_libs_static_src))
sqrt_depends_libs_shared          := $(foreach module,$(sqrt_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
sqrt_depends_libs_rules           := $(foreach module,$(sqrt_depends_modules),$(module)_all)
sqrt_clean_files                  := 
sqrt_clean_files                  += $(sqrt_install_path_implib)
sqrt_clean_files                  += $(sqrt_install_path_static) 
sqrt_clean_files                  += $(sqrt_install_path_shared)
sqrt_clean_files                  += $(sqrt_static_objects)
sqrt_clean_files                  += $(sqrt_shared_objects) 
sqrt_clean_files                  += $(sqrt_depends) 

include $(sqrt_child_makefiles)

$(sqrt_path_curdir)%_static.o: $(sqrt_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(sqrt_path_curdir)%_shared.o: $(sqrt_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(sqrt_install_path_static): | $(sqrt_depends_libs_rules)
$(sqrt_install_path_static): $(sqrt_static_objects)
	ar -rcs $@ $(sqrt_static_objects) $(sqrt_depends_libs_static)

$(sqrt_install_path_shared): | $(sqrt_depends_libs_rules)
$(sqrt_install_path_shared): $(sqrt_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(sqrt_shared_lflags) $(sqrt_shared_objects) $(sqrt_depends_libs_shared)

.PHONY: sqrt_all
sqrt_all: $(sqrt_all_targets) ## build and install all sqrt static and shared libraries
ifneq ($(sqrt_shared_objects),)
sqrt_all: $(sqrt_install_path_shared)
sqrt_all: $(sqrt_install_path_static)
endif

.PHONY: sqrt_clean
sqrt_clean: $(sqrt_clean_targets) ## remove and deinstall all sqrt static and shared libraries
sqrt_clean:
	- $(RM) $(sqrt_clean_files)

.PHONY: sqrt_re
sqrt_re: sqrt_clean
sqrt_re: sqrt_all

.PHONY: sqrt_strip
sqrt_strip: $(sqrt_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
sqrt_strip:
	- strip --strip-all $(sqrt_install_path_shared)

-include $(sqrt_depends)
