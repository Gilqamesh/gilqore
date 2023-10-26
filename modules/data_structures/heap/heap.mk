heap_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
heap_path_curtestdir			:= $(heap_path_curdir)test/
heap_child_makefiles			:= $(wildcard $(heap_path_curdir)*/*mk)
heap_child_module_names		:= $(basename $(notdir $(heap_child_makefiles)))
heap_child_all_targets		:= $(foreach child_module,$(heap_child_module_names),$(child_module)_all)
heap_child_clean_targets		:= $(foreach child_module,$(heap_child_module_names),$(child_module)_clean)
heap_test_child_all_targets	:= $(foreach test_module,$(heap_child_module_names),$(test_module)_test_all)
heap_test_child_clean_targets	:= $(foreach test_module,$(heap_child_module_names),$(test_module)_test_clean)
heap_test_child_run_targets	:= $(foreach test_module,$(heap_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
heap_test_install_path        := $(heap_path_curtestdir)heap$(EXT_EXE)
endif
heap_test_sources             := $(wildcard $(heap_path_curtestdir)*.c)
heap_sources					:= $(wildcard $(heap_path_curdir)*.c)
heap_sources					+= $(wildcard $(heap_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
heap_sources					+= $(wildcard $(heap_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
heap_sources					+= $(wildcard $(heap_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
heap_sources					+= $(wildcard $(heap_path_curdir)platform_specific/mac/*.c)
endif
heap_objects                  := $(patsubst %.c, %.o, $(heap_sources))
heap_test_objects				:= $(patsubst %.c, %.o, $(heap_test_sources))
heap_test_depends				:= $(patsubst %.c, %.d, $(heap_test_sources))
heap_depends					:= $(patsubst %.c, %.d, $(heap_sources))
heap_depends_modules			:= libc common compare  common
heap_test_depends_modules     := heap libc common compare test_framework process file time system memory random file_reader hash circular_buffer mod abs 
heap_test_libdepend_objs      = $(foreach dep_module,$(heap_test_depends_modules),$($(dep_module)_objects))
heap_clean_files				:=
heap_clean_files				+= $(heap_install_path_implib)
heap_clean_files				+= $(heap_objects)
heap_clean_files				+= $(heap_test_objects)
heap_clean_files				+= $(heap_depends)

include $(heap_child_makefiles)

#$(heap_path_curtestdir)%.o: $(heap_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(heap_path_curdir)%.o: $(heap_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(heap_test_install_path): $(heap_test_objects) $(heap_test_libdepend_objs)
	$(CC) -o $@ $(heap_test_objects) $(heap_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: heap_all
heap_all: $(heap_objects) ## build all heap object files

.PHONY: heap_test_all
heap_test_all: $(heap_test_install_path) ## build heap_test test

.PHONY: heap_clean
heap_clean: $(heap_child_clean_targets) ## remove all heap object files
heap_clean:
	- $(RM) $(heap_clean_files)

.PHONY: heap_test_clean
heap_test_clean: $(heap_test_child_clean_targets) ## remove all heap_test tests
heap_test_clean:
	- $(RM) $(heap_test_install_path) $(heap_test_objects) $(heap_test_depends)

.PHONY: heap_re
heap_re: heap_clean
heap_re: heap_all

.PHONY: heap_test_re
heap_test_re: heap_test_clean
heap_test_re: heap_test_all

.PHONY: heap_test_run_all
heap_test_run_all: $(heap_test_child_run_targets) ## build and run heap_test
ifneq ($(heap_test_objects),)
heap_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(heap_test_install_path)
endif

.PHONY: heap_test_run
heap_test_run: heap_all
heap_test_run: heap_test_all
ifneq ($(heap_test_objects),)
heap_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(heap_test_install_path)
endif

-include $(heap_depends)
-include $(heap_test_depends)
