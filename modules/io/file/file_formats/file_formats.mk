file_formats_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
file_formats_child_makefiles			:= $(wildcard $(file_formats_path_curdir)*/*mk)
file_formats_child_module_names		:= $(basename $(notdir $(file_formats_child_makefiles)))
file_formats_child_all_targets		:= $(foreach child_module,$(file_formats_child_module_names),$(child_module)_all)
file_formats_child_strip_targets		:= $(foreach child_module,$(file_formats_child_module_names),$(child_module)_strip)
file_formats_child_clean_targets		:= $(foreach child_module,$(file_formats_child_module_names),$(child_module)_clean)
file_formats_install_path_shared		:= $(PATH_INSTALL)/file_formats$(EXT_LIB_SHARED)
file_formats_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
file_formats_install_path_implib		:= $(PATH_INSTALL)/libfile_formatsdll.a
file_formats_shared_lflags			+= -Wl,--out-implib=$(file_formats_install_path_implib)
endif
file_formats_sources					:= $(wildcard $(file_formats_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
file_formats_sources					+= $(wildcard $(file_formats_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
file_formats_sources					+= $(wildcard $(file_formats_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
file_formats_sources					+= $(wildcard $(file_formats_path_curdir)platform_specific/mac/*.c)
endif
file_formats_static_objects			:= $(patsubst %.c, %_static.o, $(file_formats_sources))
file_formats_shared_objects			:= $(patsubst %.c, %_shared.o, $(file_formats_sources))
file_formats_depends					:= $(patsubst %.c, %.d, $(file_formats_sources))
file_formats_depends_modules			:= 
file_formats_depends_libs_shared		:= $(foreach module,$(file_formats_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# file_formats_depends_libs_targets		:= $(foreach module,$(file_formats_depends_modules),$(module)_all)
file_formats_clean_files				:=
file_formats_clean_files				+= $(file_formats_install_path_implib)
file_formats_clean_files				+= $(file_formats_install_path_shared)
file_formats_clean_files				+= $(file_formats_static_objects)
file_formats_clean_files				+= $(file_formats_shared_objects) 
file_formats_clean_files				+= $(file_formats_depends)

include $(file_formats_child_makefiles)

$(file_formats_path_curdir)%_static.o: $(file_formats_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(file_formats_path_curdir)%_shared.o: $(file_formats_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(file_formats_install_path_shared): $(file_formats_depends_libs_shared) $(file_formats_static_objects) $(file_formats_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(file_formats_shared_lflags) $(file_formats_shared_objects) $(file_formats_depends_libs_shared)

.PHONY: file_formats_all
file_formats_all: $(file_formats_child_all_targets) ## build and install all file_formats static and shared libraries
ifneq ($(file_formats_shared_objects),)
file_formats_all: $(file_formats_install_path_shared)
endif

.PHONY: file_formats_clean
file_formats_clean: $(file_formats_child_clean_targets) ## remove and deinstall all file_formats static and shared libraries
file_formats_clean:
	- $(RM) $(file_formats_clean_files)

.PHONY: file_formats_re
file_formats_re: file_formats_clean
file_formats_re: file_formats_all

.PHONY: file_formats_strip
file_formats_strip: $(file_formats_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
file_formats_strip:
	- strip --strip-all $(file_formats_install_path_shared)

-include $(file_formats_depends)
