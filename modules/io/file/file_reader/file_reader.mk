file_reader_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
file_reader_child_makefiles			:= $(wildcard $(file_reader_path_curdir)*/*mk)
file_reader_child_module_names		:= $(basename $(notdir $(file_reader_child_makefiles)))
file_reader_child_all_targets		:= $(foreach child_module,$(file_reader_child_module_names),$(child_module)_all)
file_reader_child_strip_targets		:= $(foreach child_module,$(file_reader_child_module_names),$(child_module)_strip)
file_reader_child_clean_targets		:= $(foreach child_module,$(file_reader_child_module_names),$(child_module)_clean)
file_reader_install_path_shared		:= $(PATH_INSTALL)/file_reader$(EXT_LIB_SHARED)
file_reader_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
file_reader_install_path_implib		:= $(PATH_INSTALL)/libfile_readerdll.a
file_reader_shared_lflags			+= -Wl,--out-implib=$(file_reader_install_path_implib)
endif
file_reader_sources					:= $(wildcard $(file_reader_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
file_reader_sources					+= $(wildcard $(file_reader_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
file_reader_sources					+= $(wildcard $(file_reader_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
file_reader_sources					+= $(wildcard $(file_reader_path_curdir)platform_specific/mac/*.c)
endif
file_reader_static_objects			:= $(patsubst %.c, %_static.o, $(file_reader_sources))
file_reader_shared_objects			:= $(patsubst %.c, %_shared.o, $(file_reader_sources))
file_reader_depends					:= $(patsubst %.c, %.d, $(file_reader_sources))
file_reader_depends_modules			:=  circular_buffer compare file
file_reader_depends_libs_shared		:= $(foreach module,$(file_reader_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
file_reader_depends_libs_targets		:= $(foreach module,$(file_reader_depends_modules),$(module)_all)
file_reader_clean_files				:=
file_reader_clean_files				+= $(file_reader_install_path_implib)
file_reader_clean_files				+= $(file_reader_install_path_shared)
file_reader_clean_files				+= $(file_reader_static_objects)
file_reader_clean_files				+= $(file_reader_shared_objects) 
file_reader_clean_files				+= $(file_reader_depends)

include $(file_reader_child_makefiles)

$(file_reader_path_curdir)%_static.o: $(file_reader_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(file_reader_path_curdir)%_shared.o: $(file_reader_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(file_reader_install_path_shared): $(file_reader_depends_libs_shared)
$(file_reader_install_path_shared): $(file_reader_static_objects)
$(file_reader_install_path_shared): $(file_reader_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(file_reader_shared_lflags) $(file_reader_shared_objects) $(file_reader_depends_libs_shared)

.PHONY: file_reader_all
file_reader_all: $(file_reader_child_all_targets) ## build and install all file_reader static and shared libraries
ifneq ($(file_reader_shared_objects),)
file_reader_all: $(file_reader_install_path_shared)
endif

.PHONY: file_reader_clean
file_reader_clean: $(file_reader_child_clean_targets) ## remove and deinstall all file_reader static and shared libraries
file_reader_clean:
	- $(RM) $(file_reader_clean_files)

.PHONY: file_reader_re
file_reader_re: file_reader_clean
file_reader_re: file_reader_all

.PHONY: file_reader_strip
file_reader_strip: $(file_reader_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
file_reader_strip:
	- strip --strip-all $(file_reader_install_path_shared)

-include $(file_reader_depends)
