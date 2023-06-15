linear_allocator_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
linear_allocator_path_curtestdir			:= $(linear_allocator_path_curdir)test/
linear_allocator_child_makefiles			:= $(wildcard $(linear_allocator_path_curdir)*/*mk)
linear_allocator_child_module_names		:= $(basename $(notdir $(linear_allocator_child_makefiles)))
linear_allocator_child_all_targets		:= $(foreach child_module,$(linear_allocator_child_module_names),$(child_module)_all)
linear_allocator_child_clean_targets		:= $(foreach child_module,$(linear_allocator_child_module_names),$(child_module)_clean)
linear_allocator_test_child_all_targets	:= $(foreach test_module,$(linear_allocator_child_module_names),$(test_module)_test_all)
linear_allocator_test_child_clean_targets	:= $(foreach test_module,$(linear_allocator_child_module_names),$(test_module)_test_clean)
linear_allocator_test_child_run_targets	:= $(foreach test_module,$(linear_allocator_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
linear_allocator_test_install_path        := $(linear_allocator_path_curtestdir)linear_allocator$(EXT_EXE)
endif
linear_allocator_test_sources             := $(wildcard $(linear_allocator_path_curtestdir)*.c)
linear_allocator_sources					:= $(wildcard $(linear_allocator_path_curdir)*.c)
linear_allocator_sources					+= $(wildcard $(linear_allocator_path_curdir)impl/*.c)
ifeq ($(PLATFORM), WINDOWS)
linear_allocator_sources					+= $(wildcard $(linear_allocator_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
linear_allocator_sources					+= $(wildcard $(linear_allocator_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
linear_allocator_sources					+= $(wildcard $(linear_allocator_path_curdir)platform_specific/mac/*.c)
endif
linear_allocator_objects                  := $(patsubst %.c, %.o, $(linear_allocator_sources))
linear_allocator_test_objects				:= $(patsubst %.c, %.o, $(linear_allocator_test_sources))
linear_allocator_test_depends				:= $(patsubst %.c, %.d, $(linear_allocator_test_sources))
linear_allocator_depends					:= $(patsubst %.c, %.d, $(linear_allocator_sources))
linear_allocator_depends_modules			:= libc common math compare  common
linear_allocator_test_depends_modules     := linear_allocator test_framework libc common process file time system random compare file_reader hash circular_buffer mod math 
linear_allocator_test_libdepend_objs      = $(foreach dep_module,$(linear_allocator_test_depends_modules),$($(dep_module)_objects))
linear_allocator_clean_files				:=
linear_allocator_clean_files				+= $(linear_allocator_install_path_implib)
linear_allocator_clean_files				+= $(linear_allocator_objects)
linear_allocator_clean_files				+= $(linear_allocator_test_objects)
linear_allocator_clean_files				+= $(linear_allocator_depends)

include $(linear_allocator_child_makefiles)

#$(linear_allocator_path_curtestdir)%.o: $(linear_allocator_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(linear_allocator_path_curdir)%.o: $(linear_allocator_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(linear_allocator_test_install_path): $(linear_allocator_test_objects) $(linear_allocator_test_libdepend_objs)
	$(CC) -o $@ $(linear_allocator_test_objects) -Wl,--allow-multiple-definition $(linear_allocator_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: linear_allocator_all
linear_allocator_all: $(linear_allocator_objects) ## build all linear_allocator object files

.PHONY: linear_allocator_test_all
linear_allocator_test_all: $(linear_allocator_test_install_path) ## build linear_allocator_test test

.PHONY: linear_allocator_clean
linear_allocator_clean: $(linear_allocator_child_clean_targets) ## remove all linear_allocator object files
linear_allocator_clean:
	- $(RM) $(linear_allocator_clean_files)

.PHONY: linear_allocator_test_clean
linear_allocator_test_clean: $(linear_allocator_test_child_clean_targets) ## remove all linear_allocator_test tests
linear_allocator_test_clean:
	- $(RM) $(linear_allocator_test_install_path) $(linear_allocator_test_objects) $(linear_allocator_test_depends)

.PHONY: linear_allocator_re
linear_allocator_re: linear_allocator_clean
linear_allocator_re: linear_allocator_all

.PHONY: linear_allocator_test_re
linear_allocator_test_re: linear_allocator_test_clean
linear_allocator_test_re: linear_allocator_test_all

.PHONY: linear_allocator_test_run_all
linear_allocator_test_run_all: $(linear_allocator_test_child_run_targets) ## build and run linear_allocator_test
ifneq ($(linear_allocator_test_objects),)
linear_allocator_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(linear_allocator_test_install_path)
endif

.PHONY: linear_allocator_test_run
linear_allocator_test_run: linear_allocator_all
linear_allocator_test_run: linear_allocator_test_all
ifneq ($(linear_allocator_test_objects),)
linear_allocator_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(linear_allocator_test_install_path)
endif

-include $(linear_allocator_depends)
-include $(linear_allocator_test_depends)
