file_reader_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
file_reader_path_curtestdir			:= $(file_reader_path_curdir)test/
file_reader_child_makefiles			:= $(wildcard $(file_reader_path_curdir)*/*mk)
file_reader_child_module_names		:= $(basename $(notdir $(file_reader_child_makefiles)))
file_reader_child_all_targets		:= $(foreach child_module,$(file_reader_child_module_names),$(child_module)_all)
file_reader_child_clean_targets		:= $(foreach child_module,$(file_reader_child_module_names),$(child_module)_clean)
file_reader_test_child_all_targets	:= $(foreach test_module,$(file_reader_child_module_names),$(test_module)_test_all)
file_reader_test_child_clean_targets	:= $(foreach test_module,$(file_reader_child_module_names),$(test_module)_test_clean)
file_reader_test_child_run_targets	:= $(foreach test_module,$(file_reader_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
file_reader_test_install_path        := $(file_reader_path_curtestdir)file_reader$(EXT_EXE)
endif
file_reader_test_sources             := $(wildcard $(file_reader_path_curtestdir)*.c)
file_reader_sources					:= $(wildcard $(file_reader_path_curdir)*.c)
file_reader_sources					+= $(wildcard $(file_reader_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
file_reader_sources					+= $(wildcard $(file_reader_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
file_reader_sources					+= $(wildcard $(file_reader_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
file_reader_sources					+= $(wildcard $(file_reader_path_curdir)platform_specific/mac/*.c)
endif
file_reader_objects                  := $(patsubst %.c, %.o, $(file_reader_sources))
file_reader_test_objects				:= $(patsubst %.c, %.o, $(file_reader_test_sources))
file_reader_test_depends				:= $(patsubst %.c, %.d, $(file_reader_test_sources))
file_reader_depends					:= $(patsubst %.c, %.d, $(file_reader_sources))
file_reader_depends_modules			:= hash libc common compare circular_buffer mod memory file time system random  common
file_reader_test_depends_modules     := file_reader hash libc common compare circular_buffer mod memory file time system random test_framework process 
file_reader_test_libdepend_objs      = $(foreach dep_module,$(file_reader_test_depends_modules),$($(dep_module)_objects))
file_reader_clean_files				:=
file_reader_clean_files				+= $(file_reader_install_path_implib)
file_reader_clean_files				+= $(file_reader_objects)
file_reader_clean_files				+= $(file_reader_test_objects)
file_reader_clean_files				+= $(file_reader_depends)

include $(file_reader_child_makefiles)

#$(file_reader_path_curtestdir)%.o: $(file_reader_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(file_reader_path_curdir)%.o: $(file_reader_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(file_reader_test_install_path): $(file_reader_test_objects) $(file_reader_test_libdepend_objs)
	$(CC) -o $@ $(file_reader_test_objects) $(file_reader_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: file_reader_all
file_reader_all: $(file_reader_objects) ## build all file_reader object files

.PHONY: file_reader_test_all
file_reader_test_all: $(file_reader_test_install_path) ## build file_reader_test test

.PHONY: file_reader_clean
file_reader_clean: $(file_reader_child_clean_targets) ## remove all file_reader object files
file_reader_clean:
	- $(RM) $(file_reader_clean_files)

.PHONY: file_reader_test_clean
file_reader_test_clean: $(file_reader_test_child_clean_targets) ## remove all file_reader_test tests
file_reader_test_clean:
	- $(RM) $(file_reader_test_install_path) $(file_reader_test_objects) $(file_reader_test_depends)

.PHONY: file_reader_re
file_reader_re: file_reader_clean
file_reader_re: file_reader_all

.PHONY: file_reader_test_re
file_reader_test_re: file_reader_test_clean
file_reader_test_re: file_reader_test_all

.PHONY: file_reader_test_run_all
file_reader_test_run_all: $(file_reader_test_child_run_targets) ## build and run file_reader_test
ifneq ($(file_reader_test_objects),)
file_reader_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(file_reader_test_install_path)
endif

.PHONY: file_reader_test_run
file_reader_test_run: file_reader_all
file_reader_test_run: file_reader_test_all
ifneq ($(file_reader_test_objects),)
file_reader_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(file_reader_test_install_path)
endif

-include $(file_reader_depends)
-include $(file_reader_test_depends)
