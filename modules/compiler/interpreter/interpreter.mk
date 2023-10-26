interpreter_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
interpreter_path_curtestdir			:= $(interpreter_path_curdir)test/
interpreter_child_makefiles			:= $(wildcard $(interpreter_path_curdir)*/*mk)
interpreter_child_module_names		:= $(basename $(notdir $(interpreter_child_makefiles)))
interpreter_child_all_targets		:= $(foreach child_module,$(interpreter_child_module_names),$(child_module)_all)
interpreter_child_clean_targets		:= $(foreach child_module,$(interpreter_child_module_names),$(child_module)_clean)
interpreter_test_child_all_targets	:= $(foreach test_module,$(interpreter_child_module_names),$(test_module)_test_all)
interpreter_test_child_clean_targets	:= $(foreach test_module,$(interpreter_child_module_names),$(test_module)_test_clean)
interpreter_test_child_run_targets	:= $(foreach test_module,$(interpreter_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
interpreter_test_install_path        := $(interpreter_path_curtestdir)interpreter$(EXT_EXE)
endif
interpreter_test_sources             := $(wildcard $(interpreter_path_curtestdir)*.c)
interpreter_sources					:= $(wildcard $(interpreter_path_curdir)*.c)
interpreter_sources					+= $(wildcard $(interpreter_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
interpreter_sources					+= $(wildcard $(interpreter_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
interpreter_sources					+= $(wildcard $(interpreter_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
interpreter_sources					+= $(wildcard $(interpreter_path_curdir)platform_specific/mac/*.c)
endif
interpreter_objects                  := $(patsubst %.c, %.o, $(interpreter_sources))
interpreter_test_objects				:= $(patsubst %.c, %.o, $(interpreter_test_sources))
interpreter_test_depends				:= $(patsubst %.c, %.d, $(interpreter_test_sources))
interpreter_depends					:= $(patsubst %.c, %.d, $(interpreter_sources))
interpreter_depends_modules			:= libc common compare file time system memory random console tokenizer lox_tokenizer comment_tokenizer parser lox_parser basic_types gil_math lox_interpreter hash  common
interpreter_test_depends_modules     := interpreter libc common compare file time system memory random console tokenizer lox_tokenizer comment_tokenizer parser lox_parser basic_types gil_math lox_interpreter hash test_framework process file_reader circular_buffer mod abs 
interpreter_test_libdepend_objs      = $(foreach dep_module,$(interpreter_test_depends_modules),$($(dep_module)_objects))
interpreter_clean_files				:=
interpreter_clean_files				+= $(interpreter_install_path_implib)
interpreter_clean_files				+= $(interpreter_objects)
interpreter_clean_files				+= $(interpreter_test_objects)
interpreter_clean_files				+= $(interpreter_depends)

include $(interpreter_child_makefiles)

#$(interpreter_path_curtestdir)%.o: $(interpreter_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(interpreter_path_curdir)%.o: $(interpreter_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(interpreter_test_install_path): $(interpreter_test_objects) $(interpreter_test_libdepend_objs)
	$(CC) -o $@ $(interpreter_test_objects) $(interpreter_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: interpreter_all
interpreter_all: $(interpreter_objects) ## build all interpreter object files

.PHONY: interpreter_test_all
interpreter_test_all: $(interpreter_test_install_path) ## build interpreter_test test

.PHONY: interpreter_clean
interpreter_clean: $(interpreter_child_clean_targets) ## remove all interpreter object files
interpreter_clean:
	- $(RM) $(interpreter_clean_files)

.PHONY: interpreter_test_clean
interpreter_test_clean: $(interpreter_test_child_clean_targets) ## remove all interpreter_test tests
interpreter_test_clean:
	- $(RM) $(interpreter_test_install_path) $(interpreter_test_objects) $(interpreter_test_depends)

.PHONY: interpreter_re
interpreter_re: interpreter_clean
interpreter_re: interpreter_all

.PHONY: interpreter_test_re
interpreter_test_re: interpreter_test_clean
interpreter_test_re: interpreter_test_all

.PHONY: interpreter_test_run_all
interpreter_test_run_all: $(interpreter_test_child_run_targets) ## build and run interpreter_test
ifneq ($(interpreter_test_objects),)
interpreter_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(interpreter_test_install_path)
endif

.PHONY: interpreter_test_run
interpreter_test_run: interpreter_all
interpreter_test_run: interpreter_test_all
ifneq ($(interpreter_test_objects),)
interpreter_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(interpreter_test_install_path)
endif

-include $(interpreter_depends)
-include $(interpreter_test_depends)
