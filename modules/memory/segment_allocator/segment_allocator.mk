segment_allocator_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
segment_allocator_path_curtestdir			:= $(segment_allocator_path_curdir)test/
segment_allocator_child_makefiles			:= $(wildcard $(segment_allocator_path_curdir)*/*mk)
segment_allocator_child_module_names		:= $(basename $(notdir $(segment_allocator_child_makefiles)))
segment_allocator_child_all_targets		:= $(foreach child_module,$(segment_allocator_child_module_names),$(child_module)_all)
segment_allocator_child_clean_targets		:= $(foreach child_module,$(segment_allocator_child_module_names),$(child_module)_clean)
segment_allocator_test_child_all_targets	:= $(foreach test_module,$(segment_allocator_child_module_names),$(test_module)_test_all)
segment_allocator_test_child_clean_targets	:= $(foreach test_module,$(segment_allocator_child_module_names),$(test_module)_test_clean)
segment_allocator_test_child_run_targets	:= $(foreach test_module,$(segment_allocator_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
segment_allocator_test_install_path        := $(segment_allocator_path_curtestdir)segment_allocator$(EXT_EXE)
endif
segment_allocator_test_sources             := $(wildcard $(segment_allocator_path_curtestdir)*.c)
segment_allocator_sources					:= $(wildcard $(segment_allocator_path_curdir)*.c)
segment_allocator_sources					+= $(wildcard $(segment_allocator_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
segment_allocator_sources					+= $(wildcard $(segment_allocator_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
segment_allocator_sources					+= $(wildcard $(segment_allocator_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
segment_allocator_sources					+= $(wildcard $(segment_allocator_path_curdir)platform_specific/mac/*.c)
endif
segment_allocator_objects                  := $(patsubst %.c, %.o, $(segment_allocator_sources))
segment_allocator_test_objects				:= $(patsubst %.c, %.o, $(segment_allocator_test_sources))
segment_allocator_test_depends				:= $(patsubst %.c, %.d, $(segment_allocator_test_sources))
segment_allocator_depends					:= $(patsubst %.c, %.d, $(segment_allocator_sources))
segment_allocator_depends_modules			:=  common
segment_allocator_test_depends_modules     := segment_allocator test_framework libc common compare process file time system memory random file_reader hash circular_buffer mod 
segment_allocator_test_libdepend_objs      = $(foreach dep_module,$(segment_allocator_test_depends_modules),$($(dep_module)_objects))
segment_allocator_clean_files				:=
segment_allocator_clean_files				+= $(segment_allocator_install_path_implib)
segment_allocator_clean_files				+= $(segment_allocator_objects)
segment_allocator_clean_files				+= $(segment_allocator_test_objects)
segment_allocator_clean_files				+= $(segment_allocator_depends)

include $(segment_allocator_child_makefiles)

#$(segment_allocator_path_curtestdir)%.o: $(segment_allocator_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(segment_allocator_path_curdir)%.o: $(segment_allocator_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(segment_allocator_test_install_path): $(segment_allocator_test_objects) $(segment_allocator_test_libdepend_objs)
	$(CC) -o $@ $(segment_allocator_test_objects) $(segment_allocator_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: segment_allocator_all
segment_allocator_all: $(segment_allocator_objects) ## build all segment_allocator object files

.PHONY: segment_allocator_test_all
segment_allocator_test_all: $(segment_allocator_test_install_path) ## build segment_allocator_test test

.PHONY: segment_allocator_clean
segment_allocator_clean: $(segment_allocator_child_clean_targets) ## remove all segment_allocator object files
segment_allocator_clean:
	- $(RM) $(segment_allocator_clean_files)

.PHONY: segment_allocator_test_clean
segment_allocator_test_clean: $(segment_allocator_test_child_clean_targets) ## remove all segment_allocator_test tests
segment_allocator_test_clean:
	- $(RM) $(segment_allocator_test_install_path) $(segment_allocator_test_objects) $(segment_allocator_test_depends)

.PHONY: segment_allocator_re
segment_allocator_re: segment_allocator_clean
segment_allocator_re: segment_allocator_all

.PHONY: segment_allocator_test_re
segment_allocator_test_re: segment_allocator_test_clean
segment_allocator_test_re: segment_allocator_test_all

.PHONY: segment_allocator_test_run_all
segment_allocator_test_run_all: $(segment_allocator_test_child_run_targets) ## build and run segment_allocator_test
ifneq ($(segment_allocator_test_objects),)
segment_allocator_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(segment_allocator_test_install_path)
endif

.PHONY: segment_allocator_test_run
segment_allocator_test_run: segment_allocator_all
segment_allocator_test_run: segment_allocator_test_all
ifneq ($(segment_allocator_test_objects),)
segment_allocator_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(segment_allocator_test_install_path)
endif

-include $(segment_allocator_depends)
-include $(segment_allocator_test_depends)
