tokenizer_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
tokenizer_path_curtestdir			:= $(tokenizer_path_curdir)test/
tokenizer_child_makefiles			:= $(wildcard $(tokenizer_path_curdir)*/*mk)
tokenizer_child_module_names		:= $(basename $(notdir $(tokenizer_child_makefiles)))
tokenizer_child_all_targets		:= $(foreach child_module,$(tokenizer_child_module_names),$(child_module)_all)
tokenizer_child_clean_targets		:= $(foreach child_module,$(tokenizer_child_module_names),$(child_module)_clean)
tokenizer_test_child_all_targets	:= $(foreach test_module,$(tokenizer_child_module_names),$(test_module)_test_all)
tokenizer_test_child_clean_targets	:= $(foreach test_module,$(tokenizer_child_module_names),$(test_module)_test_clean)
tokenizer_test_child_run_targets	:= $(foreach test_module,$(tokenizer_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
tokenizer_test_install_path        := $(tokenizer_path_curtestdir)tokenizer$(EXT_EXE)
endif
tokenizer_test_sources             := $(wildcard $(tokenizer_path_curtestdir)*.c)
tokenizer_sources					:= $(wildcard $(tokenizer_path_curdir)*.c)
tokenizer_sources					+= $(wildcard $(tokenizer_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
tokenizer_sources					+= $(wildcard $(tokenizer_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
tokenizer_sources					+= $(wildcard $(tokenizer_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
tokenizer_sources					+= $(wildcard $(tokenizer_path_curdir)platform_specific/mac/*.c)
endif
tokenizer_objects                  := $(patsubst %.c, %.o, $(tokenizer_sources))
tokenizer_test_objects				:= $(patsubst %.c, %.o, $(tokenizer_test_sources))
tokenizer_test_depends				:= $(patsubst %.c, %.d, $(tokenizer_test_sources))
tokenizer_depends					:= $(patsubst %.c, %.d, $(tokenizer_sources))
tokenizer_depends_modules			:= memory  common
tokenizer_test_depends_modules     := tokenizer memory file common time system libc compare random test_framework process file_reader hash circular_buffer mod abs 
tokenizer_test_libdepend_objs      = $(foreach dep_module,$(tokenizer_test_depends_modules),$($(dep_module)_objects))
tokenizer_clean_files				:=
tokenizer_clean_files				+= $(tokenizer_install_path_implib)
tokenizer_clean_files				+= $(tokenizer_objects)
tokenizer_clean_files				+= $(tokenizer_test_objects)
tokenizer_clean_files				+= $(tokenizer_depends)

include $(tokenizer_child_makefiles)

#$(tokenizer_path_curtestdir)%.o: $(tokenizer_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(tokenizer_path_curdir)%.o: $(tokenizer_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(tokenizer_test_install_path): $(tokenizer_test_objects) $(tokenizer_test_libdepend_objs)
	$(CC) -o $@ $(tokenizer_test_objects) $(tokenizer_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: tokenizer_all
tokenizer_all: $(tokenizer_objects) ## build all tokenizer object files

.PHONY: tokenizer_test_all
tokenizer_test_all: $(tokenizer_test_install_path) ## build tokenizer_test test

.PHONY: tokenizer_clean
tokenizer_clean: $(tokenizer_child_clean_targets) ## remove all tokenizer object files
tokenizer_clean:
	- $(RM) $(tokenizer_clean_files)

.PHONY: tokenizer_test_clean
tokenizer_test_clean: $(tokenizer_test_child_clean_targets) ## remove all tokenizer_test tests
tokenizer_test_clean:
	- $(RM) $(tokenizer_test_install_path) $(tokenizer_test_objects) $(tokenizer_test_depends)

.PHONY: tokenizer_re
tokenizer_re: tokenizer_clean
tokenizer_re: tokenizer_all

.PHONY: tokenizer_test_re
tokenizer_test_re: tokenizer_test_clean
tokenizer_test_re: tokenizer_test_all

.PHONY: tokenizer_test_run_all
tokenizer_test_run_all: $(tokenizer_test_child_run_targets) ## build and run tokenizer_test
ifneq ($(tokenizer_test_objects),)
tokenizer_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(tokenizer_test_install_path)
endif

.PHONY: tokenizer_test_run
tokenizer_test_run: tokenizer_all
tokenizer_test_run: tokenizer_test_all
ifneq ($(tokenizer_test_objects),)
tokenizer_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(tokenizer_test_install_path)
endif

-include $(tokenizer_depends)
-include $(tokenizer_test_depends)
