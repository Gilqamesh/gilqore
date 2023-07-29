processor_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
processor_path_curtestdir			:= $(processor_path_curdir)test/
processor_child_makefiles			:= $(wildcard $(processor_path_curdir)*/*mk)
processor_child_module_names		:= $(basename $(notdir $(processor_child_makefiles)))
processor_child_all_targets		:= $(foreach child_module,$(processor_child_module_names),$(child_module)_all)
processor_child_clean_targets		:= $(foreach child_module,$(processor_child_module_names),$(child_module)_clean)
processor_test_child_all_targets	:= $(foreach test_module,$(processor_child_module_names),$(test_module)_test_all)
processor_test_child_clean_targets	:= $(foreach test_module,$(processor_child_module_names),$(test_module)_test_clean)
processor_test_child_run_targets	:= $(foreach test_module,$(processor_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
processor_test_install_path        := $(processor_path_curtestdir)processor$(EXT_EXE)
endif
processor_test_sources             := $(wildcard $(processor_path_curtestdir)*.c)
processor_sources					:= $(wildcard $(processor_path_curdir)*.c)
processor_sources					+= $(wildcard $(processor_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
processor_sources					+= $(wildcard $(processor_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
processor_sources					+= $(wildcard $(processor_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
processor_sources					+= $(wildcard $(processor_path_curdir)platform_specific/mac/*.c)
endif
processor_objects                  := $(patsubst %.c, %.o, $(processor_sources))
processor_test_objects				:= $(patsubst %.c, %.o, $(processor_test_sources))
processor_test_depends				:= $(patsubst %.c, %.d, $(processor_test_sources))
processor_depends					:= $(patsubst %.c, %.d, $(processor_sources))
processor_depends_modules			:=  common
processor_test_depends_modules     := processor test_framework libc common compare process file time system memory random file_reader hash circular_buffer mod 
processor_test_libdepend_objs      = $(foreach dep_module,$(processor_test_depends_modules),$($(dep_module)_objects))
processor_clean_files				:=
processor_clean_files				+= $(processor_install_path_implib)
processor_clean_files				+= $(processor_objects)
processor_clean_files				+= $(processor_test_objects)
processor_clean_files				+= $(processor_depends)

include $(processor_child_makefiles)

#$(processor_path_curtestdir)%.o: $(processor_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(processor_path_curdir)%.o: $(processor_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(processor_test_install_path): $(processor_test_objects) $(processor_test_libdepend_objs)
	$(CC) -o $@ $(processor_test_objects) $(processor_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: processor_all
processor_all: $(processor_objects) ## build all processor object files

.PHONY: processor_test_all
processor_test_all: $(processor_test_install_path) ## build processor_test test

.PHONY: processor_clean
processor_clean: $(processor_child_clean_targets) ## remove all processor object files
processor_clean:
	- $(RM) $(processor_clean_files)

.PHONY: processor_test_clean
processor_test_clean: $(processor_test_child_clean_targets) ## remove all processor_test tests
processor_test_clean:
	- $(RM) $(processor_test_install_path) $(processor_test_objects) $(processor_test_depends)

.PHONY: processor_re
processor_re: processor_clean
processor_re: processor_all

.PHONY: processor_test_re
processor_test_re: processor_test_clean
processor_test_re: processor_test_all

.PHONY: processor_test_run_all
processor_test_run_all: $(processor_test_child_run_targets) ## build and run processor_test
ifneq ($(processor_test_objects),)
processor_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(processor_test_install_path)
endif

.PHONY: processor_test_run
processor_test_run: processor_all
processor_test_run: processor_test_all
ifneq ($(processor_test_objects),)
processor_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(processor_test_install_path)
endif

-include $(processor_depends)
-include $(processor_test_depends)
