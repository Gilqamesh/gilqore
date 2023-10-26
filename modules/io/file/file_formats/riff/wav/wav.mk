wav_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
wav_path_curtestdir			:= $(wav_path_curdir)test/
wav_child_makefiles			:= $(wildcard $(wav_path_curdir)*/*mk)
wav_child_module_names		:= $(basename $(notdir $(wav_child_makefiles)))
wav_child_all_targets		:= $(foreach child_module,$(wav_child_module_names),$(child_module)_all)
wav_child_clean_targets		:= $(foreach child_module,$(wav_child_module_names),$(child_module)_clean)
wav_test_child_all_targets	:= $(foreach test_module,$(wav_child_module_names),$(test_module)_test_all)
wav_test_child_clean_targets	:= $(foreach test_module,$(wav_child_module_names),$(test_module)_test_clean)
wav_test_child_run_targets	:= $(foreach test_module,$(wav_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
wav_test_install_path        := $(wav_path_curtestdir)wav$(EXT_EXE)
endif
wav_test_sources             := $(wildcard $(wav_path_curtestdir)*.c)
wav_sources					:= $(wildcard $(wav_path_curdir)*.c)
wav_sources					+= $(wildcard $(wav_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
wav_sources					+= $(wildcard $(wav_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
wav_sources					+= $(wildcard $(wav_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
wav_sources					+= $(wildcard $(wav_path_curdir)platform_specific/mac/*.c)
endif
wav_objects                  := $(patsubst %.c, %.o, $(wav_sources))
wav_test_objects				:= $(patsubst %.c, %.o, $(wav_test_sources))
wav_test_depends				:= $(patsubst %.c, %.d, $(wav_test_sources))
wav_depends					:= $(patsubst %.c, %.d, $(wav_sources))
wav_depends_modules			:=  common
wav_test_depends_modules     := wav test_framework libc common compare process file time system memory random file_reader hash circular_buffer mod abs 
wav_test_libdepend_objs      = $(foreach dep_module,$(wav_test_depends_modules),$($(dep_module)_objects))
wav_clean_files				:=
wav_clean_files				+= $(wav_install_path_implib)
wav_clean_files				+= $(wav_objects)
wav_clean_files				+= $(wav_test_objects)
wav_clean_files				+= $(wav_depends)

include $(wav_child_makefiles)

#$(wav_path_curtestdir)%.o: $(wav_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(wav_path_curdir)%.o: $(wav_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(wav_test_install_path): $(wav_test_objects) $(wav_test_libdepend_objs)
	$(CC) -o $@ $(wav_test_objects) $(wav_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: wav_all
wav_all: $(wav_objects) ## build all wav object files

.PHONY: wav_test_all
wav_test_all: $(wav_test_install_path) ## build wav_test test

.PHONY: wav_clean
wav_clean: $(wav_child_clean_targets) ## remove all wav object files
wav_clean:
	- $(RM) $(wav_clean_files)

.PHONY: wav_test_clean
wav_test_clean: $(wav_test_child_clean_targets) ## remove all wav_test tests
wav_test_clean:
	- $(RM) $(wav_test_install_path) $(wav_test_objects) $(wav_test_depends)

.PHONY: wav_re
wav_re: wav_clean
wav_re: wav_all

.PHONY: wav_test_re
wav_test_re: wav_test_clean
wav_test_re: wav_test_all

.PHONY: wav_test_run_all
wav_test_run_all: $(wav_test_child_run_targets) ## build and run wav_test
ifneq ($(wav_test_objects),)
wav_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(wav_test_install_path)
endif

.PHONY: wav_test_run
wav_test_run: wav_all
wav_test_run: wav_test_all
ifneq ($(wav_test_objects),)
wav_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(wav_test_install_path)
endif

-include $(wav_depends)
-include $(wav_test_depends)
