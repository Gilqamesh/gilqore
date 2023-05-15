file_path_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
file_path_child_makefiles			:= $(wildcard $(file_path_path_curdir)*/*mk)
file_path_child_module_names		:= $(basename $(notdir $(file_path_child_makefiles)))
file_path_child_all_targets		:= $(foreach child_module,$(file_path_child_module_names),$(child_module)_all)
file_path_child_strip_targets		:= $(foreach child_module,$(file_path_child_module_names),$(child_module)_strip)
file_path_child_clean_targets		:= $(foreach child_module,$(file_path_child_module_names),$(child_module)_clean)
file_path_install_path_shared		:= $(PATH_INSTALL)/file_path$(EXT_LIB_SHARED)
file_path_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
file_path_install_path_implib		:= $(PATH_INSTALL)/libfile_pathdll.a
file_path_shared_lflags			+= -Wl,--out-implib=$(file_path_install_path_implib)
endif
file_path_sources					:= $(wildcard $(file_path_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
file_path_sources					+= $(wildcard $(file_path_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
file_path_sources					+= $(wildcard $(file_path_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
file_path_sources					+= $(wildcard $(file_path_path_curdir)platform_specific/mac/*.c)
endif
file_path_static_objects			:= $(patsubst %.c, %_static.o, $(file_path_sources))
file_path_shared_objects			:= $(patsubst %.c, %_shared.o, $(file_path_sources))
file_path_depends					:= $(patsubst %.c, %.d, $(file_path_sources))
file_path_depends_modules			:= libc common 
file_path_depends_libs_shared		:= $(foreach module,$(file_path_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# file_path_depends_libs_targets		:= $(foreach module,$(file_path_depends_modules),$(module)_all)
file_path_clean_files				:=
file_path_clean_files				+= $(file_path_install_path_implib)
file_path_clean_files				+= $(file_path_install_path_shared)
file_path_clean_files				+= $(file_path_static_objects)
file_path_clean_files				+= $(file_path_shared_objects) 
file_path_clean_files				+= $(file_path_depends)

include $(file_path_child_makefiles)

$(file_path_path_curdir)%_static.o: $(file_path_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(file_path_path_curdir)%_shared.o: $(file_path_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(file_path_install_path_shared): $(file_path_depends_libs_shared) $(file_path_static_objects) $(file_path_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(file_path_shared_lflags) $(file_path_shared_objects) $(file_path_depends_libs_shared)

.PHONY: file_path_all
file_path_all: $(file_path_child_all_targets) ## build and install all file_path static and shared libraries
ifneq ($(file_path_shared_objects),)
file_path_all: $(file_path_install_path_shared)
endif

.PHONY: file_path_clean
file_path_clean: $(file_path_child_clean_targets) ## remove and deinstall all file_path static and shared libraries
file_path_clean:
	- $(RM) $(file_path_clean_files)

.PHONY: file_path_re
file_path_re: file_path_clean
file_path_re: file_path_all

.PHONY: file_path_strip
file_path_strip: $(file_path_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
file_path_strip:
	- strip --strip-all $(file_path_install_path_shared)

-include $(file_path_depends)
