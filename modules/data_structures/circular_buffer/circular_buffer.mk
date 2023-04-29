circular_buffer_path_curdir                  := $(dir $(lastword $(MAKEFILE_LIST)))
circular_buffer_name_curdir                  := $(notdir $(patsubst %/,%,$(circular_buffer_path_curdir)))
circular_buffer_child_makefiles              := $(wildcard $(circular_buffer_path_curdir)*/*mk)
circular_buffer_names                        := $(basename $(notdir $(circular_buffer_child_makefiles)))
circular_buffer_all_targets                  := $(foreach circular_buffer,$(circular_buffer_names),$(circular_buffer)_all)
circular_buffer_strip_targets                := $(foreach circular_buffer,$(circular_buffer_names),$(circular_buffer)_strip)
circular_buffer_clean_targets                := $(foreach circular_buffer,$(circular_buffer_names),$(circular_buffer)_clean)
circular_buffer_install_path                 := $(PATH_INSTALL)/$(circular_buffer_name_curdir)
circular_buffer_install_path_static          := $(circular_buffer_install_path)$(EXT_LIB_STATIC)
circular_buffer_install_path_shared          := $(circular_buffer_install_path)$(EXT_LIB_SHARED)
circular_buffer_install_path_implib          :=
circular_buffer_shared_lflags                := -shared
ifeq ($(PLATFORM), WINDOWS)
circular_buffer_install_path_implib          := $(PATH_INSTALL)/lib$(circular_buffer_name_curdir)dll.a
circular_buffer_shared_lflags                += -Wl,--out-implib=$(circular_buffer_install_path_implib)
endif
circular_buffer_sources                      := $(wildcard $(circular_buffer_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
circular_buffer_sources                      += $(wildcard $(circular_buffer_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
circular_buffer_sources                      += $(wildcard $(circular_buffer_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
circular_buffer_sources                      += $(wildcard $(circular_buffer_path_curdir)platform_specific/mac/*.c)
endif
circular_buffer_static_objects               := $(patsubst %.c, %_static.o, $(circular_buffer_sources))
circular_buffer_shared_objects               := $(patsubst %.c, %_shared.o, $(circular_buffer_sources))
circular_buffer_depends                      := $(patsubst %.c, %.d, $(circular_buffer_sources))
circular_buffer_depends_modules              :=  libc common compare mod
circular_buffer_depends_libs_static_path     = $(foreach module_base,$(circular_buffer_depends_modules),$($(module_base)_path_curdir))
circular_buffer_depends_libs_static_src      = $(foreach path,$(circular_buffer_depends_libs_static_path),$(wildcard $(path)*.c))
ifeq ($(PLATFORM), WINDOWS)
circular_buffer_depends_libs_static_src      += $(foreach path,$(circular_buffer_depends_libs_static_path),$(wildcard $(path)platform_specific/windows/*.c))
else ifeq ($(PLATFORM), LINUX)
circular_buffer_depends_libs_static_src      += $(foreach path,$(circular_buffer_depends_libs_static_path),$(wildcard $(path)platform_specific/linux/*.c))
else ifeq ($(PLATFORM), MAC)
circular_buffer_depends_libs_static_src      += $(foreach path,$(circular_buffer_depends_libs_static_path),$(wildcard $(path)platform_specific/mac/*.c))
endif
circular_buffer_depends_libs_static          = $(patsubst %.c, %_static.o, $(circular_buffer_depends_libs_static_src))
circular_buffer_depends_libs_shared          := $(foreach module,$(circular_buffer_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
circular_buffer_depends_libs_rules           := $(foreach module,$(circular_buffer_depends_modules),$(module)_all)
circular_buffer_clean_files                  := 
circular_buffer_clean_files                  += $(circular_buffer_install_path_implib)
circular_buffer_clean_files                  += $(circular_buffer_install_path_static) 
circular_buffer_clean_files                  += $(circular_buffer_install_path_shared)
circular_buffer_clean_files                  += $(circular_buffer_static_objects)
circular_buffer_clean_files                  += $(circular_buffer_shared_objects) 
circular_buffer_clean_files                  += $(circular_buffer_depends) 

include $(circular_buffer_child_makefiles)

$(circular_buffer_path_curdir)%_static.o: $(circular_buffer_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(circular_buffer_path_curdir)%_shared.o: $(circular_buffer_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(circular_buffer_install_path_static): | $(circular_buffer_depends_libs_rules)
$(circular_buffer_install_path_static): $(circular_buffer_static_objects)
	ar -rcs $@ $(circular_buffer_static_objects) $(circular_buffer_depends_libs_static)

$(circular_buffer_install_path_shared): | $(circular_buffer_depends_libs_rules)
$(circular_buffer_install_path_shared): $(circular_buffer_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(circular_buffer_shared_lflags) $(circular_buffer_shared_objects) $(circular_buffer_depends_libs_shared)

.PHONY: circular_buffer_all
circular_buffer_all: $(circular_buffer_all_targets) ## build and install all circular_buffer static and shared libraries
ifneq ($(circular_buffer_shared_objects),)
circular_buffer_all: $(circular_buffer_install_path_shared)
circular_buffer_all: $(circular_buffer_install_path_static)
endif

.PHONY: circular_buffer_clean
circular_buffer_clean: $(circular_buffer_clean_targets) ## remove and deinstall all circular_buffer static and shared libraries
circular_buffer_clean:
	- $(RM) $(circular_buffer_clean_files)

.PHONY: circular_buffer_re
circular_buffer_re: circular_buffer_clean
circular_buffer_re: circular_buffer_all

.PHONY: circular_buffer_strip
circular_buffer_strip: $(circular_buffer_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
circular_buffer_strip:
	- strip --strip-all $(circular_buffer_install_path_shared)

-include $(circular_buffer_depends)
