module_compiler_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
module_compiler_child_makefiles			:= $(wildcard $(module_compiler_path_curdir)*/*mk)
module_compiler_child_module_names		:= $(basename $(notdir $(module_compiler_child_makefiles)))
module_compiler_child_all_targets		:= $(foreach child_module,$(module_compiler_child_module_names),$(child_module)_all)
module_compiler_child_strip_targets		:= $(foreach child_module,$(module_compiler_child_module_names),$(child_module)_strip)
module_compiler_child_clean_targets		:= $(foreach child_module,$(module_compiler_child_module_names),$(child_module)_clean)
module_compiler_install_path_shared		:= $(PATH_INSTALL)/module_compiler$(EXT_LIB_SHARED)
module_compiler_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
module_compiler_install_path_implib		:= $(PATH_INSTALL)/libmodule_compilerdll.a
module_compiler_shared_lflags			+= -Wl,--out-implib=$(module_compiler_install_path_implib)
endif
module_compiler_sources					:= $(wildcard $(module_compiler_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
module_compiler_sources					+= $(wildcard $(module_compiler_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
module_compiler_sources					+= $(wildcard $(module_compiler_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
module_compiler_sources					+= $(wildcard $(module_compiler_path_curdir)platform_specific/mac/*.c)
endif
module_compiler_static_objects			:= $(patsubst %.c, %_static.o, $(module_compiler_sources))
module_compiler_shared_objects			:= $(patsubst %.c, %_shared.o, $(module_compiler_sources))
module_compiler_depends					:= $(patsubst %.c, %.d, $(module_compiler_sources))
module_compiler_depends_modules			:= file common time libc file_reader hash compare circular_buffer mod file_writer string directory string_replacer 
module_compiler_depends_libs_shared		:= $(foreach module,$(module_compiler_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# module_compiler_depends_libs_targets		:= $(foreach module,$(module_compiler_depends_modules),$(module)_all)
module_compiler_clean_files				:=
module_compiler_clean_files				+= $(module_compiler_install_path_implib)
module_compiler_clean_files				+= $(module_compiler_install_path_shared)
module_compiler_clean_files				+= $(module_compiler_static_objects)
module_compiler_clean_files				+= $(module_compiler_shared_objects) 
module_compiler_clean_files				+= $(module_compiler_depends)

include $(module_compiler_child_makefiles)

$(module_compiler_path_curdir)%_static.o: $(module_compiler_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(module_compiler_path_curdir)%_shared.o: $(module_compiler_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(module_compiler_install_path_shared): $(module_compiler_depends_libs_shared) $(module_compiler_static_objects) $(module_compiler_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON)  $(module_compiler_shared_lflags) $(module_compiler_shared_objects) $(module_compiler_depends_libs_shared)

.PHONY: module_compiler_all
module_compiler_all: $(module_compiler_child_all_targets) ## build and install all module_compiler static and shared libraries
ifneq ($(module_compiler_shared_objects),)
module_compiler_all: $(module_compiler_install_path_shared)
endif

.PHONY: module_compiler_clean
module_compiler_clean: $(module_compiler_child_clean_targets) ## remove and deinstall all module_compiler static and shared libraries
module_compiler_clean:
	- $(RM) $(module_compiler_clean_files)

.PHONY: module_compiler_re
module_compiler_re: module_compiler_clean
module_compiler_re: module_compiler_all

.PHONY: module_compiler_strip
module_compiler_strip: $(module_compiler_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
module_compiler_strip:
	- strip --strip-all $(module_compiler_install_path_shared)

-include $(module_compiler_depends)
