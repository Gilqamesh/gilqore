libc_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
libc_path_curtestdir			:= $(libc_path_curdir)test/
libc_child_makefiles			:= $(wildcard $(libc_path_curdir)*/*mk)
libc_child_module_names		:= $(basename $(notdir $(libc_child_makefiles)))
libc_child_all_targets		:= $(foreach child_module,$(libc_child_module_names),$(child_module)_all)
libc_child_clean_targets		:= $(foreach child_module,$(libc_child_module_names),$(child_module)_clean)
libc_test_child_all_targets	:= $(foreach test_module,$(libc_child_module_names),$(test_module)_test_all)
libc_test_child_clean_targets	:= $(foreach test_module,$(libc_child_module_names),$(test_module)_test_clean)
libc_test_child_run_targets	:= $(foreach test_module,$(libc_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
libc_test_install_path        := $(libc_path_curtestdir)libc$(EXT_EXE)
endif
libc_test_sources             := $(wildcard $(libc_path_curtestdir)*.c)
libc_sources					:= $(wildcard $(libc_path_curdir)*.c)
libc_sources					+= $(wildcard $(libc_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
libc_sources					+= $(wildcard $(libc_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
libc_sources					+= $(wildcard $(libc_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
libc_sources					+= $(wildcard $(libc_path_curdir)platform_specific/mac/*.c)
endif
libc_objects                  := $(patsubst %.c, %.o, $(libc_sources))
libc_test_objects				:= $(patsubst %.c, %.o, $(libc_test_sources))
libc_test_depends				:= $(patsubst %.c, %.d, $(libc_test_sources))
libc_depends					:= $(patsubst %.c, %.d, $(libc_sources))
libc_depends_modules			:= common compare  common
libc_test_depends_modules     := libc common compare test_framework process file time system random file_reader hash circular_buffer mod memory 
libc_test_libdepend_objs      = $(foreach dep_module,$(libc_test_depends_modules),$($(dep_module)_objects))
libc_clean_files				:=
libc_clean_files				+= $(libc_install_path_implib)
libc_clean_files				+= $(libc_objects)
libc_clean_files				+= $(libc_test_objects)
libc_clean_files				+= $(libc_depends)

include $(libc_child_makefiles)

#$(libc_path_curtestdir)%.o: $(libc_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(libc_path_curdir)%.o: $(libc_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(libc_test_install_path): $(libc_test_objects) $(libc_test_libdepend_objs)
	$(CC) -o $@ $(libc_test_objects) $(libc_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: libc_all
libc_all: $(libc_objects) ## build all libc object files

.PHONY: libc_test_all
libc_test_all: $(libc_test_install_path) ## build libc_test test

.PHONY: libc_clean
libc_clean: $(libc_child_clean_targets) ## remove all libc object files
libc_clean:
	- $(RM) $(libc_clean_files)

.PHONY: libc_test_clean
libc_test_clean: $(libc_test_child_clean_targets) ## remove all libc_test tests
libc_test_clean:
	- $(RM) $(libc_test_install_path) $(libc_test_objects) $(libc_test_depends)

.PHONY: libc_re
libc_re: libc_clean
libc_re: libc_all

.PHONY: libc_test_re
libc_test_re: libc_test_clean
libc_test_re: libc_test_all

.PHONY: libc_test_run_all
libc_test_run_all: $(libc_test_child_run_targets) ## build and run libc_test
ifneq ($(libc_test_objects),)
libc_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(libc_test_install_path)
endif

.PHONY: libc_test_run
libc_test_run: libc_all
libc_test_run: libc_test_all
ifneq ($(libc_test_objects),)
libc_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(libc_test_install_path)
endif

-include $(libc_depends)
-include $(libc_test_depends)
