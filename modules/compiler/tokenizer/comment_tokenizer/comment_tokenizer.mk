comment_tokenizer_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
comment_tokenizer_path_curtestdir			:= $(comment_tokenizer_path_curdir)test/
comment_tokenizer_child_makefiles			:= $(wildcard $(comment_tokenizer_path_curdir)*/*mk)
comment_tokenizer_child_module_names		:= $(basename $(notdir $(comment_tokenizer_child_makefiles)))
comment_tokenizer_child_all_targets		:= $(foreach child_module,$(comment_tokenizer_child_module_names),$(child_module)_all)
comment_tokenizer_child_clean_targets		:= $(foreach child_module,$(comment_tokenizer_child_module_names),$(child_module)_clean)
comment_tokenizer_test_child_all_targets	:= $(foreach test_module,$(comment_tokenizer_child_module_names),$(test_module)_test_all)
comment_tokenizer_test_child_clean_targets	:= $(foreach test_module,$(comment_tokenizer_child_module_names),$(test_module)_test_clean)
comment_tokenizer_test_child_run_targets	:= $(foreach test_module,$(comment_tokenizer_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
comment_tokenizer_test_install_path        := $(comment_tokenizer_path_curtestdir)comment_tokenizer$(EXT_EXE)
endif
comment_tokenizer_test_sources             := $(wildcard $(comment_tokenizer_path_curtestdir)*.c)
comment_tokenizer_sources					:= $(wildcard $(comment_tokenizer_path_curdir)*.c)
comment_tokenizer_sources					+= $(wildcard $(comment_tokenizer_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
comment_tokenizer_sources					+= $(wildcard $(comment_tokenizer_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
comment_tokenizer_sources					+= $(wildcard $(comment_tokenizer_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
comment_tokenizer_sources					+= $(wildcard $(comment_tokenizer_path_curdir)platform_specific/mac/*.c)
endif
comment_tokenizer_objects                  := $(patsubst %.c, %.o, $(comment_tokenizer_sources))
comment_tokenizer_test_objects				:= $(patsubst %.c, %.o, $(comment_tokenizer_test_sources))
comment_tokenizer_test_depends				:= $(patsubst %.c, %.d, $(comment_tokenizer_test_sources))
comment_tokenizer_depends					:= $(patsubst %.c, %.d, $(comment_tokenizer_sources))
comment_tokenizer_depends_modules			:=  common
comment_tokenizer_test_depends_modules     := comment_tokenizer test_framework libc common compare process file time system memory random file_reader hash circular_buffer mod 
comment_tokenizer_test_libdepend_objs      = $(foreach dep_module,$(comment_tokenizer_test_depends_modules),$($(dep_module)_objects))
comment_tokenizer_clean_files				:=
comment_tokenizer_clean_files				+= $(comment_tokenizer_install_path_implib)
comment_tokenizer_clean_files				+= $(comment_tokenizer_objects)
comment_tokenizer_clean_files				+= $(comment_tokenizer_test_objects)
comment_tokenizer_clean_files				+= $(comment_tokenizer_depends)

include $(comment_tokenizer_child_makefiles)

#$(comment_tokenizer_path_curtestdir)%.o: $(comment_tokenizer_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(comment_tokenizer_path_curdir)%.o: $(comment_tokenizer_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(comment_tokenizer_test_install_path): $(comment_tokenizer_test_objects) $(comment_tokenizer_test_libdepend_objs)
	$(CC) -o $@ $(comment_tokenizer_test_objects) $(comment_tokenizer_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: comment_tokenizer_all
comment_tokenizer_all: $(comment_tokenizer_objects) ## build all comment_tokenizer object files

.PHONY: comment_tokenizer_test_all
comment_tokenizer_test_all: $(comment_tokenizer_test_install_path) ## build comment_tokenizer_test test

.PHONY: comment_tokenizer_clean
comment_tokenizer_clean: $(comment_tokenizer_child_clean_targets) ## remove all comment_tokenizer object files
comment_tokenizer_clean:
	- $(RM) $(comment_tokenizer_clean_files)

.PHONY: comment_tokenizer_test_clean
comment_tokenizer_test_clean: $(comment_tokenizer_test_child_clean_targets) ## remove all comment_tokenizer_test tests
comment_tokenizer_test_clean:
	- $(RM) $(comment_tokenizer_test_install_path) $(comment_tokenizer_test_objects) $(comment_tokenizer_test_depends)

.PHONY: comment_tokenizer_re
comment_tokenizer_re: comment_tokenizer_clean
comment_tokenizer_re: comment_tokenizer_all

.PHONY: comment_tokenizer_test_re
comment_tokenizer_test_re: comment_tokenizer_test_clean
comment_tokenizer_test_re: comment_tokenizer_test_all

.PHONY: comment_tokenizer_test_run_all
comment_tokenizer_test_run_all: $(comment_tokenizer_test_child_run_targets) ## build and run comment_tokenizer_test
ifneq ($(comment_tokenizer_test_objects),)
comment_tokenizer_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(comment_tokenizer_test_install_path)
endif

.PHONY: comment_tokenizer_test_run
comment_tokenizer_test_run: comment_tokenizer_all
comment_tokenizer_test_run: comment_tokenizer_test_all
ifneq ($(comment_tokenizer_test_objects),)
comment_tokenizer_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(comment_tokenizer_test_install_path)
endif

-include $(comment_tokenizer_depends)
-include $(comment_tokenizer_test_depends)
