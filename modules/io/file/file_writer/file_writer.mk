file_writer_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
file_writer_path_curtestdir			:= $(file_writer_path_curdir)test/
file_writer_child_makefiles			:= $(wildcard $(file_writer_path_curdir)*/*mk)
file_writer_child_module_names		:= $(basename $(notdir $(file_writer_child_makefiles)))
file_writer_child_all_targets		:= $(foreach child_module,$(file_writer_child_module_names),$(child_module)_all)
file_writer_child_clean_targets		:= $(foreach child_module,$(file_writer_child_module_names),$(child_module)_clean)
file_writer_test_child_all_targets	:= $(foreach test_module,$(file_writer_child_module_names),$(test_module)_test_all)
file_writer_test_child_clean_targets	:= $(foreach test_module,$(file_writer_child_module_names),$(test_module)_test_clean)
file_writer_test_child_run_targets	:= $(foreach test_module,$(file_writer_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
file_writer_test_install_path        := $(file_writer_path_curtestdir)file_writer$(EXT_EXE)
endif
file_writer_test_sources             := $(wildcard $(file_writer_path_curtestdir)*.c)
file_writer_sources					:= $(wildcard $(file_writer_path_curdir)*.c)
file_writer_sources					+= $(wildcard $(file_writer_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
file_writer_sources					+= $(wildcard $(file_writer_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
file_writer_sources					+= $(wildcard $(file_writer_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
file_writer_sources					+= $(wildcard $(file_writer_path_curdir)platform_specific/mac/*.c)
endif
file_writer_objects                  := $(patsubst %.c, %.o, $(file_writer_sources))
file_writer_test_objects				:= $(patsubst %.c, %.o, $(file_writer_test_sources))
file_writer_test_depends				:= $(patsubst %.c, %.d, $(file_writer_test_sources))
file_writer_depends					:= $(patsubst %.c, %.d, $(file_writer_sources))
file_writer_depends_modules			:= libc common compare file time system memory random  common
file_writer_test_depends_modules     := file_writer libc common compare file time system memory random test_framework process file_reader hash circular_buffer mod abs 
file_writer_test_libdepend_objs      = $(foreach dep_module,$(file_writer_test_depends_modules),$($(dep_module)_objects))
file_writer_clean_files				:=
file_writer_clean_files				+= $(file_writer_install_path_implib)
file_writer_clean_files				+= $(file_writer_objects)
file_writer_clean_files				+= $(file_writer_test_objects)
file_writer_clean_files				+= $(file_writer_depends)

include $(file_writer_child_makefiles)

#$(file_writer_path_curtestdir)%.o: $(file_writer_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(file_writer_path_curdir)%.o: $(file_writer_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(file_writer_test_install_path): $(file_writer_test_objects) $(file_writer_test_libdepend_objs)
	$(CC) -o $@ $(file_writer_test_objects) $(file_writer_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: file_writer_all
file_writer_all: $(file_writer_objects) ## build all file_writer object files

.PHONY: file_writer_test_all
file_writer_test_all: $(file_writer_test_install_path) ## build file_writer_test test

.PHONY: file_writer_clean
file_writer_clean: $(file_writer_child_clean_targets) ## remove all file_writer object files
file_writer_clean:
	- $(RM) $(file_writer_clean_files)

.PHONY: file_writer_test_clean
file_writer_test_clean: $(file_writer_test_child_clean_targets) ## remove all file_writer_test tests
file_writer_test_clean:
	- $(RM) $(file_writer_test_install_path) $(file_writer_test_objects) $(file_writer_test_depends)

.PHONY: file_writer_re
file_writer_re: file_writer_clean
file_writer_re: file_writer_all

.PHONY: file_writer_test_re
file_writer_test_re: file_writer_test_clean
file_writer_test_re: file_writer_test_all

.PHONY: file_writer_test_run_all
file_writer_test_run_all: $(file_writer_test_child_run_targets) ## build and run file_writer_test
ifneq ($(file_writer_test_objects),)
file_writer_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(file_writer_test_install_path)
endif

.PHONY: file_writer_test_run
file_writer_test_run: file_writer_all
file_writer_test_run: file_writer_test_all
ifneq ($(file_writer_test_objects),)
file_writer_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(file_writer_test_install_path)
endif

-include $(file_writer_depends)
-include $(file_writer_test_depends)
