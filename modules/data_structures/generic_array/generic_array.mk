generic_array_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
generic_array_path_curtestdir			:= $(generic_array_path_curdir)test/
generic_array_child_makefiles			:= $(wildcard $(generic_array_path_curdir)*/*mk)
generic_array_child_module_names		:= $(basename $(notdir $(generic_array_child_makefiles)))
generic_array_child_all_targets		:= $(foreach child_module,$(generic_array_child_module_names),$(child_module)_all)
generic_array_child_clean_targets		:= $(foreach child_module,$(generic_array_child_module_names),$(child_module)_clean)
generic_array_test_child_all_targets	:= $(foreach test_module,$(generic_array_child_module_names),$(test_module)_test_all)
generic_array_test_child_clean_targets	:= $(foreach test_module,$(generic_array_child_module_names),$(test_module)_test_clean)
generic_array_test_child_run_targets	:= $(foreach test_module,$(generic_array_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
generic_array_test_install_path        := $(generic_array_path_curtestdir)generic_array$(EXT_EXE)
endif
generic_array_test_sources             := $(wildcard $(generic_array_path_curtestdir)*.c)
generic_array_sources					:= $(wildcard $(generic_array_path_curdir)*.c)
generic_array_sources					+= $(wildcard $(generic_array_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
generic_array_sources					+= $(wildcard $(generic_array_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
generic_array_sources					+= $(wildcard $(generic_array_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
generic_array_sources					+= $(wildcard $(generic_array_path_curdir)platform_specific/mac/*.c)
endif
generic_array_objects                  := $(patsubst %.c, %.o, $(generic_array_sources))
generic_array_test_objects				:= $(patsubst %.c, %.o, $(generic_array_test_sources))
generic_array_test_depends				:= $(patsubst %.c, %.d, $(generic_array_test_sources))
generic_array_depends					:= $(patsubst %.c, %.d, $(generic_array_sources))
generic_array_depends_modules			:=  common
generic_array_test_depends_modules     := generic_array test_framework libc common process file time system random compare file_reader hash circular_buffer mod 
generic_array_test_libdepend_objs      = $(foreach dep_module,$(generic_array_test_depends_modules),$($(dep_module)_objects))
generic_array_clean_files				:=
generic_array_clean_files				+= $(generic_array_install_path_implib)
generic_array_clean_files				+= $(generic_array_objects)
generic_array_clean_files				+= $(generic_array_test_objects)
generic_array_clean_files				+= $(generic_array_depends)

include $(generic_array_child_makefiles)

#$(generic_array_path_curtestdir)%.o: $(generic_array_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(generic_array_path_curdir)%.o: $(generic_array_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(generic_array_test_install_path): $(generic_array_test_objects) $(generic_array_test_libdepend_objs)
	$(CC) -o $@ $(generic_array_test_objects) -Wl,--allow-multiple-definition $(generic_array_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: generic_array_all
generic_array_all: $(generic_array_objects) ## build all generic_array object files

.PHONY: generic_array_test_all
generic_array_test_all: $(generic_array_test_install_path) ## build generic_array_test test

.PHONY: generic_array_clean
generic_array_clean: $(generic_array_child_clean_targets) ## remove all generic_array object files
generic_array_clean:
	- $(RM) $(generic_array_clean_files)

.PHONY: generic_array_test_clean
generic_array_test_clean: $(generic_array_test_child_clean_targets) ## remove all generic_array_test tests
generic_array_test_clean:
	- $(RM) $(generic_array_test_install_path) $(generic_array_test_objects) $(generic_array_test_depends)

.PHONY: generic_array_re
generic_array_re: generic_array_clean
generic_array_re: generic_array_all

.PHONY: generic_array_test_re
generic_array_test_re: generic_array_test_clean
generic_array_test_re: generic_array_test_all

.PHONY: generic_array_test_run_all
generic_array_test_run_all: $(generic_array_test_child_run_targets) ## build and run generic_array_test
ifneq ($(generic_array_test_objects),)
generic_array_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(generic_array_test_install_path)
endif

.PHONY: generic_array_test_run
generic_array_test_run: generic_array_all
generic_array_test_run: generic_array_test_all
ifneq ($(generic_array_test_objects),)
generic_array_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(generic_array_test_install_path)
endif

-include $(generic_array_depends)
-include $(generic_array_test_depends)
