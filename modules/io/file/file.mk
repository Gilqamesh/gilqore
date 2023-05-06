file_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
file_child_makefiles			:= $(wildcard $(file_path_curdir)*/*mk)
file_child_module_names		:= $(basename $(notdir $(file_child_makefiles)))
file_child_all_targets		:= $(foreach child_module,$(file_child_module_names),$(child_module)_all)
file_child_strip_targets		:= $(foreach child_module,$(file_child_module_names),$(child_module)_strip)
file_child_clean_targets		:= $(foreach child_module,$(file_child_module_names),$(child_module)_clean)
file_install_path_shared		:= $(PATH_INSTALL)/file$(EXT_LIB_SHARED)
file_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
file_install_path_implib		:= $(PATH_INSTALL)/libfiledll.a
file_shared_lflags			+= -Wl,--out-implib=$(file_install_path_implib)
endif
file_sources					:= $(wildcard $(file_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
file_sources					+= $(wildcard $(file_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
file_sources					+= $(wildcard $(file_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
file_sources					+= $(wildcard $(file_path_curdir)platform_specific/mac/*.c)
endif
file_static_objects			:= $(patsubst %.c, %_static.o, $(file_sources))
file_shared_objects			:= $(patsubst %.c, %_shared.o, $(file_sources))
file_depends					:= $(patsubst %.c, %.d, $(file_sources))
file_depends_modules			:= common time
file_depends_libs_shared		:= $(foreach module,$(file_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
file_depends_libs_targets		:= $(foreach module,$(file_depends_modules),$(module)_all)
file_clean_files				:=
file_clean_files				+= $(file_install_path_implib)
file_clean_files				+= $(file_install_path_shared)
file_clean_files				+= $(file_static_objects)
file_clean_files				+= $(file_shared_objects) 
file_clean_files				+= $(file_depends)

include $(file_child_makefiles)

$(file_path_curdir)%_static.o: $(file_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(file_path_curdir)%_shared.o: $(file_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(file_install_path_shared): $(file_depends_libs_shared)
$(file_install_path_shared): $(file_static_objects)
$(file_install_path_shared): $(file_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(file_shared_lflags) $(file_shared_objects) $(file_depends_libs_shared)

.PHONY: file_all
file_all: $(file_child_all_targets) ## build and install all file static and shared libraries
ifneq ($(file_shared_objects),)
file_all: $(file_install_path_shared)
endif

.PHONY: file_clean
file_clean: $(file_child_clean_targets) ## remove and deinstall all file static and shared libraries
file_clean:
	- $(RM) $(file_clean_files)

.PHONY: file_re
file_re: file_clean
file_re: file_all

.PHONY: file_strip
file_strip: $(file_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
file_strip:
	- strip --strip-all $(file_install_path_shared)

-include $(file_depends)
