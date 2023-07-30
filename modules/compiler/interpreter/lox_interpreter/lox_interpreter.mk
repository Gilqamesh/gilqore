lox_interpreter_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
lox_interpreter_path_curtestdir			:= $(lox_interpreter_path_curdir)test/
lox_interpreter_child_makefiles			:= $(wildcard $(lox_interpreter_path_curdir)*/*mk)
lox_interpreter_child_module_names		:= $(basename $(notdir $(lox_interpreter_child_makefiles)))
lox_interpreter_child_all_targets		:= $(foreach child_module,$(lox_interpreter_child_module_names),$(child_module)_all)
lox_interpreter_child_clean_targets		:= $(foreach child_module,$(lox_interpreter_child_module_names),$(child_module)_clean)
lox_interpreter_test_child_all_targets	:= $(foreach test_module,$(lox_interpreter_child_module_names),$(test_module)_test_all)
lox_interpreter_test_child_clean_targets	:= $(foreach test_module,$(lox_interpreter_child_module_names),$(test_module)_test_clean)
lox_interpreter_test_child_run_targets	:= $(foreach test_module,$(lox_interpreter_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
lox_interpreter_test_install_path        := $(lox_interpreter_path_curtestdir)lox_interpreter$(EXT_EXE)
endif
lox_interpreter_test_sources             := $(wildcard $(lox_interpreter_path_curtestdir)*.c)
lox_interpreter_sources					:= $(wildcard $(lox_interpreter_path_curdir)*.c)
lox_interpreter_sources					+= $(wildcard $(lox_interpreter_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
lox_interpreter_sources					+= $(wildcard $(lox_interpreter_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
lox_interpreter_sources					+= $(wildcard $(lox_interpreter_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
lox_interpreter_sources					+= $(wildcard $(lox_interpreter_path_curdir)platform_specific/mac/*.c)
endif
lox_interpreter_objects                  := $(patsubst %.c, %.o, $(lox_interpreter_sources))
lox_interpreter_test_objects				:= $(patsubst %.c, %.o, $(lox_interpreter_test_sources))
lox_interpreter_test_depends				:= $(patsubst %.c, %.d, $(lox_interpreter_test_sources))
lox_interpreter_depends					:= $(patsubst %.c, %.d, $(lox_interpreter_sources))
lox_interpreter_depends_modules			:= lox_parser libc common compare parser memory basic_types gil_math lox_tokenizer time system hash  common
lox_interpreter_test_depends_modules     := lox_interpreter lox_parser libc common compare parser memory basic_types gil_math lox_tokenizer time system hash test_framework process file random file_reader circular_buffer mod 
lox_interpreter_test_libdepend_objs      = $(foreach dep_module,$(lox_interpreter_test_depends_modules),$($(dep_module)_objects))
lox_interpreter_clean_files				:=
lox_interpreter_clean_files				+= $(lox_interpreter_install_path_implib)
lox_interpreter_clean_files				+= $(lox_interpreter_objects)
lox_interpreter_clean_files				+= $(lox_interpreter_test_objects)
lox_interpreter_clean_files				+= $(lox_interpreter_depends)

include $(lox_interpreter_child_makefiles)

#$(lox_interpreter_path_curtestdir)%.o: $(lox_interpreter_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(lox_interpreter_path_curdir)%.o: $(lox_interpreter_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(lox_interpreter_test_install_path): $(lox_interpreter_test_objects) $(lox_interpreter_test_libdepend_objs)
	$(CC) -o $@ $(lox_interpreter_test_objects) $(lox_interpreter_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: lox_interpreter_all
lox_interpreter_all: $(lox_interpreter_objects) ## build all lox_interpreter object files

.PHONY: lox_interpreter_test_all
lox_interpreter_test_all: $(lox_interpreter_test_install_path) ## build lox_interpreter_test test

.PHONY: lox_interpreter_clean
lox_interpreter_clean: $(lox_interpreter_child_clean_targets) ## remove all lox_interpreter object files
lox_interpreter_clean:
	- $(RM) $(lox_interpreter_clean_files)

.PHONY: lox_interpreter_test_clean
lox_interpreter_test_clean: $(lox_interpreter_test_child_clean_targets) ## remove all lox_interpreter_test tests
lox_interpreter_test_clean:
	- $(RM) $(lox_interpreter_test_install_path) $(lox_interpreter_test_objects) $(lox_interpreter_test_depends)

.PHONY: lox_interpreter_re
lox_interpreter_re: lox_interpreter_clean
lox_interpreter_re: lox_interpreter_all

.PHONY: lox_interpreter_test_re
lox_interpreter_test_re: lox_interpreter_test_clean
lox_interpreter_test_re: lox_interpreter_test_all

.PHONY: lox_interpreter_test_run_all
lox_interpreter_test_run_all: $(lox_interpreter_test_child_run_targets) ## build and run lox_interpreter_test
ifneq ($(lox_interpreter_test_objects),)
lox_interpreter_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(lox_interpreter_test_install_path)
endif

.PHONY: lox_interpreter_test_run
lox_interpreter_test_run: lox_interpreter_all
lox_interpreter_test_run: lox_interpreter_test_all
ifneq ($(lox_interpreter_test_objects),)
lox_interpreter_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(lox_interpreter_test_install_path)
endif

-include $(lox_interpreter_depends)
-include $(lox_interpreter_test_depends)
