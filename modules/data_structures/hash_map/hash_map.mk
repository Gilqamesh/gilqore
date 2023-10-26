hash_map_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
hash_map_path_curtestdir			:= $(hash_map_path_curdir)test/
hash_map_child_makefiles			:= $(wildcard $(hash_map_path_curdir)*/*mk)
hash_map_child_module_names		:= $(basename $(notdir $(hash_map_child_makefiles)))
hash_map_child_all_targets		:= $(foreach child_module,$(hash_map_child_module_names),$(child_module)_all)
hash_map_child_clean_targets		:= $(foreach child_module,$(hash_map_child_module_names),$(child_module)_clean)
hash_map_test_child_all_targets	:= $(foreach test_module,$(hash_map_child_module_names),$(test_module)_test_all)
hash_map_test_child_clean_targets	:= $(foreach test_module,$(hash_map_child_module_names),$(test_module)_test_clean)
hash_map_test_child_run_targets	:= $(foreach test_module,$(hash_map_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
hash_map_test_install_path        := $(hash_map_path_curtestdir)hash_map$(EXT_EXE)
endif
hash_map_test_sources             := $(wildcard $(hash_map_path_curtestdir)*.c)
hash_map_sources					:= $(wildcard $(hash_map_path_curdir)*.c)
hash_map_sources					+= $(wildcard $(hash_map_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
hash_map_sources					+= $(wildcard $(hash_map_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
hash_map_sources					+= $(wildcard $(hash_map_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
hash_map_sources					+= $(wildcard $(hash_map_path_curdir)platform_specific/mac/*.c)
endif
hash_map_objects                  := $(patsubst %.c, %.o, $(hash_map_sources))
hash_map_test_objects				:= $(patsubst %.c, %.o, $(hash_map_test_sources))
hash_map_test_depends				:= $(patsubst %.c, %.d, $(hash_map_test_sources))
hash_map_depends					:= $(patsubst %.c, %.d, $(hash_map_sources))
hash_map_depends_modules			:=  common
hash_map_test_depends_modules     := hash_map test_framework libc common compare process file time system memory random file_reader hash circular_buffer mod abs 
hash_map_test_libdepend_objs      = $(foreach dep_module,$(hash_map_test_depends_modules),$($(dep_module)_objects))
hash_map_clean_files				:=
hash_map_clean_files				+= $(hash_map_install_path_implib)
hash_map_clean_files				+= $(hash_map_objects)
hash_map_clean_files				+= $(hash_map_test_objects)
hash_map_clean_files				+= $(hash_map_depends)

include $(hash_map_child_makefiles)

#$(hash_map_path_curtestdir)%.o: $(hash_map_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(hash_map_path_curdir)%.o: $(hash_map_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(hash_map_test_install_path): $(hash_map_test_objects) $(hash_map_test_libdepend_objs)
	$(CC) -o $@ $(hash_map_test_objects) $(hash_map_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: hash_map_all
hash_map_all: $(hash_map_objects) ## build all hash_map object files

.PHONY: hash_map_test_all
hash_map_test_all: $(hash_map_test_install_path) ## build hash_map_test test

.PHONY: hash_map_clean
hash_map_clean: $(hash_map_child_clean_targets) ## remove all hash_map object files
hash_map_clean:
	- $(RM) $(hash_map_clean_files)

.PHONY: hash_map_test_clean
hash_map_test_clean: $(hash_map_test_child_clean_targets) ## remove all hash_map_test tests
hash_map_test_clean:
	- $(RM) $(hash_map_test_install_path) $(hash_map_test_objects) $(hash_map_test_depends)

.PHONY: hash_map_re
hash_map_re: hash_map_clean
hash_map_re: hash_map_all

.PHONY: hash_map_test_re
hash_map_test_re: hash_map_test_clean
hash_map_test_re: hash_map_test_all

.PHONY: hash_map_test_run_all
hash_map_test_run_all: $(hash_map_test_child_run_targets) ## build and run hash_map_test
ifneq ($(hash_map_test_objects),)
hash_map_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(hash_map_test_install_path)
endif

.PHONY: hash_map_test_run
hash_map_test_run: hash_map_all
hash_map_test_run: hash_map_test_all
ifneq ($(hash_map_test_objects),)
hash_map_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(hash_map_test_install_path)
endif

-include $(hash_map_depends)
-include $(hash_map_test_depends)
