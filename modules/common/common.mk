common_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
common_path_curtestdir			:= $(common_path_curdir)test/
common_child_makefiles			:= $(wildcard $(common_path_curdir)*/*mk)
common_child_module_names		:= $(basename $(notdir $(common_child_makefiles)))
common_child_all_targets		:= $(foreach child_module,$(common_child_module_names),$(child_module)_all)
common_child_clean_targets		:= $(foreach child_module,$(common_child_module_names),$(child_module)_clean)
common_test_child_all_targets	:= $(foreach test_module,$(common_child_module_names),$(test_module)_test_all)
common_test_child_clean_targets	:= $(foreach test_module,$(common_child_module_names),$(test_module)_test_clean)
common_test_child_run_targets	:= $(foreach test_module,$(common_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
common_test_install_path        := $(common_path_curtestdir)common$(EXT_EXE)
endif
common_test_sources             := $(wildcard $(common_path_curtestdir)*.c)
common_sources					:= $(wildcard $(common_path_curdir)*.c)
common_sources					+= $(wildcard $(common_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
common_sources					+= $(wildcard $(common_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
common_sources					+= $(wildcard $(common_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
common_sources					+= $(wildcard $(common_path_curdir)platform_specific/mac/*.c)
endif
common_objects                  := $(patsubst %.c, %.o, $(common_sources))
common_test_objects				:= $(patsubst %.c, %.o, $(common_test_sources))
common_test_depends				:= $(patsubst %.c, %.d, $(common_test_sources))
common_depends					:= $(patsubst %.c, %.d, $(common_sources))
common_depends_modules			:=  common
common_test_depends_modules     := common test_framework libc compare process file time system random file_reader hash circular_buffer mod memory 
common_test_libdepend_objs      = $(foreach dep_module,$(common_test_depends_modules),$($(dep_module)_objects))
common_clean_files				:=
common_clean_files				+= $(common_install_path_implib)
common_clean_files				+= $(common_objects)
common_clean_files				+= $(common_test_objects)
common_clean_files				+= $(common_depends)

include $(common_child_makefiles)

#$(common_path_curtestdir)%.o: $(common_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(common_path_curdir)%.o: $(common_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(common_test_install_path): $(common_test_objects) $(common_test_libdepend_objs)
	$(CC) -o $@ $(common_test_objects) $(common_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole tcc/lib/libtcc1-64.a tcc/libtcc.dll

.PHONY: common_all
common_all: $(common_objects) ## build all common object files

.PHONY: common_test_all
common_test_all: $(common_test_install_path) ## build common_test test

.PHONY: common_clean
common_clean: $(common_child_clean_targets) ## remove all common object files
common_clean:
	- $(RM) $(common_clean_files)

.PHONY: common_test_clean
common_test_clean: $(common_test_child_clean_targets) ## remove all common_test tests
common_test_clean:
	- $(RM) $(common_test_install_path) $(common_test_objects) $(common_test_depends)

.PHONY: common_re
common_re: common_clean
common_re: common_all

.PHONY: common_test_re
common_test_re: common_test_clean
common_test_re: common_test_all

.PHONY: common_test_run_all
common_test_run_all: $(common_test_child_run_targets) ## build and run common_test
ifneq ($(common_test_objects),)
common_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(common_test_install_path)
endif

.PHONY: common_test_run
common_test_run: common_all
common_test_run: common_test_all
ifneq ($(common_test_objects),)
common_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(common_test_install_path)
endif

-include $(common_depends)
-include $(common_test_depends)
