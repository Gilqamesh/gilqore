projecteuler_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
projecteuler_path_curtestdir			:= $(projecteuler_path_curdir)test/
projecteuler_child_makefiles			:= $(wildcard $(projecteuler_path_curdir)*/*mk)
projecteuler_child_module_names		:= $(basename $(notdir $(projecteuler_child_makefiles)))
projecteuler_child_all_targets		:= $(foreach child_module,$(projecteuler_child_module_names),$(child_module)_all)
projecteuler_child_clean_targets		:= $(foreach child_module,$(projecteuler_child_module_names),$(child_module)_clean)
projecteuler_test_child_all_targets	:= $(foreach test_module,$(projecteuler_child_module_names),$(test_module)_test_all)
projecteuler_test_child_clean_targets	:= $(foreach test_module,$(projecteuler_child_module_names),$(test_module)_test_clean)
projecteuler_test_child_run_targets	:= $(foreach test_module,$(projecteuler_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
projecteuler_test_install_path        := $(projecteuler_path_curtestdir)projecteuler$(EXT_EXE)
endif
projecteuler_test_sources             := $(wildcard $(projecteuler_path_curtestdir)*.c)
projecteuler_sources					:= $(wildcard $(projecteuler_path_curdir)*.c)
projecteuler_sources					+= $(wildcard $(projecteuler_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
projecteuler_sources					+= $(wildcard $(projecteuler_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
projecteuler_sources					+= $(wildcard $(projecteuler_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
projecteuler_sources					+= $(wildcard $(projecteuler_path_curdir)platform_specific/mac/*.c)
endif
projecteuler_objects                  := $(patsubst %.c, %.o, $(projecteuler_sources))
projecteuler_test_objects				:= $(patsubst %.c, %.o, $(projecteuler_test_sources))
projecteuler_test_depends				:= $(patsubst %.c, %.d, $(projecteuler_test_sources))
projecteuler_depends					:= $(patsubst %.c, %.d, $(projecteuler_sources))
projecteuler_depends_modules			:= file_reader hash libc common compare circular_buffer mod memory file time system random abs file_writer segment_allocator heap sqrt thread hash_set hash_map  common
projecteuler_test_depends_modules     := projecteuler file_reader hash libc common compare circular_buffer mod memory file time system random abs file_writer segment_allocator heap sqrt thread hash_set hash_map test_framework process 
projecteuler_test_libdepend_objs      = $(foreach dep_module,$(projecteuler_test_depends_modules),$($(dep_module)_objects))
projecteuler_clean_files				:=
projecteuler_clean_files				+= $(projecteuler_install_path_implib)
projecteuler_clean_files				+= $(projecteuler_objects)
projecteuler_clean_files				+= $(projecteuler_test_objects)
projecteuler_clean_files				+= $(projecteuler_depends)

include $(projecteuler_child_makefiles)

#$(projecteuler_path_curtestdir)%.o: $(projecteuler_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(projecteuler_path_curdir)%.o: $(projecteuler_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(projecteuler_test_install_path): $(projecteuler_test_objects) $(projecteuler_test_libdepend_objs)
	$(CC) -o $@ $(projecteuler_test_objects) $(projecteuler_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: projecteuler_all
projecteuler_all: $(projecteuler_objects) ## build all projecteuler object files

.PHONY: projecteuler_test_all
projecteuler_test_all: $(projecteuler_test_install_path) ## build projecteuler_test test

.PHONY: projecteuler_clean
projecteuler_clean: $(projecteuler_child_clean_targets) ## remove all projecteuler object files
projecteuler_clean:
	- $(RM) $(projecteuler_clean_files)

.PHONY: projecteuler_test_clean
projecteuler_test_clean: $(projecteuler_test_child_clean_targets) ## remove all projecteuler_test tests
projecteuler_test_clean:
	- $(RM) $(projecteuler_test_install_path) $(projecteuler_test_objects) $(projecteuler_test_depends)

.PHONY: projecteuler_re
projecteuler_re: projecteuler_clean
projecteuler_re: projecteuler_all

.PHONY: projecteuler_test_re
projecteuler_test_re: projecteuler_test_clean
projecteuler_test_re: projecteuler_test_all

.PHONY: projecteuler_test_run_all
projecteuler_test_run_all: $(projecteuler_test_child_run_targets) ## build and run projecteuler_test
ifneq ($(projecteuler_test_objects),)
projecteuler_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(projecteuler_test_install_path)
endif

.PHONY: projecteuler_test_run
projecteuler_test_run: projecteuler_all
projecteuler_test_run: projecteuler_test_all
ifneq ($(projecteuler_test_objects),)
projecteuler_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(projecteuler_test_install_path)
endif

-include $(projecteuler_depends)
-include $(projecteuler_test_depends)
