test_framework_path_curdir                  := $(dir $(lastword $(MAKEFILE_LIST)))
test_framework_name_curdir                  := $(notdir $(patsubst %/,%,$(test_framework_path_curdir)))
test_framework_child_makefiles              := $(wildcard $(test_framework_path_curdir)*/*mk)
test_framework_names                        := $(basename $(notdir $(test_framework_child_makefiles)))
test_framework_all_targets                  := $(foreach test_framework,$(test_framework_names),$(test_framework)_all)
test_framework_strip_targets                := $(foreach test_framework,$(test_framework_names),$(test_framework)_strip)
test_framework_clean_targets                := $(foreach test_framework,$(test_framework_names),$(test_framework)_clean)
test_framework_install_path                 := $(PATH_INSTALL)/$(test_framework_name_curdir)
test_framework_install_path_static          := $(test_framework_install_path)$(EXT_LIB_STATIC)
test_framework_install_path_shared          := $(test_framework_install_path)$(EXT_LIB_SHARED)
test_framework_install_path_implib          :=
test_framework_shared_lflags                := -shared
ifeq ($(PLATFORM), WINDOWS)
test_framework_install_path_implib          := $(PATH_INSTALL)/lib$(test_framework_name_curdir)dll.a
test_framework_shared_lflags                += -Wl,--out-implib=$(test_framework_install_path_implib)
endif
test_framework_sources                      := $(wildcard $(test_framework_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
test_framework_sources                      += $(wildcard $(test_framework_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
test_framework_sources                      += $(wildcard $(test_framework_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
test_framework_sources                      += $(wildcard $(test_framework_path_curdir)platform_specific/mac/*.c)
endif
test_framework_static_objects               := $(patsubst %.c, %_static.o, $(test_framework_sources))
test_framework_shared_objects               := $(patsubst %.c, %_shared.o, $(test_framework_sources))
test_framework_depends                      := $(patsubst %.c, %.d, $(test_framework_sources))
test_framework_depends_modules              :=  common libc
test_framework_depends_libs_static_path     = $(foreach module_base,$(test_framework_depends_modules),$($(module_base)_path_curdir))
test_framework_depends_libs_static_src      = $(foreach path,$(test_framework_depends_libs_static_path),$(wildcard $(path)*.c))
ifeq ($(PLATFORM), WINDOWS)
test_framework_depends_libs_static_src      += $(foreach path,$(test_framework_depends_libs_static_path),$(wildcard $(path)platform_specific/windows/*.c))
else ifeq ($(PLATFORM), LINUX)
test_framework_depends_libs_static_src      += $(foreach path,$(test_framework_depends_libs_static_path),$(wildcard $(path)platform_specific/linux/*.c))
else ifeq ($(PLATFORM), MAC)
test_framework_depends_libs_static_src      += $(foreach path,$(test_framework_depends_libs_static_path),$(wildcard $(path)platform_specific/mac/*.c))
endif
test_framework_depends_libs_static          = $(patsubst %.c, %_static.o, $(test_framework_depends_libs_static_src))
test_framework_depends_libs_shared          := $(foreach module,$(test_framework_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
test_framework_depends_libs_rules           := $(foreach module,$(test_framework_depends_modules),$(module)_all)
test_framework_clean_files                  := 
test_framework_clean_files                  += $(test_framework_install_path_implib)
test_framework_clean_files                  += $(test_framework_install_path_static) 
test_framework_clean_files                  += $(test_framework_install_path_shared)
test_framework_clean_files                  += $(test_framework_static_objects)
test_framework_clean_files                  += $(test_framework_shared_objects) 
test_framework_clean_files                  += $(test_framework_depends) 

include $(test_framework_child_makefiles)

$(test_framework_path_curdir)%_static.o: $(test_framework_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(test_framework_path_curdir)%_shared.o: $(test_framework_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(test_framework_install_path_static): | $(test_framework_depends_libs_rules)
$(test_framework_install_path_static): $(test_framework_static_objects)
	ar -rcs $@ $(test_framework_static_objects) $(test_framework_depends_libs_static)

$(test_framework_install_path_shared): | $(test_framework_depends_libs_rules)
$(test_framework_install_path_shared): $(test_framework_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(test_framework_shared_lflags) $(test_framework_shared_objects) $(test_framework_depends_libs_shared)

.PHONY: test_framework_all
test_framework_all: $(test_framework_all_targets) ## build and install all test_framework static and shared libraries
ifneq ($(test_framework_shared_objects),)
test_framework_all: $(test_framework_install_path_shared)
test_framework_all: $(test_framework_install_path_static)
endif

.PHONY: test_framework_clean
test_framework_clean: $(test_framework_clean_targets) ## remove and deinstall all test_framework static and shared libraries
test_framework_clean:
	- $(RM) $(test_framework_clean_files)

.PHONY: test_framework_re
test_framework_re: test_framework_clean
test_framework_re: test_framework_all

.PHONY: test_framework_strip
test_framework_strip: $(test_framework_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
test_framework_strip:
	- strip --strip-all $(test_framework_install_path_shared)

-include $(test_framework_depends)
