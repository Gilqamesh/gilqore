window_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
window_path_curtestdir			:= $(window_path_curdir)test/
window_child_makefiles			:= $(wildcard $(window_path_curdir)*/*mk)
window_child_module_names		:= $(basename $(notdir $(window_child_makefiles)))
window_child_all_targets		:= $(foreach child_module,$(window_child_module_names),$(child_module)_all)
window_child_clean_targets		:= $(foreach child_module,$(window_child_module_names),$(child_module)_clean)
window_test_child_all_targets	:= $(foreach test_module,$(window_child_module_names),$(test_module)_test_all)
window_test_child_clean_targets	:= $(foreach test_module,$(window_child_module_names),$(test_module)_test_clean)
window_test_child_run_targets	:= $(foreach test_module,$(window_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
window_test_install_path        := $(window_path_curtestdir)window$(EXT_EXE)
endif
window_test_sources             := $(wildcard $(window_path_curtestdir)*.c)
window_sources					:= $(wildcard $(window_path_curdir)*.c)
window_sources					+= $(wildcard $(window_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
window_sources					+= $(wildcard $(window_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
window_sources					+= $(wildcard $(window_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
window_sources					+= $(wildcard $(window_path_curdir)platform_specific/mac/*.c)
endif
window_objects                  := $(patsubst %.c, %.o, $(window_sources))
window_test_objects				:= $(patsubst %.c, %.o, $(window_test_sources))
window_test_depends				:= $(patsubst %.c, %.d, $(window_test_sources))
window_depends					:= $(patsubst %.c, %.d, $(window_sources))
window_depends_modules			:=  common
window_test_depends_modules     := window test_framework libc common compare process file time system memory random file_reader hash circular_buffer mod abs 
window_test_libdepend_objs      = $(foreach dep_module,$(window_test_depends_modules),$($(dep_module)_objects))
window_clean_files				:=
window_clean_files				+= $(window_install_path_implib)
window_clean_files				+= $(window_objects)
window_clean_files				+= $(window_test_objects)
window_clean_files				+= $(window_depends)

include $(window_child_makefiles)

#$(window_path_curtestdir)%.o: $(window_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(window_path_curdir)%.o: $(window_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(window_test_install_path): $(window_test_objects) $(window_test_libdepend_objs)
	$(CC) -o $@ $(window_test_objects) $(window_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: window_all
window_all: $(window_objects) ## build all window object files

.PHONY: window_test_all
window_test_all: $(window_test_install_path) ## build window_test test

.PHONY: window_clean
window_clean: $(window_child_clean_targets) ## remove all window object files
window_clean:
	- $(RM) $(window_clean_files)

.PHONY: window_test_clean
window_test_clean: $(window_test_child_clean_targets) ## remove all window_test tests
window_test_clean:
	- $(RM) $(window_test_install_path) $(window_test_objects) $(window_test_depends)

.PHONY: window_re
window_re: window_clean
window_re: window_all

.PHONY: window_test_re
window_test_re: window_test_clean
window_test_re: window_test_all

.PHONY: window_test_run_all
window_test_run_all: $(window_test_child_run_targets) ## build and run window_test
ifneq ($(window_test_objects),)
window_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(window_test_install_path)
endif

.PHONY: window_test_run
window_test_run: window_all
window_test_run: window_test_all
ifneq ($(window_test_objects),)
window_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(window_test_install_path)
endif

-include $(window_depends)
-include $(window_test_depends)
