c_tokenizer_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
c_tokenizer_path_curtestdir			:= $(c_tokenizer_path_curdir)test/
c_tokenizer_child_makefiles			:= $(wildcard $(c_tokenizer_path_curdir)*/*mk)
c_tokenizer_child_module_names		:= $(basename $(notdir $(c_tokenizer_child_makefiles)))
c_tokenizer_child_all_targets		:= $(foreach child_module,$(c_tokenizer_child_module_names),$(child_module)_all)
c_tokenizer_child_clean_targets		:= $(foreach child_module,$(c_tokenizer_child_module_names),$(child_module)_clean)
c_tokenizer_test_child_all_targets	:= $(foreach test_module,$(c_tokenizer_child_module_names),$(test_module)_test_all)
c_tokenizer_test_child_clean_targets	:= $(foreach test_module,$(c_tokenizer_child_module_names),$(test_module)_test_clean)
c_tokenizer_test_child_run_targets	:= $(foreach test_module,$(c_tokenizer_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
c_tokenizer_test_install_path        := $(c_tokenizer_path_curtestdir)c_tokenizer$(EXT_EXE)
endif
c_tokenizer_test_sources             := $(wildcard $(c_tokenizer_path_curtestdir)*.c)
c_tokenizer_sources					:= $(wildcard $(c_tokenizer_path_curdir)*.c)
c_tokenizer_sources					+= $(wildcard $(c_tokenizer_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
c_tokenizer_sources					+= $(wildcard $(c_tokenizer_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
c_tokenizer_sources					+= $(wildcard $(c_tokenizer_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
c_tokenizer_sources					+= $(wildcard $(c_tokenizer_path_curdir)platform_specific/mac/*.c)
endif
c_tokenizer_objects                  := $(patsubst %.c, %.o, $(c_tokenizer_sources))
c_tokenizer_test_objects				:= $(patsubst %.c, %.o, $(c_tokenizer_test_sources))
c_tokenizer_test_depends				:= $(patsubst %.c, %.d, $(c_tokenizer_test_sources))
c_tokenizer_depends					:= $(patsubst %.c, %.d, $(c_tokenizer_sources))
c_tokenizer_depends_modules			:=  common
c_tokenizer_test_depends_modules     := c_tokenizer test_framework libc common compare process file time system random file_reader hash circular_buffer mod memory 
c_tokenizer_test_libdepend_objs      = $(foreach dep_module,$(c_tokenizer_test_depends_modules),$($(dep_module)_objects))
c_tokenizer_clean_files				:=
c_tokenizer_clean_files				+= $(c_tokenizer_install_path_implib)
c_tokenizer_clean_files				+= $(c_tokenizer_objects)
c_tokenizer_clean_files				+= $(c_tokenizer_test_objects)
c_tokenizer_clean_files				+= $(c_tokenizer_depends)

include $(c_tokenizer_child_makefiles)

#$(c_tokenizer_path_curtestdir)%.o: $(c_tokenizer_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(c_tokenizer_path_curdir)%.o: $(c_tokenizer_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(c_tokenizer_test_install_path): $(c_tokenizer_test_objects) $(c_tokenizer_test_libdepend_objs)
	$(CC) -o $@ $(c_tokenizer_test_objects) $(c_tokenizer_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: c_tokenizer_all
c_tokenizer_all: $(c_tokenizer_objects) ## build all c_tokenizer object files

.PHONY: c_tokenizer_test_all
c_tokenizer_test_all: $(c_tokenizer_test_install_path) ## build c_tokenizer_test test

.PHONY: c_tokenizer_clean
c_tokenizer_clean: $(c_tokenizer_child_clean_targets) ## remove all c_tokenizer object files
c_tokenizer_clean:
	- $(RM) $(c_tokenizer_clean_files)

.PHONY: c_tokenizer_test_clean
c_tokenizer_test_clean: $(c_tokenizer_test_child_clean_targets) ## remove all c_tokenizer_test tests
c_tokenizer_test_clean:
	- $(RM) $(c_tokenizer_test_install_path) $(c_tokenizer_test_objects) $(c_tokenizer_test_depends)

.PHONY: c_tokenizer_re
c_tokenizer_re: c_tokenizer_clean
c_tokenizer_re: c_tokenizer_all

.PHONY: c_tokenizer_test_re
c_tokenizer_test_re: c_tokenizer_test_clean
c_tokenizer_test_re: c_tokenizer_test_all

.PHONY: c_tokenizer_test_run_all
c_tokenizer_test_run_all: $(c_tokenizer_test_child_run_targets) ## build and run c_tokenizer_test
ifneq ($(c_tokenizer_test_objects),)
c_tokenizer_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(c_tokenizer_test_install_path)
endif

.PHONY: c_tokenizer_test_run
c_tokenizer_test_run: c_tokenizer_all
c_tokenizer_test_run: c_tokenizer_test_all
ifneq ($(c_tokenizer_test_objects),)
c_tokenizer_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(c_tokenizer_test_install_path)
endif

-include $(c_tokenizer_depends)
-include $(c_tokenizer_test_depends)
