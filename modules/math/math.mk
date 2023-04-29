math_path_curdir                  := $(dir $(lastword $(MAKEFILE_LIST)))
math_name_curdir                  := $(notdir $(patsubst %/,%,$(math_path_curdir)))
math_child_makefiles              := $(wildcard $(math_path_curdir)*/*mk)
math_names                        := $(basename $(notdir $(math_child_makefiles)))
math_all_targets                  := $(foreach math,$(math_names),$(math)_all)
math_strip_targets                := $(foreach math,$(math_names),$(math)_strip)
math_clean_targets                := $(foreach math,$(math_names),$(math)_clean)
math_install_path                 := $(PATH_INSTALL)/$(math_name_curdir)
math_install_path_static          := $(math_install_path)$(EXT_LIB_STATIC)
math_install_path_shared          := $(math_install_path)$(EXT_LIB_SHARED)
math_install_path_implib          :=
math_shared_lflags                := -shared
ifeq ($(PLATFORM), WINDOWS)
math_install_path_implib          := $(PATH_INSTALL)/lib$(math_name_curdir)dll.a
math_shared_lflags                += -Wl,--out-implib=$(math_install_path_implib)
endif
math_sources                      := $(wildcard $(math_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
math_sources                      += $(wildcard $(math_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
math_sources                      += $(wildcard $(math_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
math_sources                      += $(wildcard $(math_path_curdir)platform_specific/mac/*.c)
endif
math_static_objects               := $(patsubst %.c, %_static.o, $(math_sources))
math_shared_objects               := $(patsubst %.c, %_shared.o, $(math_sources))
math_depends                      := $(patsubst %.c, %.d, $(math_sources))
math_depends_modules              :=  
math_depends_libs_static_path     = $(foreach module_base,$(math_depends_modules),$($(module_base)_path_curdir))
math_depends_libs_static_src      = $(foreach path,$(math_depends_libs_static_path),$(wildcard $(path)*.c))
ifeq ($(PLATFORM), WINDOWS)
math_depends_libs_static_src      += $(foreach path,$(math_depends_libs_static_path),$(wildcard $(path)platform_specific/windows/*.c))
else ifeq ($(PLATFORM), LINUX)
math_depends_libs_static_src      += $(foreach path,$(math_depends_libs_static_path),$(wildcard $(path)platform_specific/linux/*.c))
else ifeq ($(PLATFORM), MAC)
math_depends_libs_static_src      += $(foreach path,$(math_depends_libs_static_path),$(wildcard $(path)platform_specific/mac/*.c))
endif
math_depends_libs_static          = $(patsubst %.c, %_static.o, $(math_depends_libs_static_src))
math_depends_libs_shared          := $(foreach module,$(math_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
math_depends_libs_rules           := $(foreach module,$(math_depends_modules),$(module)_all)
math_clean_files                  := 
math_clean_files                  += $(math_install_path_implib)
math_clean_files                  += $(math_install_path_static) 
math_clean_files                  += $(math_install_path_shared)
math_clean_files                  += $(math_static_objects)
math_clean_files                  += $(math_shared_objects) 
math_clean_files                  += $(math_depends) 

include $(math_child_makefiles)

$(math_path_curdir)%_static.o: $(math_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(math_path_curdir)%_shared.o: $(math_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(math_install_path_static): | $(math_depends_libs_rules)
$(math_install_path_static): $(math_static_objects)
	ar -rcs $@ $(math_static_objects) $(math_depends_libs_static)

$(math_install_path_shared): | $(math_depends_libs_rules)
$(math_install_path_shared): $(math_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(math_shared_lflags) $(math_shared_objects) $(math_depends_libs_shared)

.PHONY: math_all
math_all: $(math_all_targets) ## build and install all math static and shared libraries
ifneq ($(math_shared_objects),)
math_all: $(math_install_path_shared)
math_all: $(math_install_path_static)
endif

.PHONY: math_clean
math_clean: $(math_clean_targets) ## remove and deinstall all math static and shared libraries
math_clean:
	- $(RM) $(math_clean_files)

.PHONY: math_re
math_re: math_clean
math_re: math_all

.PHONY: math_strip
math_strip: $(math_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
math_strip:
	- strip --strip-all $(math_install_path_shared)

-include $(math_depends)
