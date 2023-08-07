giescript_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
giescript_path_curtestdir			:= $(giescript_path_curdir)test/
giescript_child_makefiles			:= $(wildcard $(giescript_path_curdir)*/*mk)
giescript_child_module_names		:= $(basename $(notdir $(giescript_child_makefiles)))
giescript_child_all_targets		:= $(foreach child_module,$(giescript_child_module_names),$(child_module)_all)
giescript_child_clean_targets		:= $(foreach child_module,$(giescript_child_module_names),$(child_module)_clean)
giescript_test_child_all_targets	:= $(foreach test_module,$(giescript_child_module_names),$(test_module)_test_all)
giescript_test_child_clean_targets	:= $(foreach test_module,$(giescript_child_module_names),$(test_module)_test_clean)
giescript_test_child_run_targets	:= $(foreach test_module,$(giescript_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
giescript_test_install_path        := $(giescript_path_curtestdir)giescript$(EXT_EXE)
endif
giescript_test_sources             := $(wildcard $(giescript_path_curtestdir)*.c)
giescript_sources					:= $(wildcard $(giescript_path_curdir)*.c)
giescript_sources					+= $(wildcard $(giescript_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
giescript_sources					+= $(wildcard $(giescript_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
giescript_sources					+= $(wildcard $(giescript_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
giescript_sources					+= $(wildcard $(giescript_path_curdir)platform_specific/mac/*.c)
endif
giescript_objects                  := $(patsubst %.c, %.o, $(giescript_sources))
giescript_test_objects				:= $(patsubst %.c, %.o, $(giescript_test_sources))
giescript_test_depends				:= $(patsubst %.c, %.d, $(giescript_test_sources))
giescript_depends					:= $(patsubst %.c, %.d, $(giescript_sources))
giescript_depends_modules			:= libc common compare segment_allocator memory  common
giescript_test_depends_modules     := giescript libc common compare segment_allocator memory test_framework process file time system random file_reader hash circular_buffer mod 
giescript_test_libdepend_objs      = $(foreach dep_module,$(giescript_test_depends_modules),$($(dep_module)_objects))
giescript_clean_files				:=
giescript_clean_files				+= $(giescript_install_path_implib)
giescript_clean_files				+= $(giescript_objects)
giescript_clean_files				+= $(giescript_test_objects)
giescript_clean_files				+= $(giescript_depends)

include $(giescript_child_makefiles)

#$(giescript_path_curtestdir)%.o: $(giescript_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(giescript_path_curdir)%.o: $(giescript_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(giescript_test_install_path): $(giescript_test_objects) $(giescript_test_libdepend_objs)
	$(CC) -o $@ $(giescript_test_objects) $(giescript_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: giescript_all
giescript_all: $(giescript_objects) ## build all giescript object files

.PHONY: giescript_test_all
giescript_test_all: $(giescript_test_install_path) ## build giescript_test test

.PHONY: giescript_clean
giescript_clean: $(giescript_child_clean_targets) ## remove all giescript object files
giescript_clean:
	- $(RM) $(giescript_clean_files)

.PHONY: giescript_test_clean
giescript_test_clean: $(giescript_test_child_clean_targets) ## remove all giescript_test tests
giescript_test_clean:
	- $(RM) $(giescript_test_install_path) $(giescript_test_objects) $(giescript_test_depends)

.PHONY: giescript_re
giescript_re: giescript_clean
giescript_re: giescript_all

.PHONY: giescript_test_re
giescript_test_re: giescript_test_clean
giescript_test_re: giescript_test_all

.PHONY: giescript_test_run_all
giescript_test_run_all: $(giescript_test_child_run_targets) ## build and run giescript_test
ifneq ($(giescript_test_objects),)
giescript_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(giescript_test_install_path)
endif

.PHONY: giescript_test_run
giescript_test_run: giescript_all
giescript_test_run: giescript_test_all
ifneq ($(giescript_test_objects),)
giescript_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(giescript_test_install_path)
endif

-include $(giescript_depends)
-include $(giescript_test_depends)
