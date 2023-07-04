lox_tokenizer_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
lox_tokenizer_path_curtestdir			:= $(lox_tokenizer_path_curdir)test/
lox_tokenizer_child_makefiles			:= $(wildcard $(lox_tokenizer_path_curdir)*/*mk)
lox_tokenizer_child_module_names		:= $(basename $(notdir $(lox_tokenizer_child_makefiles)))
lox_tokenizer_child_all_targets		:= $(foreach child_module,$(lox_tokenizer_child_module_names),$(child_module)_all)
lox_tokenizer_child_clean_targets		:= $(foreach child_module,$(lox_tokenizer_child_module_names),$(child_module)_clean)
lox_tokenizer_test_child_all_targets	:= $(foreach test_module,$(lox_tokenizer_child_module_names),$(test_module)_test_all)
lox_tokenizer_test_child_clean_targets	:= $(foreach test_module,$(lox_tokenizer_child_module_names),$(test_module)_test_clean)
lox_tokenizer_test_child_run_targets	:= $(foreach test_module,$(lox_tokenizer_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
lox_tokenizer_test_install_path        := $(lox_tokenizer_path_curtestdir)lox_tokenizer$(EXT_EXE)
endif
lox_tokenizer_test_sources             := $(wildcard $(lox_tokenizer_path_curtestdir)*.c)
lox_tokenizer_sources					:= $(wildcard $(lox_tokenizer_path_curdir)*.c)
lox_tokenizer_sources					+= $(wildcard $(lox_tokenizer_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
lox_tokenizer_sources					+= $(wildcard $(lox_tokenizer_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
lox_tokenizer_sources					+= $(wildcard $(lox_tokenizer_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
lox_tokenizer_sources					+= $(wildcard $(lox_tokenizer_path_curdir)platform_specific/mac/*.c)
endif
lox_tokenizer_objects                  := $(patsubst %.c, %.o, $(lox_tokenizer_sources))
lox_tokenizer_test_objects				:= $(patsubst %.c, %.o, $(lox_tokenizer_test_sources))
lox_tokenizer_test_depends				:= $(patsubst %.c, %.d, $(lox_tokenizer_test_sources))
lox_tokenizer_depends					:= $(patsubst %.c, %.d, $(lox_tokenizer_sources))
lox_tokenizer_depends_modules			:= libc common compare  common
lox_tokenizer_test_depends_modules     := lox_tokenizer libc common compare test_framework process file time system random file_reader hash circular_buffer mod memory 
lox_tokenizer_test_libdepend_objs      = $(foreach dep_module,$(lox_tokenizer_test_depends_modules),$($(dep_module)_objects))
lox_tokenizer_clean_files				:=
lox_tokenizer_clean_files				+= $(lox_tokenizer_install_path_implib)
lox_tokenizer_clean_files				+= $(lox_tokenizer_objects)
lox_tokenizer_clean_files				+= $(lox_tokenizer_test_objects)
lox_tokenizer_clean_files				+= $(lox_tokenizer_depends)

include $(lox_tokenizer_child_makefiles)

#$(lox_tokenizer_path_curtestdir)%.o: $(lox_tokenizer_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(lox_tokenizer_path_curdir)%.o: $(lox_tokenizer_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(lox_tokenizer_test_install_path): $(lox_tokenizer_test_objects) $(lox_tokenizer_test_libdepend_objs)
	$(CC) -o $@ $(lox_tokenizer_test_objects) $(lox_tokenizer_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: lox_tokenizer_all
lox_tokenizer_all: $(lox_tokenizer_objects) ## build all lox_tokenizer object files

.PHONY: lox_tokenizer_test_all
lox_tokenizer_test_all: $(lox_tokenizer_test_install_path) ## build lox_tokenizer_test test

.PHONY: lox_tokenizer_clean
lox_tokenizer_clean: $(lox_tokenizer_child_clean_targets) ## remove all lox_tokenizer object files
lox_tokenizer_clean:
	- $(RM) $(lox_tokenizer_clean_files)

.PHONY: lox_tokenizer_test_clean
lox_tokenizer_test_clean: $(lox_tokenizer_test_child_clean_targets) ## remove all lox_tokenizer_test tests
lox_tokenizer_test_clean:
	- $(RM) $(lox_tokenizer_test_install_path) $(lox_tokenizer_test_objects) $(lox_tokenizer_test_depends)

.PHONY: lox_tokenizer_re
lox_tokenizer_re: lox_tokenizer_clean
lox_tokenizer_re: lox_tokenizer_all

.PHONY: lox_tokenizer_test_re
lox_tokenizer_test_re: lox_tokenizer_test_clean
lox_tokenizer_test_re: lox_tokenizer_test_all

.PHONY: lox_tokenizer_test_run_all
lox_tokenizer_test_run_all: $(lox_tokenizer_test_child_run_targets) ## build and run lox_tokenizer_test
ifneq ($(lox_tokenizer_test_objects),)
lox_tokenizer_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(lox_tokenizer_test_install_path)
endif

.PHONY: lox_tokenizer_test_run
lox_tokenizer_test_run: lox_tokenizer_all
lox_tokenizer_test_run: lox_tokenizer_test_all
ifneq ($(lox_tokenizer_test_objects),)
lox_tokenizer_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(lox_tokenizer_test_install_path)
endif

-include $(lox_tokenizer_depends)
-include $(lox_tokenizer_test_depends)
