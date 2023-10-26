8086_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
8086_path_curtestdir			:= $(8086_path_curdir)test/
8086_child_makefiles			:= $(wildcard $(8086_path_curdir)*/*mk)
8086_child_module_names		:= $(basename $(notdir $(8086_child_makefiles)))
8086_child_all_targets		:= $(foreach child_module,$(8086_child_module_names),$(child_module)_all)
8086_child_clean_targets		:= $(foreach child_module,$(8086_child_module_names),$(child_module)_clean)
8086_test_child_all_targets	:= $(foreach test_module,$(8086_child_module_names),$(test_module)_test_all)
8086_test_child_clean_targets	:= $(foreach test_module,$(8086_child_module_names),$(test_module)_test_clean)
8086_test_child_run_targets	:= $(foreach test_module,$(8086_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
8086_test_install_path        := $(8086_path_curtestdir)8086$(EXT_EXE)
endif
8086_test_sources             := $(wildcard $(8086_path_curtestdir)*.c)
8086_sources					:= $(wildcard $(8086_path_curdir)*.c)
8086_sources					+= $(wildcard $(8086_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
8086_sources					+= $(wildcard $(8086_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
8086_sources					+= $(wildcard $(8086_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
8086_sources					+= $(wildcard $(8086_path_curdir)platform_specific/mac/*.c)
endif
8086_objects                  := $(patsubst %.c, %.o, $(8086_sources))
8086_test_objects				:= $(patsubst %.c, %.o, $(8086_test_sources))
8086_test_depends				:= $(patsubst %.c, %.d, $(8086_test_sources))
8086_depends					:= $(patsubst %.c, %.d, $(8086_sources))
8086_depends_modules			:=  common
8086_test_depends_modules     := 8086 test_framework libc common compare process file time system memory random file_reader hash circular_buffer mod abs 
8086_test_libdepend_objs      = $(foreach dep_module,$(8086_test_depends_modules),$($(dep_module)_objects))
8086_clean_files				:=
8086_clean_files				+= $(8086_install_path_implib)
8086_clean_files				+= $(8086_objects)
8086_clean_files				+= $(8086_test_objects)
8086_clean_files				+= $(8086_depends)

include $(8086_child_makefiles)

#$(8086_path_curtestdir)%.o: $(8086_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(8086_path_curdir)%.o: $(8086_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(8086_test_install_path): $(8086_test_objects) $(8086_test_libdepend_objs)
	$(CC) -o $@ $(8086_test_objects) $(8086_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: 8086_all
8086_all: $(8086_objects) ## build all 8086 object files

.PHONY: 8086_test_all
8086_test_all: $(8086_test_install_path) ## build 8086_test test

.PHONY: 8086_clean
8086_clean: $(8086_child_clean_targets) ## remove all 8086 object files
8086_clean:
	- $(RM) $(8086_clean_files)

.PHONY: 8086_test_clean
8086_test_clean: $(8086_test_child_clean_targets) ## remove all 8086_test tests
8086_test_clean:
	- $(RM) $(8086_test_install_path) $(8086_test_objects) $(8086_test_depends)

.PHONY: 8086_re
8086_re: 8086_clean
8086_re: 8086_all

.PHONY: 8086_test_re
8086_test_re: 8086_test_clean
8086_test_re: 8086_test_all

.PHONY: 8086_test_run_all
8086_test_run_all: $(8086_test_child_run_targets) ## build and run 8086_test
ifneq ($(8086_test_objects),)
8086_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(8086_test_install_path)
endif

.PHONY: 8086_test_run
8086_test_run: 8086_all
8086_test_run: 8086_test_all
ifneq ($(8086_test_objects),)
8086_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(8086_test_install_path)
endif

-include $(8086_depends)
-include $(8086_test_depends)
