sqrt_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
sqrt_path_curtestdir			:= $(sqrt_path_curdir)test/
sqrt_child_makefiles			:= $(wildcard $(sqrt_path_curdir)*/*mk)
sqrt_child_module_names		:= $(basename $(notdir $(sqrt_child_makefiles)))
sqrt_child_all_targets		:= $(foreach child_module,$(sqrt_child_module_names),$(child_module)_all)
sqrt_child_clean_targets		:= $(foreach child_module,$(sqrt_child_module_names),$(child_module)_clean)
sqrt_test_child_all_targets	:= $(foreach test_module,$(sqrt_child_module_names),$(test_module)_test_all)
sqrt_test_child_clean_targets	:= $(foreach test_module,$(sqrt_child_module_names),$(test_module)_test_clean)
sqrt_test_child_run_targets	:= $(foreach test_module,$(sqrt_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
sqrt_test_install_path        := $(sqrt_path_curtestdir)sqrt$(EXT_EXE)
endif
sqrt_test_sources             := $(wildcard $(sqrt_path_curtestdir)*.c)
sqrt_sources					:= $(wildcard $(sqrt_path_curdir)*.c)
sqrt_sources					+= $(wildcard $(sqrt_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
sqrt_sources					+= $(wildcard $(sqrt_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
sqrt_sources					+= $(wildcard $(sqrt_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
sqrt_sources					+= $(wildcard $(sqrt_path_curdir)platform_specific/mac/*.c)
endif
sqrt_objects                  := $(patsubst %.c, %.o, $(sqrt_sources))
sqrt_test_objects				:= $(patsubst %.c, %.o, $(sqrt_test_sources))
sqrt_test_depends				:= $(patsubst %.c, %.d, $(sqrt_test_sources))
sqrt_depends					:= $(patsubst %.c, %.d, $(sqrt_sources))
sqrt_depends_modules			:=  common
sqrt_test_depends_modules     := sqrt test_framework libc common compare process file time system memory random file_reader hash circular_buffer mod abs 
sqrt_test_libdepend_objs      = $(foreach dep_module,$(sqrt_test_depends_modules),$($(dep_module)_objects))
sqrt_clean_files				:=
sqrt_clean_files				+= $(sqrt_install_path_implib)
sqrt_clean_files				+= $(sqrt_objects)
sqrt_clean_files				+= $(sqrt_test_objects)
sqrt_clean_files				+= $(sqrt_depends)

include $(sqrt_child_makefiles)

#$(sqrt_path_curtestdir)%.o: $(sqrt_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(sqrt_path_curdir)%.o: $(sqrt_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(sqrt_test_install_path): $(sqrt_test_objects) $(sqrt_test_libdepend_objs)
	$(CC) -o $@ $(sqrt_test_objects) $(sqrt_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: sqrt_all
sqrt_all: $(sqrt_objects) ## build all sqrt object files

.PHONY: sqrt_test_all
sqrt_test_all: $(sqrt_test_install_path) ## build sqrt_test test

.PHONY: sqrt_clean
sqrt_clean: $(sqrt_child_clean_targets) ## remove all sqrt object files
sqrt_clean:
	- $(RM) $(sqrt_clean_files)

.PHONY: sqrt_test_clean
sqrt_test_clean: $(sqrt_test_child_clean_targets) ## remove all sqrt_test tests
sqrt_test_clean:
	- $(RM) $(sqrt_test_install_path) $(sqrt_test_objects) $(sqrt_test_depends)

.PHONY: sqrt_re
sqrt_re: sqrt_clean
sqrt_re: sqrt_all

.PHONY: sqrt_test_re
sqrt_test_re: sqrt_test_clean
sqrt_test_re: sqrt_test_all

.PHONY: sqrt_test_run_all
sqrt_test_run_all: $(sqrt_test_child_run_targets) ## build and run sqrt_test
ifneq ($(sqrt_test_objects),)
sqrt_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(sqrt_test_install_path)
endif

.PHONY: sqrt_test_run
sqrt_test_run: sqrt_all
sqrt_test_run: sqrt_test_all
ifneq ($(sqrt_test_objects),)
sqrt_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(sqrt_test_install_path)
endif

-include $(sqrt_depends)
-include $(sqrt_test_depends)
