console_path_curdir                  := $(dir $(lastword $(MAKEFILE_LIST)))
console_name_curdir                  := $(notdir $(patsubst %/,%,$(console_path_curdir)))
console_child_makefiles              := $(wildcard $(console_path_curdir)*/*mk)
console_names                        := $(basename $(notdir $(console_child_makefiles)))
console_all_targets                  := $(foreach console,$(console_names),$(console)_all)
console_strip_targets                := $(foreach console,$(console_names),$(console)_strip)
console_clean_targets                := $(foreach console,$(console_names),$(console)_clean)
console_install_path                 := $(PATH_INSTALL)/$(console_name_curdir)
console_install_path_static          := $(console_install_path)$(EXT_LIB_STATIC)
console_install_path_shared          := $(console_install_path)$(EXT_LIB_SHARED)
console_install_path_implib          :=
console_shared_lflags                := -shared
ifeq ($(PLATFORM), WINDOWS)
console_install_path_implib          := $(PATH_INSTALL)/lib$(console_name_curdir)dll.a
console_shared_lflags                += -Wl,--out-implib=$(console_install_path_implib)
endif
console_sources                      := $(wildcard $(console_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
console_sources                      += $(wildcard $(console_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
console_sources                      += $(wildcard $(console_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
console_sources                      += $(wildcard $(console_path_curdir)platform_specific/mac/*.c)
endif
console_static_objects               := $(patsubst %.c, %_static.o, $(console_sources))
console_shared_objects               := $(patsubst %.c, %_shared.o, $(console_sources))
console_depends                      := $(patsubst %.c, %.d, $(console_sources))
console_depends_modules              := libc common 
console_depends_libs_static_path     = $(foreach module_base,$(console_depends_modules),$($(module_base)_path_curdir))
console_depends_libs_static_src      = $(foreach path,$(console_depends_libs_static_path),$(wildcard $(path)*.c))
ifeq ($(PLATFORM), WINDOWS)
console_depends_libs_static_src      += $(foreach path,$(console_depends_libs_static_path),$(wildcard $(path)platform_specific/windows/*.c))
else ifeq ($(PLATFORM), LINUX)
console_depends_libs_static_src      += $(foreach path,$(console_depends_libs_static_path),$(wildcard $(path)platform_specific/linux/*.c))
else ifeq ($(PLATFORM), MAC)
console_depends_libs_static_src      += $(foreach path,$(console_depends_libs_static_path),$(wildcard $(path)platform_specific/mac/*.c))
endif
console_depends_libs_static          = $(patsubst %.c, %_static.o, $(console_depends_libs_static_src))
console_depends_libs_shared          := $(foreach module,$(console_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
console_depends_libs_rules           := $(foreach module,$(console_depends_modules),$(module)_all)
console_clean_files                  := 
console_clean_files                  += $(console_install_path_implib)
console_clean_files                  += $(console_install_path_static) 
console_clean_files                  += $(console_install_path_shared)
console_clean_files                  += $(console_static_objects)
console_clean_files                  += $(console_shared_objects) 
console_clean_files                  += $(console_depends) 

include $(console_child_makefiles)

$(console_path_curdir)%_static.o: $(console_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(console_path_curdir)%_shared.o: $(console_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(console_install_path_static): | $(console_depends_libs_rules)
$(console_install_path_static): $(console_static_objects)
	ar -rcs $@ $(console_static_objects) $(console_depends_libs_static)

$(console_install_path_shared): | $(console_depends_libs_rules)
$(console_install_path_shared): $(console_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mwindows $(console_shared_lflags) $(console_shared_objects) $(console_depends_libs_shared)

.PHONY: console_all
console_all: $(console_all_targets) ## build and install all console static and shared libraries
ifneq ($(console_shared_objects),)
console_all: $(console_install_path_shared)
console_all: $(console_install_path_static)
endif

.PHONY: console_clean
console_clean: $(console_clean_targets) ## remove and deinstall all console static and shared libraries
console_clean:
	- $(RM) $(console_clean_files)

.PHONY: console_strip
console_strip: $(console_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
console_strip:
	- strip --strip-all $(console_install_path_shared)

-include $(console_depends)
