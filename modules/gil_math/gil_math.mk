gil_math_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
gil_math_path_curtestdir			:= $(gil_math_path_curdir)test/
gil_math_child_makefiles			:= $(wildcard $(gil_math_path_curdir)*/*mk)
gil_math_child_module_names		:= $(basename $(notdir $(gil_math_child_makefiles)))
gil_math_child_all_targets		:= $(foreach child_module,$(gil_math_child_module_names),$(child_module)_all)
gil_math_child_clean_targets		:= $(foreach child_module,$(gil_math_child_module_names),$(child_module)_clean)
gil_math_test_child_all_targets	:= $(foreach test_module,$(gil_math_child_module_names),$(test_module)_test_all)
gil_math_test_child_clean_targets	:= $(foreach test_module,$(gil_math_child_module_names),$(test_module)_test_clean)
gil_math_test_child_run_targets	:= $(foreach test_module,$(gil_math_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
gil_math_test_install_path        := $(gil_math_path_curtestdir)gil_math$(EXT_EXE)
endif
gil_math_test_sources             := $(wildcard $(gil_math_path_curtestdir)*.c)
gil_math_sources					:= $(wildcard $(gil_math_path_curdir)*.c)
gil_math_sources					+= $(wildcard $(gil_math_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
gil_math_sources					+= $(wildcard $(gil_math_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
gil_math_sources					+= $(wildcard $(gil_math_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
gil_math_sources					+= $(wildcard $(gil_math_path_curdir)platform_specific/mac/*.c)
endif
gil_math_objects                  := $(patsubst %.c, %.o, $(gil_math_sources))
gil_math_test_objects				:= $(patsubst %.c, %.o, $(gil_math_test_sources))
gil_math_test_depends				:= $(patsubst %.c, %.d, $(gil_math_test_sources))
gil_math_depends					:= $(patsubst %.c, %.d, $(gil_math_sources))
gil_math_depends_modules			:=  common
gil_math_test_depends_modules     := gil_math test_framework libc common compare process file time system memory random file_reader hash circular_buffer mod abs 
gil_math_test_libdepend_objs      = $(foreach dep_module,$(gil_math_test_depends_modules),$($(dep_module)_objects))
gil_math_clean_files				:=
gil_math_clean_files				+= $(gil_math_install_path_implib)
gil_math_clean_files				+= $(gil_math_objects)
gil_math_clean_files				+= $(gil_math_test_objects)
gil_math_clean_files				+= $(gil_math_depends)

include $(gil_math_child_makefiles)

#$(gil_math_path_curtestdir)%.o: $(gil_math_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(gil_math_path_curdir)%.o: $(gil_math_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(gil_math_test_install_path): $(gil_math_test_objects) $(gil_math_test_libdepend_objs)
	$(CC) -o $@ $(gil_math_test_objects) $(gil_math_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: gil_math_all
gil_math_all: $(gil_math_objects) ## build all gil_math object files

.PHONY: gil_math_test_all
gil_math_test_all: $(gil_math_test_install_path) ## build gil_math_test test

.PHONY: gil_math_clean
gil_math_clean: $(gil_math_child_clean_targets) ## remove all gil_math object files
gil_math_clean:
	- $(RM) $(gil_math_clean_files)

.PHONY: gil_math_test_clean
gil_math_test_clean: $(gil_math_test_child_clean_targets) ## remove all gil_math_test tests
gil_math_test_clean:
	- $(RM) $(gil_math_test_install_path) $(gil_math_test_objects) $(gil_math_test_depends)

.PHONY: gil_math_re
gil_math_re: gil_math_clean
gil_math_re: gil_math_all

.PHONY: gil_math_test_re
gil_math_test_re: gil_math_test_clean
gil_math_test_re: gil_math_test_all

.PHONY: gil_math_test_run_all
gil_math_test_run_all: $(gil_math_test_child_run_targets) ## build and run gil_math_test
ifneq ($(gil_math_test_objects),)
gil_math_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(gil_math_test_install_path)
endif

.PHONY: gil_math_test_run
gil_math_test_run: gil_math_all
gil_math_test_run: gil_math_test_all
ifneq ($(gil_math_test_objects),)
gil_math_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(gil_math_test_install_path)
endif

-include $(gil_math_depends)
-include $(gil_math_test_depends)
