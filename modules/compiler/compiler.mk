compiler_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
compiler_path_curtestdir			:= $(compiler_path_curdir)test/
compiler_child_makefiles			:= $(wildcard $(compiler_path_curdir)*/*mk)
compiler_child_module_names		:= $(basename $(notdir $(compiler_child_makefiles)))
compiler_child_all_targets		:= $(foreach child_module,$(compiler_child_module_names),$(child_module)_all)
compiler_child_clean_targets		:= $(foreach child_module,$(compiler_child_module_names),$(child_module)_clean)
compiler_test_child_all_targets	:= $(foreach test_module,$(compiler_child_module_names),$(test_module)_test_all)
compiler_test_child_clean_targets	:= $(foreach test_module,$(compiler_child_module_names),$(test_module)_test_clean)
compiler_test_child_run_targets	:= $(foreach test_module,$(compiler_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
compiler_test_install_path        := $(compiler_path_curtestdir)compiler$(EXT_EXE)
endif
compiler_test_sources             := $(wildcard $(compiler_path_curtestdir)*.c)
compiler_sources					:= $(wildcard $(compiler_path_curdir)*.c)
compiler_sources					+= $(wildcard $(compiler_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
compiler_sources					+= $(wildcard $(compiler_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
compiler_sources					+= $(wildcard $(compiler_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
compiler_sources					+= $(wildcard $(compiler_path_curdir)platform_specific/mac/*.c)
endif
compiler_objects                  := $(patsubst %.c, %.o, $(compiler_sources))
compiler_test_objects				:= $(patsubst %.c, %.o, $(compiler_test_sources))
compiler_test_depends				:= $(patsubst %.c, %.d, $(compiler_test_sources))
compiler_depends					:= $(patsubst %.c, %.d, $(compiler_sources))
compiler_depends_modules			:=  common
compiler_test_depends_modules     := compiler test_framework libc common compare process file time system memory random file_reader hash circular_buffer mod abs 
compiler_test_libdepend_objs      = $(foreach dep_module,$(compiler_test_depends_modules),$($(dep_module)_objects))
compiler_clean_files				:=
compiler_clean_files				+= $(compiler_install_path_implib)
compiler_clean_files				+= $(compiler_objects)
compiler_clean_files				+= $(compiler_test_objects)
compiler_clean_files				+= $(compiler_depends)

include $(compiler_child_makefiles)

#$(compiler_path_curtestdir)%.o: $(compiler_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(compiler_path_curdir)%.o: $(compiler_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(compiler_test_install_path): $(compiler_test_objects) $(compiler_test_libdepend_objs)
	$(CC) -o $@ $(compiler_test_objects) $(compiler_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: compiler_all
compiler_all: $(compiler_objects) ## build all compiler object files

.PHONY: compiler_test_all
compiler_test_all: $(compiler_test_install_path) ## build compiler_test test

.PHONY: compiler_clean
compiler_clean: $(compiler_child_clean_targets) ## remove all compiler object files
compiler_clean:
	- $(RM) $(compiler_clean_files)

.PHONY: compiler_test_clean
compiler_test_clean: $(compiler_test_child_clean_targets) ## remove all compiler_test tests
compiler_test_clean:
	- $(RM) $(compiler_test_install_path) $(compiler_test_objects) $(compiler_test_depends)

.PHONY: compiler_re
compiler_re: compiler_clean
compiler_re: compiler_all

.PHONY: compiler_test_re
compiler_test_re: compiler_test_clean
compiler_test_re: compiler_test_all

.PHONY: compiler_test_run_all
compiler_test_run_all: $(compiler_test_child_run_targets) ## build and run compiler_test
ifneq ($(compiler_test_objects),)
compiler_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(compiler_test_install_path)
endif

.PHONY: compiler_test_run
compiler_test_run: compiler_all
compiler_test_run: compiler_test_all
ifneq ($(compiler_test_objects),)
compiler_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(compiler_test_install_path)
endif

-include $(compiler_depends)
-include $(compiler_test_depends)
