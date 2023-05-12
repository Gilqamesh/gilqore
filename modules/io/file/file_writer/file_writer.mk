file_writer_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
file_writer_child_makefiles			:= $(wildcard $(file_writer_path_curdir)*/*mk)
file_writer_child_module_names		:= $(basename $(notdir $(file_writer_child_makefiles)))
file_writer_child_all_targets		:= $(foreach child_module,$(file_writer_child_module_names),$(child_module)_all)
file_writer_child_strip_targets		:= $(foreach child_module,$(file_writer_child_module_names),$(child_module)_strip)
file_writer_child_clean_targets		:= $(foreach child_module,$(file_writer_child_module_names),$(child_module)_clean)
file_writer_install_path_shared		:= $(PATH_INSTALL)/file_writer$(EXT_LIB_SHARED)
file_writer_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
file_writer_install_path_implib		:= $(PATH_INSTALL)/libfile_writerdll.a
file_writer_shared_lflags			+= -Wl,--out-implib=$(file_writer_install_path_implib)
endif
file_writer_sources					:= $(wildcard $(file_writer_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
file_writer_sources					+= $(wildcard $(file_writer_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
file_writer_sources					+= $(wildcard $(file_writer_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
file_writer_sources					+= $(wildcard $(file_writer_path_curdir)platform_specific/mac/*.c)
endif
file_writer_static_objects			:= $(patsubst %.c, %_static.o, $(file_writer_sources))
file_writer_shared_objects			:= $(patsubst %.c, %_shared.o, $(file_writer_sources))
file_writer_depends					:= $(patsubst %.c, %.d, $(file_writer_sources))
file_writer_depends_modules			:= libc common file time 
file_writer_depends_libs_shared		:= $(foreach module,$(file_writer_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# file_writer_depends_libs_targets		:= $(foreach module,$(file_writer_depends_modules),$(module)_all)
file_writer_clean_files				:=
file_writer_clean_files				+= $(file_writer_install_path_implib)
file_writer_clean_files				+= $(file_writer_install_path_shared)
file_writer_clean_files				+= $(file_writer_static_objects)
file_writer_clean_files				+= $(file_writer_shared_objects) 
file_writer_clean_files				+= $(file_writer_depends)

include $(file_writer_child_makefiles)

$(file_writer_path_curdir)%_static.o: $(file_writer_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(file_writer_path_curdir)%_shared.o: $(file_writer_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(file_writer_install_path_shared): $(file_writer_depends_libs_shared) $(file_writer_static_objects) $(file_writer_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(file_writer_shared_lflags) $(file_writer_shared_objects) $(file_writer_depends_libs_shared)

.PHONY: file_writer_all
file_writer_all: $(file_writer_child_all_targets) ## build and install all file_writer static and shared libraries
ifneq ($(file_writer_shared_objects),)
file_writer_all: $(file_writer_install_path_shared)
endif

.PHONY: file_writer_clean
file_writer_clean: $(file_writer_child_clean_targets) ## remove and deinstall all file_writer static and shared libraries
file_writer_clean:
	- $(RM) $(file_writer_clean_files)

.PHONY: file_writer_re
file_writer_re: file_writer_clean
file_writer_re: file_writer_all

.PHONY: file_writer_strip
file_writer_strip: $(file_writer_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
file_writer_strip:
	- strip --strip-all $(file_writer_install_path_shared)

-include $(file_writer_depends)
