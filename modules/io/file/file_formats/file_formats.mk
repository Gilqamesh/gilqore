file_formats_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
file_formats_path_curtestdir			:= $(file_formats_path_curdir)test/
file_formats_child_makefiles			:= $(wildcard $(file_formats_path_curdir)*/*mk)
file_formats_child_module_names		:= $(basename $(notdir $(file_formats_child_makefiles)))
file_formats_child_all_targets		:= $(foreach child_module,$(file_formats_child_module_names),$(child_module)_all)
file_formats_child_clean_targets		:= $(foreach child_module,$(file_formats_child_module_names),$(child_module)_clean)
file_formats_test_child_all_targets	:= $(foreach test_module,$(file_formats_child_module_names),$(test_module)_test_all)
file_formats_test_child_clean_targets	:= $(foreach test_module,$(file_formats_child_module_names),$(test_module)_test_clean)
file_formats_test_child_run_targets	:= $(foreach test_module,$(file_formats_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
file_formats_test_install_path        := $(file_formats_path_curtestdir)file_formats$(EXT_EXE)
endif
file_formats_test_sources             := $(wildcard $(file_formats_path_curtestdir)*.c)
file_formats_sources					:= $(wildcard $(file_formats_path_curdir)*.c)
file_formats_sources					+= $(wildcard $(file_formats_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
file_formats_sources					+= $(wildcard $(file_formats_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
file_formats_sources					+= $(wildcard $(file_formats_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
file_formats_sources					+= $(wildcard $(file_formats_path_curdir)platform_specific/mac/*.c)
endif
file_formats_objects                  := $(patsubst %.c, %.o, $(file_formats_sources))
file_formats_test_objects				:= $(patsubst %.c, %.o, $(file_formats_test_sources))
file_formats_test_depends				:= $(patsubst %.c, %.d, $(file_formats_test_sources))
file_formats_depends					:= $(patsubst %.c, %.d, $(file_formats_sources))
file_formats_depends_modules			:=  common
file_formats_test_depends_modules     := file_formats test_framework libc common compare process file time system random file_reader hash circular_buffer mod memory 
file_formats_test_libdepend_objs      = $(foreach dep_module,$(file_formats_test_depends_modules),$($(dep_module)_objects))
file_formats_clean_files				:=
file_formats_clean_files				+= $(file_formats_install_path_implib)
file_formats_clean_files				+= $(file_formats_objects)
file_formats_clean_files				+= $(file_formats_test_objects)
file_formats_clean_files				+= $(file_formats_depends)

include $(file_formats_child_makefiles)

#$(file_formats_path_curtestdir)%.o: $(file_formats_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(file_formats_path_curdir)%.o: $(file_formats_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(file_formats_test_install_path): $(file_formats_test_objects) $(file_formats_test_libdepend_objs)
	$(CC) -o $@ $(file_formats_test_objects) $(file_formats_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: file_formats_all
file_formats_all: $(file_formats_objects) ## build all file_formats object files

.PHONY: file_formats_test_all
file_formats_test_all: $(file_formats_test_install_path) ## build file_formats_test test

.PHONY: file_formats_clean
file_formats_clean: $(file_formats_child_clean_targets) ## remove all file_formats object files
file_formats_clean:
	- $(RM) $(file_formats_clean_files)

.PHONY: file_formats_test_clean
file_formats_test_clean: $(file_formats_test_child_clean_targets) ## remove all file_formats_test tests
file_formats_test_clean:
	- $(RM) $(file_formats_test_install_path) $(file_formats_test_objects) $(file_formats_test_depends)

.PHONY: file_formats_re
file_formats_re: file_formats_clean
file_formats_re: file_formats_all

.PHONY: file_formats_test_re
file_formats_test_re: file_formats_test_clean
file_formats_test_re: file_formats_test_all

.PHONY: file_formats_test_run_all
file_formats_test_run_all: $(file_formats_test_child_run_targets) ## build and run file_formats_test
ifneq ($(file_formats_test_objects),)
file_formats_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(file_formats_test_install_path)
endif

.PHONY: file_formats_test_run
file_formats_test_run: file_formats_all
file_formats_test_run: file_formats_test_all
ifneq ($(file_formats_test_objects),)
file_formats_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(file_formats_test_install_path)
endif

-include $(file_formats_depends)
-include $(file_formats_test_depends)
