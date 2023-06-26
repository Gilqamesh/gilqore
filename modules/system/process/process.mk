process_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
process_path_curtestdir			:= $(process_path_curdir)test/
process_child_makefiles			:= $(wildcard $(process_path_curdir)*/*mk)
process_child_module_names		:= $(basename $(notdir $(process_child_makefiles)))
process_child_all_targets		:= $(foreach child_module,$(process_child_module_names),$(child_module)_all)
process_child_clean_targets		:= $(foreach child_module,$(process_child_module_names),$(child_module)_clean)
process_test_child_all_targets	:= $(foreach test_module,$(process_child_module_names),$(test_module)_test_all)
process_test_child_clean_targets	:= $(foreach test_module,$(process_child_module_names),$(test_module)_test_clean)
process_test_child_run_targets	:= $(foreach test_module,$(process_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
process_test_install_path        := $(process_path_curtestdir)process$(EXT_EXE)
endif
process_test_sources             := $(wildcard $(process_path_curtestdir)*.c)
process_sources					:= $(wildcard $(process_path_curdir)*.c)
process_sources					+= $(wildcard $(process_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
process_sources					+= $(wildcard $(process_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
process_sources					+= $(wildcard $(process_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
process_sources					+= $(wildcard $(process_path_curdir)platform_specific/mac/*.c)
endif
process_objects                  := $(patsubst %.c, %.o, $(process_sources))
process_test_objects				:= $(patsubst %.c, %.o, $(process_test_sources))
process_test_depends				:= $(patsubst %.c, %.d, $(process_test_sources))
process_depends					:= $(patsubst %.c, %.d, $(process_sources))
process_depends_modules			:= file common time system libc compare random  common
process_test_depends_modules     := process file common time system libc compare random test_framework file_reader hash circular_buffer mod memory 
process_test_libdepend_objs      = $(foreach dep_module,$(process_test_depends_modules),$($(dep_module)_objects))
process_clean_files				:=
process_clean_files				+= $(process_install_path_implib)
process_clean_files				+= $(process_objects)
process_clean_files				+= $(process_test_objects)
process_clean_files				+= $(process_depends)

include $(process_child_makefiles)

#$(process_path_curtestdir)%.o: $(process_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(process_path_curdir)%.o: $(process_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(process_test_install_path): $(process_test_objects) $(process_test_libdepend_objs)
	$(CC) -o $@ $(process_test_objects) $(process_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: process_all
process_all: $(process_objects) ## build all process object files

.PHONY: process_test_all
process_test_all: $(process_test_install_path) ## build process_test test

.PHONY: process_clean
process_clean: $(process_child_clean_targets) ## remove all process object files
process_clean:
	- $(RM) $(process_clean_files)

.PHONY: process_test_clean
process_test_clean: $(process_test_child_clean_targets) ## remove all process_test tests
process_test_clean:
	- $(RM) $(process_test_install_path) $(process_test_objects) $(process_test_depends)

.PHONY: process_re
process_re: process_clean
process_re: process_all

.PHONY: process_test_re
process_test_re: process_test_clean
process_test_re: process_test_all

.PHONY: process_test_run_all
process_test_run_all: $(process_test_child_run_targets) ## build and run process_test
ifneq ($(process_test_objects),)
process_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(process_test_install_path)
endif

.PHONY: process_test_run
process_test_run: process_all
process_test_run: process_test_all
ifneq ($(process_test_objects),)
process_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(process_test_install_path)
endif

-include $(process_depends)
-include $(process_test_depends)
