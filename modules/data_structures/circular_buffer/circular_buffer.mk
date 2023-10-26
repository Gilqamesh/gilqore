circular_buffer_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
circular_buffer_path_curtestdir			:= $(circular_buffer_path_curdir)test/
circular_buffer_child_makefiles			:= $(wildcard $(circular_buffer_path_curdir)*/*mk)
circular_buffer_child_module_names		:= $(basename $(notdir $(circular_buffer_child_makefiles)))
circular_buffer_child_all_targets		:= $(foreach child_module,$(circular_buffer_child_module_names),$(child_module)_all)
circular_buffer_child_clean_targets		:= $(foreach child_module,$(circular_buffer_child_module_names),$(child_module)_clean)
circular_buffer_test_child_all_targets	:= $(foreach test_module,$(circular_buffer_child_module_names),$(test_module)_test_all)
circular_buffer_test_child_clean_targets	:= $(foreach test_module,$(circular_buffer_child_module_names),$(test_module)_test_clean)
circular_buffer_test_child_run_targets	:= $(foreach test_module,$(circular_buffer_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
circular_buffer_test_install_path        := $(circular_buffer_path_curtestdir)circular_buffer$(EXT_EXE)
endif
circular_buffer_test_sources             := $(wildcard $(circular_buffer_path_curtestdir)*.c)
circular_buffer_sources					:= $(wildcard $(circular_buffer_path_curdir)*.c)
circular_buffer_sources					+= $(wildcard $(circular_buffer_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
circular_buffer_sources					+= $(wildcard $(circular_buffer_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
circular_buffer_sources					+= $(wildcard $(circular_buffer_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
circular_buffer_sources					+= $(wildcard $(circular_buffer_path_curdir)platform_specific/mac/*.c)
endif
circular_buffer_objects                  := $(patsubst %.c, %.o, $(circular_buffer_sources))
circular_buffer_test_objects				:= $(patsubst %.c, %.o, $(circular_buffer_test_sources))
circular_buffer_test_depends				:= $(patsubst %.c, %.d, $(circular_buffer_test_sources))
circular_buffer_depends					:= $(patsubst %.c, %.d, $(circular_buffer_sources))
circular_buffer_depends_modules			:= libc common compare mod memory  common
circular_buffer_test_depends_modules     := circular_buffer libc common compare mod memory test_framework process file time system random file_reader hash abs 
circular_buffer_test_libdepend_objs      = $(foreach dep_module,$(circular_buffer_test_depends_modules),$($(dep_module)_objects))
circular_buffer_clean_files				:=
circular_buffer_clean_files				+= $(circular_buffer_install_path_implib)
circular_buffer_clean_files				+= $(circular_buffer_objects)
circular_buffer_clean_files				+= $(circular_buffer_test_objects)
circular_buffer_clean_files				+= $(circular_buffer_depends)

include $(circular_buffer_child_makefiles)

#$(circular_buffer_path_curtestdir)%.o: $(circular_buffer_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(circular_buffer_path_curdir)%.o: $(circular_buffer_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(circular_buffer_test_install_path): $(circular_buffer_test_objects) $(circular_buffer_test_libdepend_objs)
	$(CC) -o $@ $(circular_buffer_test_objects) $(circular_buffer_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: circular_buffer_all
circular_buffer_all: $(circular_buffer_objects) ## build all circular_buffer object files

.PHONY: circular_buffer_test_all
circular_buffer_test_all: $(circular_buffer_test_install_path) ## build circular_buffer_test test

.PHONY: circular_buffer_clean
circular_buffer_clean: $(circular_buffer_child_clean_targets) ## remove all circular_buffer object files
circular_buffer_clean:
	- $(RM) $(circular_buffer_clean_files)

.PHONY: circular_buffer_test_clean
circular_buffer_test_clean: $(circular_buffer_test_child_clean_targets) ## remove all circular_buffer_test tests
circular_buffer_test_clean:
	- $(RM) $(circular_buffer_test_install_path) $(circular_buffer_test_objects) $(circular_buffer_test_depends)

.PHONY: circular_buffer_re
circular_buffer_re: circular_buffer_clean
circular_buffer_re: circular_buffer_all

.PHONY: circular_buffer_test_re
circular_buffer_test_re: circular_buffer_test_clean
circular_buffer_test_re: circular_buffer_test_all

.PHONY: circular_buffer_test_run_all
circular_buffer_test_run_all: $(circular_buffer_test_child_run_targets) ## build and run circular_buffer_test
ifneq ($(circular_buffer_test_objects),)
circular_buffer_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(circular_buffer_test_install_path)
endif

.PHONY: circular_buffer_test_run
circular_buffer_test_run: circular_buffer_all
circular_buffer_test_run: circular_buffer_test_all
ifneq ($(circular_buffer_test_objects),)
circular_buffer_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(circular_buffer_test_install_path)
endif

-include $(circular_buffer_depends)
-include $(circular_buffer_test_depends)
