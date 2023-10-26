hash_set_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
hash_set_path_curtestdir			:= $(hash_set_path_curdir)test/
hash_set_child_makefiles			:= $(wildcard $(hash_set_path_curdir)*/*mk)
hash_set_child_module_names		:= $(basename $(notdir $(hash_set_child_makefiles)))
hash_set_child_all_targets		:= $(foreach child_module,$(hash_set_child_module_names),$(child_module)_all)
hash_set_child_clean_targets		:= $(foreach child_module,$(hash_set_child_module_names),$(child_module)_clean)
hash_set_test_child_all_targets	:= $(foreach test_module,$(hash_set_child_module_names),$(test_module)_test_all)
hash_set_test_child_clean_targets	:= $(foreach test_module,$(hash_set_child_module_names),$(test_module)_test_clean)
hash_set_test_child_run_targets	:= $(foreach test_module,$(hash_set_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
hash_set_test_install_path        := $(hash_set_path_curtestdir)hash_set$(EXT_EXE)
endif
hash_set_test_sources             := $(wildcard $(hash_set_path_curtestdir)*.c)
hash_set_sources					:= $(wildcard $(hash_set_path_curdir)*.c)
hash_set_sources					+= $(wildcard $(hash_set_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
hash_set_sources					+= $(wildcard $(hash_set_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
hash_set_sources					+= $(wildcard $(hash_set_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
hash_set_sources					+= $(wildcard $(hash_set_path_curdir)platform_specific/mac/*.c)
endif
hash_set_objects                  := $(patsubst %.c, %.o, $(hash_set_sources))
hash_set_test_objects				:= $(patsubst %.c, %.o, $(hash_set_test_sources))
hash_set_test_depends				:= $(patsubst %.c, %.d, $(hash_set_test_sources))
hash_set_depends					:= $(patsubst %.c, %.d, $(hash_set_sources))
hash_set_depends_modules			:= libc common compare memory  common
hash_set_test_depends_modules     := hash_set libc common compare memory test_framework process file time system random file_reader hash circular_buffer mod abs 
hash_set_test_libdepend_objs      = $(foreach dep_module,$(hash_set_test_depends_modules),$($(dep_module)_objects))
hash_set_clean_files				:=
hash_set_clean_files				+= $(hash_set_install_path_implib)
hash_set_clean_files				+= $(hash_set_objects)
hash_set_clean_files				+= $(hash_set_test_objects)
hash_set_clean_files				+= $(hash_set_depends)

include $(hash_set_child_makefiles)

#$(hash_set_path_curtestdir)%.o: $(hash_set_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(hash_set_path_curdir)%.o: $(hash_set_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(hash_set_test_install_path): $(hash_set_test_objects) $(hash_set_test_libdepend_objs)
	$(CC) -o $@ $(hash_set_test_objects) $(hash_set_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: hash_set_all
hash_set_all: $(hash_set_objects) ## build all hash_set object files

.PHONY: hash_set_test_all
hash_set_test_all: $(hash_set_test_install_path) ## build hash_set_test test

.PHONY: hash_set_clean
hash_set_clean: $(hash_set_child_clean_targets) ## remove all hash_set object files
hash_set_clean:
	- $(RM) $(hash_set_clean_files)

.PHONY: hash_set_test_clean
hash_set_test_clean: $(hash_set_test_child_clean_targets) ## remove all hash_set_test tests
hash_set_test_clean:
	- $(RM) $(hash_set_test_install_path) $(hash_set_test_objects) $(hash_set_test_depends)

.PHONY: hash_set_re
hash_set_re: hash_set_clean
hash_set_re: hash_set_all

.PHONY: hash_set_test_re
hash_set_test_re: hash_set_test_clean
hash_set_test_re: hash_set_test_all

.PHONY: hash_set_test_run_all
hash_set_test_run_all: $(hash_set_test_child_run_targets) ## build and run hash_set_test
ifneq ($(hash_set_test_objects),)
hash_set_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(hash_set_test_install_path)
endif

.PHONY: hash_set_test_run
hash_set_test_run: hash_set_all
hash_set_test_run: hash_set_test_all
ifneq ($(hash_set_test_objects),)
hash_set_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(hash_set_test_install_path)
endif

-include $(hash_set_depends)
-include $(hash_set_test_depends)
