file_path_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
file_path_path_curtestdir			:= $(file_path_path_curdir)test/
file_path_child_makefiles			:= $(wildcard $(file_path_path_curdir)*/*mk)
file_path_child_module_names		:= $(basename $(notdir $(file_path_child_makefiles)))
file_path_child_all_targets		:= $(foreach child_module,$(file_path_child_module_names),$(child_module)_all)
file_path_child_clean_targets		:= $(foreach child_module,$(file_path_child_module_names),$(child_module)_clean)
file_path_test_child_all_targets	:= $(foreach test_module,$(file_path_child_module_names),$(test_module)_test_all)
file_path_test_child_clean_targets	:= $(foreach test_module,$(file_path_child_module_names),$(test_module)_test_clean)
file_path_test_child_run_targets	:= $(foreach test_module,$(file_path_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
file_path_test_install_path        := $(file_path_path_curtestdir)file_path$(EXT_EXE)
endif
file_path_test_sources             := $(wildcard $(file_path_path_curtestdir)*.c)
file_path_sources					:= $(wildcard $(file_path_path_curdir)*.c)
file_path_sources					+= $(wildcard $(file_path_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
file_path_sources					+= $(wildcard $(file_path_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
file_path_sources					+= $(wildcard $(file_path_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
file_path_sources					+= $(wildcard $(file_path_path_curdir)platform_specific/mac/*.c)
endif
file_path_objects                  := $(patsubst %.c, %.o, $(file_path_sources))
file_path_test_objects				:= $(patsubst %.c, %.o, $(file_path_test_sources))
file_path_test_depends				:= $(patsubst %.c, %.d, $(file_path_test_sources))
file_path_depends					:= $(patsubst %.c, %.d, $(file_path_sources))
file_path_depends_modules			:= libc common compare string  common
file_path_test_depends_modules     := file_path libc common compare string test_framework process file time system memory random file_reader hash circular_buffer mod abs 
file_path_test_libdepend_objs      = $(foreach dep_module,$(file_path_test_depends_modules),$($(dep_module)_objects))
file_path_clean_files				:=
file_path_clean_files				+= $(file_path_install_path_implib)
file_path_clean_files				+= $(file_path_objects)
file_path_clean_files				+= $(file_path_test_objects)
file_path_clean_files				+= $(file_path_depends)

include $(file_path_child_makefiles)

#$(file_path_path_curtestdir)%.o: $(file_path_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(file_path_path_curdir)%.o: $(file_path_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(file_path_test_install_path): $(file_path_test_objects) $(file_path_test_libdepend_objs)
	$(CC) -o $@ $(file_path_test_objects) $(file_path_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: file_path_all
file_path_all: $(file_path_objects) ## build all file_path object files

.PHONY: file_path_test_all
file_path_test_all: $(file_path_test_install_path) ## build file_path_test test

.PHONY: file_path_clean
file_path_clean: $(file_path_child_clean_targets) ## remove all file_path object files
file_path_clean:
	- $(RM) $(file_path_clean_files)

.PHONY: file_path_test_clean
file_path_test_clean: $(file_path_test_child_clean_targets) ## remove all file_path_test tests
file_path_test_clean:
	- $(RM) $(file_path_test_install_path) $(file_path_test_objects) $(file_path_test_depends)

.PHONY: file_path_re
file_path_re: file_path_clean
file_path_re: file_path_all

.PHONY: file_path_test_re
file_path_test_re: file_path_test_clean
file_path_test_re: file_path_test_all

.PHONY: file_path_test_run_all
file_path_test_run_all: $(file_path_test_child_run_targets) ## build and run file_path_test
ifneq ($(file_path_test_objects),)
file_path_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(file_path_test_install_path)
endif

.PHONY: file_path_test_run
file_path_test_run: file_path_all
file_path_test_run: file_path_test_all
ifneq ($(file_path_test_objects),)
file_path_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(file_path_test_install_path)
endif

-include $(file_path_depends)
-include $(file_path_test_depends)
