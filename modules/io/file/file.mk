file_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
file_path_curtestdir			:= $(file_path_curdir)test/
file_child_makefiles			:= $(wildcard $(file_path_curdir)*/*mk)
file_child_module_names		:= $(basename $(notdir $(file_child_makefiles)))
file_child_all_targets		:= $(foreach child_module,$(file_child_module_names),$(child_module)_all)
file_child_clean_targets		:= $(foreach child_module,$(file_child_module_names),$(child_module)_clean)
file_test_child_all_targets	:= $(foreach test_module,$(file_child_module_names),$(test_module)_test_all)
file_test_child_clean_targets	:= $(foreach test_module,$(file_child_module_names),$(test_module)_test_clean)
file_test_child_run_targets	:= $(foreach test_module,$(file_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
file_test_install_path        := $(file_path_curtestdir)file$(EXT_EXE)
endif
file_test_sources             := $(wildcard $(file_path_curtestdir)*.c)
file_sources					:= $(wildcard $(file_path_curdir)*.c)
file_sources					+= $(wildcard $(file_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
file_sources					+= $(wildcard $(file_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
file_sources					+= $(wildcard $(file_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
file_sources					+= $(wildcard $(file_path_curdir)platform_specific/mac/*.c)
endif
file_objects                  := $(patsubst %.c, %.o, $(file_sources))
file_test_objects				:= $(patsubst %.c, %.o, $(file_test_sources))
file_test_depends				:= $(patsubst %.c, %.d, $(file_test_sources))
file_depends					:= $(patsubst %.c, %.d, $(file_sources))
file_depends_modules			:= common time system memory libc compare random  common
file_test_depends_modules     := file common time system memory libc compare random test_framework process file_reader hash circular_buffer mod abs 
file_test_libdepend_objs      = $(foreach dep_module,$(file_test_depends_modules),$($(dep_module)_objects))
file_clean_files				:=
file_clean_files				+= $(file_install_path_implib)
file_clean_files				+= $(file_objects)
file_clean_files				+= $(file_test_objects)
file_clean_files				+= $(file_depends)

include $(file_child_makefiles)

#$(file_path_curtestdir)%.o: $(file_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(file_path_curdir)%.o: $(file_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(file_test_install_path): $(file_test_objects) $(file_test_libdepend_objs)
	$(CC) -o $@ $(file_test_objects) $(file_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: file_all
file_all: $(file_objects) ## build all file object files

.PHONY: file_test_all
file_test_all: $(file_test_install_path) ## build file_test test

.PHONY: file_clean
file_clean: $(file_child_clean_targets) ## remove all file object files
file_clean:
	- $(RM) $(file_clean_files)

.PHONY: file_test_clean
file_test_clean: $(file_test_child_clean_targets) ## remove all file_test tests
file_test_clean:
	- $(RM) $(file_test_install_path) $(file_test_objects) $(file_test_depends)

.PHONY: file_re
file_re: file_clean
file_re: file_all

.PHONY: file_test_re
file_test_re: file_test_clean
file_test_re: file_test_all

.PHONY: file_test_run_all
file_test_run_all: $(file_test_child_run_targets) ## build and run file_test
ifneq ($(file_test_objects),)
file_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(file_test_install_path)
endif

.PHONY: file_test_run
file_test_run: file_all
file_test_run: file_test_all
ifneq ($(file_test_objects),)
file_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(file_test_install_path)
endif

-include $(file_depends)
-include $(file_test_depends)
