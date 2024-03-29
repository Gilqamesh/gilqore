riff_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
riff_path_curtestdir			:= $(riff_path_curdir)test/
riff_child_makefiles			:= $(wildcard $(riff_path_curdir)*/*mk)
riff_child_module_names		:= $(basename $(notdir $(riff_child_makefiles)))
riff_child_all_targets		:= $(foreach child_module,$(riff_child_module_names),$(child_module)_all)
riff_child_clean_targets		:= $(foreach child_module,$(riff_child_module_names),$(child_module)_clean)
riff_test_child_all_targets	:= $(foreach test_module,$(riff_child_module_names),$(test_module)_test_all)
riff_test_child_clean_targets	:= $(foreach test_module,$(riff_child_module_names),$(test_module)_test_clean)
riff_test_child_run_targets	:= $(foreach test_module,$(riff_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
riff_test_install_path        := $(riff_path_curtestdir)riff$(EXT_EXE)
endif
riff_test_sources             := $(wildcard $(riff_path_curtestdir)*.c)
riff_sources					:= $(wildcard $(riff_path_curdir)*.c)
riff_sources					+= $(wildcard $(riff_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
riff_sources					+= $(wildcard $(riff_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
riff_sources					+= $(wildcard $(riff_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
riff_sources					+= $(wildcard $(riff_path_curdir)platform_specific/mac/*.c)
endif
riff_objects                  := $(patsubst %.c, %.o, $(riff_sources))
riff_test_objects				:= $(patsubst %.c, %.o, $(riff_test_sources))
riff_test_depends				:= $(patsubst %.c, %.d, $(riff_test_sources))
riff_depends					:= $(patsubst %.c, %.d, $(riff_sources))
riff_depends_modules			:=  common
riff_test_depends_modules     := riff test_framework libc common compare process file time system memory random file_reader hash circular_buffer mod abs 
riff_test_libdepend_objs      = $(foreach dep_module,$(riff_test_depends_modules),$($(dep_module)_objects))
riff_clean_files				:=
riff_clean_files				+= $(riff_install_path_implib)
riff_clean_files				+= $(riff_objects)
riff_clean_files				+= $(riff_test_objects)
riff_clean_files				+= $(riff_depends)

include $(riff_child_makefiles)

#$(riff_path_curtestdir)%.o: $(riff_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(riff_path_curdir)%.o: $(riff_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(riff_test_install_path): $(riff_test_objects) $(riff_test_libdepend_objs)
	$(CC) -o $@ $(riff_test_objects) $(riff_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: riff_all
riff_all: $(riff_objects) ## build all riff object files

.PHONY: riff_test_all
riff_test_all: $(riff_test_install_path) ## build riff_test test

.PHONY: riff_clean
riff_clean: $(riff_child_clean_targets) ## remove all riff object files
riff_clean:
	- $(RM) $(riff_clean_files)

.PHONY: riff_test_clean
riff_test_clean: $(riff_test_child_clean_targets) ## remove all riff_test tests
riff_test_clean:
	- $(RM) $(riff_test_install_path) $(riff_test_objects) $(riff_test_depends)

.PHONY: riff_re
riff_re: riff_clean
riff_re: riff_all

.PHONY: riff_test_re
riff_test_re: riff_test_clean
riff_test_re: riff_test_all

.PHONY: riff_test_run_all
riff_test_run_all: $(riff_test_child_run_targets) ## build and run riff_test
ifneq ($(riff_test_objects),)
riff_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(riff_test_install_path)
endif

.PHONY: riff_test_run
riff_test_run: riff_all
riff_test_run: riff_test_all
ifneq ($(riff_test_objects),)
riff_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(riff_test_install_path)
endif

-include $(riff_depends)
-include $(riff_test_depends)
