types_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
types_path_curtestdir			:= $(types_path_curdir)test/
types_child_makefiles			:= $(wildcard $(types_path_curdir)*/*mk)
types_child_module_names		:= $(basename $(notdir $(types_child_makefiles)))
types_child_all_targets		:= $(foreach child_module,$(types_child_module_names),$(child_module)_all)
types_child_clean_targets		:= $(foreach child_module,$(types_child_module_names),$(child_module)_clean)
types_test_child_all_targets	:= $(foreach test_module,$(types_child_module_names),$(test_module)_test_all)
types_test_child_clean_targets	:= $(foreach test_module,$(types_child_module_names),$(test_module)_test_clean)
types_test_child_run_targets	:= $(foreach test_module,$(types_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
types_test_install_path        := $(types_path_curtestdir)types$(EXT_EXE)
endif
types_test_sources             := $(wildcard $(types_path_curtestdir)*.c)
types_sources					:= $(wildcard $(types_path_curdir)*.c)
types_sources					+= $(wildcard $(types_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
types_sources					+= $(wildcard $(types_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
types_sources					+= $(wildcard $(types_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
types_sources					+= $(wildcard $(types_path_curdir)platform_specific/mac/*.c)
endif
types_objects                  := $(patsubst %.c, %.o, $(types_sources))
types_test_objects				:= $(patsubst %.c, %.o, $(types_test_sources))
types_test_depends				:= $(patsubst %.c, %.d, $(types_test_sources))
types_depends					:= $(patsubst %.c, %.d, $(types_sources))
types_depends_modules			:=  common
types_test_depends_modules     := types test_framework libc common process file time system random compare file_reader hash circular_buffer mod memory 
types_test_libdepend_objs      = $(foreach dep_module,$(types_test_depends_modules),$($(dep_module)_objects))
types_clean_files				:=
types_clean_files				+= $(types_install_path_implib)
types_clean_files				+= $(types_objects)
types_clean_files				+= $(types_test_objects)
types_clean_files				+= $(types_depends)

include $(types_child_makefiles)

#$(types_path_curtestdir)%.o: $(types_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(types_path_curdir)%.o: $(types_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(types_test_install_path): $(types_test_objects) $(types_test_libdepend_objs)
	$(CC) -o $@ $(types_test_objects) -Wl,--allow-multiple-definition $(types_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: types_all
types_all: $(types_objects) ## build all types object files

.PHONY: types_test_all
types_test_all: $(types_test_install_path) ## build types_test test

.PHONY: types_clean
types_clean: $(types_child_clean_targets) ## remove all types object files
types_clean:
	- $(RM) $(types_clean_files)

.PHONY: types_test_clean
types_test_clean: $(types_test_child_clean_targets) ## remove all types_test tests
types_test_clean:
	- $(RM) $(types_test_install_path) $(types_test_objects) $(types_test_depends)

.PHONY: types_re
types_re: types_clean
types_re: types_all

.PHONY: types_test_re
types_test_re: types_test_clean
types_test_re: types_test_all

.PHONY: types_test_run_all
types_test_run_all: $(types_test_child_run_targets) ## build and run types_test
ifneq ($(types_test_objects),)
types_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(types_test_install_path)
endif

.PHONY: types_test_run
types_test_run: types_all
types_test_run: types_test_all
ifneq ($(types_test_objects),)
types_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(types_test_install_path)
endif

-include $(types_depends)
-include $(types_test_depends)
