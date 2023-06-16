v3_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
v3_path_curtestdir			:= $(v3_path_curdir)test/
v3_child_makefiles			:= $(wildcard $(v3_path_curdir)*/*mk)
v3_child_module_names		:= $(basename $(notdir $(v3_child_makefiles)))
v3_child_all_targets		:= $(foreach child_module,$(v3_child_module_names),$(child_module)_all)
v3_child_clean_targets		:= $(foreach child_module,$(v3_child_module_names),$(child_module)_clean)
v3_test_child_all_targets	:= $(foreach test_module,$(v3_child_module_names),$(test_module)_test_all)
v3_test_child_clean_targets	:= $(foreach test_module,$(v3_child_module_names),$(test_module)_test_clean)
v3_test_child_run_targets	:= $(foreach test_module,$(v3_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
v3_test_install_path        := $(v3_path_curtestdir)v3$(EXT_EXE)
endif
v3_test_sources             := $(wildcard $(v3_path_curtestdir)*.c)
v3_sources					:= $(wildcard $(v3_path_curdir)*.c)
v3_sources					+= $(wildcard $(v3_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
v3_sources					+= $(wildcard $(v3_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
v3_sources					+= $(wildcard $(v3_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
v3_sources					+= $(wildcard $(v3_path_curdir)platform_specific/mac/*.c)
endif
v3_objects                  := $(patsubst %.c, %.o, $(v3_sources))
v3_test_objects				:= $(patsubst %.c, %.o, $(v3_test_sources))
v3_test_depends				:= $(patsubst %.c, %.d, $(v3_test_sources))
v3_depends					:= $(patsubst %.c, %.d, $(v3_sources))
v3_depends_modules			:=  common
v3_test_depends_modules     := v3 test_framework libc common process file time system random compare file_reader hash circular_buffer mod 
v3_test_libdepend_objs      = $(foreach dep_module,$(v3_test_depends_modules),$($(dep_module)_objects))
v3_clean_files				:=
v3_clean_files				+= $(v3_install_path_implib)
v3_clean_files				+= $(v3_objects)
v3_clean_files				+= $(v3_test_objects)
v3_clean_files				+= $(v3_depends)

include $(v3_child_makefiles)

#$(v3_path_curtestdir)%.o: $(v3_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(v3_path_curdir)%.o: $(v3_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(v3_test_install_path): $(v3_test_objects) $(v3_test_libdepend_objs)
	$(CC) -o $@ $(v3_test_objects) -Wl,--allow-multiple-definition $(v3_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: v3_all
v3_all: $(v3_objects) ## build all v3 object files

.PHONY: v3_test_all
v3_test_all: $(v3_test_install_path) ## build v3_test test

.PHONY: v3_clean
v3_clean: $(v3_child_clean_targets) ## remove all v3 object files
v3_clean:
	- $(RM) $(v3_clean_files)

.PHONY: v3_test_clean
v3_test_clean: $(v3_test_child_clean_targets) ## remove all v3_test tests
v3_test_clean:
	- $(RM) $(v3_test_install_path) $(v3_test_objects) $(v3_test_depends)

.PHONY: v3_re
v3_re: v3_clean
v3_re: v3_all

.PHONY: v3_test_re
v3_test_re: v3_test_clean
v3_test_re: v3_test_all

.PHONY: v3_test_run_all
v3_test_run_all: $(v3_test_child_run_targets) ## build and run v3_test
ifneq ($(v3_test_objects),)
v3_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(v3_test_install_path)
endif

.PHONY: v3_test_run
v3_test_run: v3_all
v3_test_run: v3_test_all
ifneq ($(v3_test_objects),)
v3_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(v3_test_install_path)
endif

-include $(v3_depends)
-include $(v3_test_depends)
