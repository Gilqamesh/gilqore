mod_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
mod_child_makefiles			:= $(wildcard $(mod_path_curdir)*/*mk)
mod_child_module_names		:= $(basename $(notdir $(mod_child_makefiles)))
mod_child_all_targets		:= $(foreach child_module,$(mod_child_module_names),$(child_module)_all)
mod_child_strip_targets		:= $(foreach child_module,$(mod_child_module_names),$(child_module)_strip)
mod_child_clean_targets		:= $(foreach child_module,$(mod_child_module_names),$(child_module)_clean)
mod_install_path_shared		:= $(PATH_INSTALL)/mod$(EXT_LIB_SHARED)
mod_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
mod_install_path_implib		:= $(PATH_INSTALL)/libmoddll.a
mod_shared_lflags			+= -Wl,--out-implib=$(mod_install_path_implib)
endif
mod_sources					:= $(wildcard $(mod_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
mod_sources					+= $(wildcard $(mod_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
mod_sources					+= $(wildcard $(mod_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
mod_sources					+= $(wildcard $(mod_path_curdir)platform_specific/mac/*.c)
endif
mod_static_objects			:= $(patsubst %.c, %_static.o, $(mod_sources))
mod_shared_objects			:= $(patsubst %.c, %_shared.o, $(mod_sources))
mod_depends					:= $(patsubst %.c, %.d, $(mod_sources))
mod_depends_modules			:=  
mod_depends_libs_shared		:= $(foreach module,$(mod_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
mod_depends_libs_targets		:= $(foreach module,$(mod_depends_modules),$(module)_all)
mod_clean_files				:=
mod_clean_files				+= $(mod_install_path_implib)
mod_clean_files				+= $(mod_install_path_shared)
mod_clean_files				+= $(mod_static_objects)
mod_clean_files				+= $(mod_shared_objects) 
mod_clean_files				+= $(mod_depends)

include $(mod_child_makefiles)

$(mod_path_curdir)%_static.o: $(mod_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(mod_path_curdir)%_shared.o: $(mod_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(mod_install_path_shared): $(mod_depends_libs_shared)
$(mod_install_path_shared): $(mod_static_objects)
$(mod_install_path_shared): $(mod_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(mod_shared_lflags) $(mod_shared_objects) $(mod_depends_libs_shared)

.PHONY: mod_all
mod_all: $(mod_child_all_targets) ## build and install all mod static and shared libraries
ifneq ($(mod_shared_objects),)
mod_all: $(mod_install_path_shared)
endif

.PHONY: mod_clean
mod_clean: $(mod_child_clean_targets) ## remove and deinstall all mod static and shared libraries
mod_clean:
	- $(RM) $(mod_clean_files)

.PHONY: mod_re
mod_re: mod_clean
mod_re: mod_all

.PHONY: mod_strip
mod_strip: $(mod_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
mod_strip:
	- strip --strip-all $(mod_install_path_shared)

-include $(mod_depends)
