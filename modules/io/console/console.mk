console_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
console_child_makefiles			:= $(wildcard $(console_path_curdir)*/*mk)
console_child_module_names		:= $(basename $(notdir $(console_child_makefiles)))
console_child_all_targets		:= $(foreach child_module,$(console_child_module_names),$(child_module)_all)
console_child_strip_targets		:= $(foreach child_module,$(console_child_module_names),$(child_module)_strip)
console_child_clean_targets		:= $(foreach child_module,$(console_child_module_names),$(child_module)_clean)
console_install_path_shared		:= $(PATH_INSTALL)/console$(EXT_LIB_SHARED)
console_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
console_install_path_implib		:= $(PATH_INSTALL)/libconsoledll.a
console_shared_lflags			+= -Wl,--out-implib=$(console_install_path_implib)
endif
console_sources					:= $(wildcard $(console_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
console_sources					+= $(wildcard $(console_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
console_sources					+= $(wildcard $(console_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
console_sources					+= $(wildcard $(console_path_curdir)platform_specific/mac/*.c)
endif
console_static_objects			:= $(patsubst %.c, %_static.o, $(console_sources))
console_shared_objects			:= $(patsubst %.c, %_shared.o, $(console_sources))
console_depends					:= $(patsubst %.c, %.d, $(console_sources))
console_depends_modules			:= 
console_depends_libs_shared		:= $(foreach module,$(console_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# console_depends_libs_targets		:= $(foreach module,$(console_depends_modules),$(module)_all)
console_clean_files				:=
console_clean_files				+= $(console_install_path_implib)
console_clean_files				+= $(console_install_path_shared)
console_clean_files				+= $(console_static_objects)
console_clean_files				+= $(console_shared_objects) 
console_clean_files				+= $(console_depends)

include $(console_child_makefiles)

$(console_path_curdir)%_static.o: $(console_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(console_path_curdir)%_shared.o: $(console_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(console_install_path_shared): $(console_depends_libs_shared) $(console_static_objects) $(console_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(console_shared_lflags) $(console_shared_objects) $(console_depends_libs_shared)

.PHONY: console_all
console_all: $(console_child_all_targets) ## build and install all console static and shared libraries
ifneq ($(console_shared_objects),)
console_all: $(console_install_path_shared)
endif

.PHONY: console_clean
console_clean: $(console_child_clean_targets) ## remove and deinstall all console static and shared libraries
console_clean:
	- $(RM) $(console_clean_files)

.PHONY: console_re
console_re: console_clean
console_re: console_all

.PHONY: console_strip
console_strip: $(console_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
console_strip:
	- strip --strip-all $(console_install_path_shared)

-include $(console_depends)
