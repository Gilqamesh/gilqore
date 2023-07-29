hash_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
hash_path_curtestdir			:= $(hash_path_curdir)test/
hash_child_makefiles			:= $(wildcard $(hash_path_curdir)*/*mk)
hash_child_module_names		:= $(basename $(notdir $(hash_child_makefiles)))
hash_child_all_targets		:= $(foreach child_module,$(hash_child_module_names),$(child_module)_all)
hash_child_clean_targets		:= $(foreach child_module,$(hash_child_module_names),$(child_module)_clean)
hash_test_child_all_targets	:= $(foreach test_module,$(hash_child_module_names),$(test_module)_test_all)
hash_test_child_clean_targets	:= $(foreach test_module,$(hash_child_module_names),$(test_module)_test_clean)
hash_test_child_run_targets	:= $(foreach test_module,$(hash_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
hash_test_install_path        := $(hash_path_curtestdir)hash$(EXT_EXE)
endif
hash_test_sources             := $(wildcard $(hash_path_curtestdir)*.c)
hash_sources					:= $(wildcard $(hash_path_curdir)*.c)
hash_sources					+= $(wildcard $(hash_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
hash_sources					+= $(wildcard $(hash_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
hash_sources					+= $(wildcard $(hash_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
hash_sources					+= $(wildcard $(hash_path_curdir)platform_specific/mac/*.c)
endif
hash_objects                  := $(patsubst %.c, %.o, $(hash_sources))
hash_test_objects				:= $(patsubst %.c, %.o, $(hash_test_sources))
hash_test_depends				:= $(patsubst %.c, %.d, $(hash_test_sources))
hash_depends					:= $(patsubst %.c, %.d, $(hash_sources))
hash_depends_modules			:=  common
hash_test_depends_modules     := hash libc common compare test_framework process file time system memory random file_reader circular_buffer mod 
hash_test_libdepend_objs      = $(foreach dep_module,$(hash_test_depends_modules),$($(dep_module)_objects))
hash_clean_files				:=
hash_clean_files				+= $(hash_install_path_implib)
hash_clean_files				+= $(hash_objects)
hash_clean_files				+= $(hash_test_objects)
hash_clean_files				+= $(hash_depends)

include $(hash_child_makefiles)

#$(hash_path_curtestdir)%.o: $(hash_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(hash_path_curdir)%.o: $(hash_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(hash_test_install_path): $(hash_test_objects) $(hash_test_libdepend_objs)
	$(CC) -o $@ $(hash_test_objects) $(hash_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: hash_all
hash_all: $(hash_objects) ## build all hash object files

.PHONY: hash_test_all
hash_test_all: $(hash_test_install_path) ## build hash_test test

.PHONY: hash_clean
hash_clean: $(hash_child_clean_targets) ## remove all hash object files
hash_clean:
	- $(RM) $(hash_clean_files)

.PHONY: hash_test_clean
hash_test_clean: $(hash_test_child_clean_targets) ## remove all hash_test tests
hash_test_clean:
	- $(RM) $(hash_test_install_path) $(hash_test_objects) $(hash_test_depends)

.PHONY: hash_re
hash_re: hash_clean
hash_re: hash_all

.PHONY: hash_test_re
hash_test_re: hash_test_clean
hash_test_re: hash_test_all

.PHONY: hash_test_run_all
hash_test_run_all: $(hash_test_child_run_targets) ## build and run hash_test
ifneq ($(hash_test_objects),)
hash_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(hash_test_install_path)
endif

.PHONY: hash_test_run
hash_test_run: hash_all
hash_test_run: hash_test_all
ifneq ($(hash_test_objects),)
hash_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(hash_test_install_path)
endif

-include $(hash_depends)
-include $(hash_test_depends)
