test_framework_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
test_framework_path_curtestdir			:= $(test_framework_path_curdir)test/
test_framework_child_makefiles			:= $(wildcard $(test_framework_path_curdir)*/*mk)
test_framework_child_module_names		:= $(basename $(notdir $(test_framework_child_makefiles)))
test_framework_child_all_targets		:= $(foreach child_module,$(test_framework_child_module_names),$(child_module)_all)
test_framework_child_clean_targets		:= $(foreach child_module,$(test_framework_child_module_names),$(child_module)_clean)
test_framework_test_child_all_targets	:= $(foreach test_module,$(test_framework_child_module_names),$(test_module)_test_all)
test_framework_test_child_clean_targets	:= $(foreach test_module,$(test_framework_child_module_names),$(test_module)_test_clean)
test_framework_test_child_run_targets	:= $(foreach test_module,$(test_framework_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
test_framework_test_install_path        := $(test_framework_path_curtestdir)test_framework$(EXT_EXE)
endif
test_framework_test_sources             := $(wildcard $(test_framework_path_curtestdir)*.c)
test_framework_sources					:= $(wildcard $(test_framework_path_curdir)*.c)
test_framework_sources					+= $(wildcard $(test_framework_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
test_framework_sources					+= $(wildcard $(test_framework_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
test_framework_sources					+= $(wildcard $(test_framework_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
test_framework_sources					+= $(wildcard $(test_framework_path_curdir)platform_specific/mac/*.c)
endif
test_framework_objects                  := $(patsubst %.c, %.o, $(test_framework_sources))
test_framework_test_objects				:= $(patsubst %.c, %.o, $(test_framework_test_sources))
test_framework_test_depends				:= $(patsubst %.c, %.d, $(test_framework_test_sources))
test_framework_depends					:= $(patsubst %.c, %.d, $(test_framework_sources))
test_framework_depends_modules			:= libc common compare process file time system random file_reader hash circular_buffer mod memory  common
test_framework_test_depends_modules     := test_framework libc common compare process file time system random file_reader hash circular_buffer mod memory 
test_framework_test_libdepend_objs      = $(foreach dep_module,$(test_framework_test_depends_modules),$($(dep_module)_objects))
test_framework_clean_files				:=
test_framework_clean_files				+= $(test_framework_install_path_implib)
test_framework_clean_files				+= $(test_framework_objects)
test_framework_clean_files				+= $(test_framework_test_objects)
test_framework_clean_files				+= $(test_framework_depends)

include $(test_framework_child_makefiles)

#$(test_framework_path_curtestdir)%.o: $(test_framework_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(test_framework_path_curdir)%.o: $(test_framework_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(test_framework_test_install_path): $(test_framework_test_objects) $(test_framework_test_libdepend_objs)
	$(CC) -o $@ $(test_framework_test_objects) $(test_framework_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: test_framework_all
test_framework_all: $(test_framework_objects) ## build all test_framework object files

.PHONY: test_framework_test_all
test_framework_test_all: $(test_framework_test_install_path) ## build test_framework_test test

.PHONY: test_framework_clean
test_framework_clean: $(test_framework_child_clean_targets) ## remove all test_framework object files
test_framework_clean:
	- $(RM) $(test_framework_clean_files)

.PHONY: test_framework_test_clean
test_framework_test_clean: $(test_framework_test_child_clean_targets) ## remove all test_framework_test tests
test_framework_test_clean:
	- $(RM) $(test_framework_test_install_path) $(test_framework_test_objects) $(test_framework_test_depends)

.PHONY: test_framework_re
test_framework_re: test_framework_clean
test_framework_re: test_framework_all

.PHONY: test_framework_test_re
test_framework_test_re: test_framework_test_clean
test_framework_test_re: test_framework_test_all

.PHONY: test_framework_test_run_all
test_framework_test_run_all: $(test_framework_test_child_run_targets) ## build and run test_framework_test
ifneq ($(test_framework_test_objects),)
test_framework_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(test_framework_test_install_path)
endif

.PHONY: test_framework_test_run
test_framework_test_run: test_framework_all
test_framework_test_run: test_framework_test_all
ifneq ($(test_framework_test_objects),)
test_framework_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(test_framework_test_install_path)
endif

-include $(test_framework_depends)
-include $(test_framework_test_depends)
