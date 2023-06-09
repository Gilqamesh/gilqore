graphics_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
graphics_path_curtestdir			:= $(graphics_path_curdir)test/
graphics_child_makefiles			:= $(wildcard $(graphics_path_curdir)*/*mk)
graphics_child_module_names		:= $(basename $(notdir $(graphics_child_makefiles)))
graphics_child_all_targets		:= $(foreach child_module,$(graphics_child_module_names),$(child_module)_all)
graphics_child_clean_targets		:= $(foreach child_module,$(graphics_child_module_names),$(child_module)_clean)
graphics_test_child_all_targets	:= $(foreach test_module,$(graphics_child_module_names),$(test_module)_test_all)
graphics_test_child_clean_targets	:= $(foreach test_module,$(graphics_child_module_names),$(test_module)_test_clean)
graphics_test_child_run_targets	:= $(foreach test_module,$(graphics_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
graphics_test_install_path        := $(graphics_path_curtestdir)graphics$(EXT_EXE)
endif
graphics_test_sources             := $(wildcard $(graphics_path_curtestdir)*.c)
graphics_sources					:= $(wildcard $(graphics_path_curdir)*.c)
graphics_sources					+= $(wildcard $(graphics_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
graphics_sources					+= $(wildcard $(graphics_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
graphics_sources					+= $(wildcard $(graphics_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
graphics_sources					+= $(wildcard $(graphics_path_curdir)platform_specific/mac/*.c)
endif
graphics_objects                  := $(patsubst %.c, %.o, $(graphics_sources))
graphics_test_objects				:= $(patsubst %.c, %.o, $(graphics_test_sources))
graphics_test_depends				:= $(patsubst %.c, %.d, $(graphics_test_sources))
graphics_depends					:= $(patsubst %.c, %.d, $(graphics_sources))
graphics_depends_modules			:=  common
graphics_test_depends_modules     := graphics test_framework libc common compare process file time system random file_reader hash circular_buffer mod memory 
graphics_test_libdepend_objs      = $(foreach dep_module,$(graphics_test_depends_modules),$($(dep_module)_objects))
graphics_clean_files				:=
graphics_clean_files				+= $(graphics_install_path_implib)
graphics_clean_files				+= $(graphics_objects)
graphics_clean_files				+= $(graphics_test_objects)
graphics_clean_files				+= $(graphics_depends)

include $(graphics_child_makefiles)

#$(graphics_path_curtestdir)%.o: $(graphics_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(graphics_path_curdir)%.o: $(graphics_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(graphics_test_install_path): $(graphics_test_objects) $(graphics_test_libdepend_objs)
	$(CC) -o $@ $(graphics_test_objects) $(graphics_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: graphics_all
graphics_all: $(graphics_objects) ## build all graphics object files

.PHONY: graphics_test_all
graphics_test_all: $(graphics_test_install_path) ## build graphics_test test

.PHONY: graphics_clean
graphics_clean: $(graphics_child_clean_targets) ## remove all graphics object files
graphics_clean:
	- $(RM) $(graphics_clean_files)

.PHONY: graphics_test_clean
graphics_test_clean: $(graphics_test_child_clean_targets) ## remove all graphics_test tests
graphics_test_clean:
	- $(RM) $(graphics_test_install_path) $(graphics_test_objects) $(graphics_test_depends)

.PHONY: graphics_re
graphics_re: graphics_clean
graphics_re: graphics_all

.PHONY: graphics_test_re
graphics_test_re: graphics_test_clean
graphics_test_re: graphics_test_all

.PHONY: graphics_test_run_all
graphics_test_run_all: $(graphics_test_child_run_targets) ## build and run graphics_test
ifneq ($(graphics_test_objects),)
graphics_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(graphics_test_install_path)
endif

.PHONY: graphics_test_run
graphics_test_run: graphics_all
graphics_test_run: graphics_test_all
ifneq ($(graphics_test_objects),)
graphics_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(graphics_test_install_path)
endif

-include $(graphics_depends)
-include $(graphics_test_depends)
