v4_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
v4_path_curtestdir			:= $(v4_path_curdir)test/
v4_child_makefiles			:= $(wildcard $(v4_path_curdir)*/*mk)
v4_child_module_names		:= $(basename $(notdir $(v4_child_makefiles)))
v4_child_all_targets		:= $(foreach child_module,$(v4_child_module_names),$(child_module)_all)
v4_child_clean_targets		:= $(foreach child_module,$(v4_child_module_names),$(child_module)_clean)
v4_test_child_all_targets	:= $(foreach test_module,$(v4_child_module_names),$(test_module)_test_all)
v4_test_child_clean_targets	:= $(foreach test_module,$(v4_child_module_names),$(test_module)_test_clean)
v4_test_child_run_targets	:= $(foreach test_module,$(v4_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
v4_test_install_path        := $(v4_path_curtestdir)v4$(EXT_EXE)
endif
v4_test_sources             := $(wildcard $(v4_path_curtestdir)*.c)
v4_sources					:= $(wildcard $(v4_path_curdir)*.c)
v4_sources					+= $(wildcard $(v4_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
v4_sources					+= $(wildcard $(v4_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
v4_sources					+= $(wildcard $(v4_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
v4_sources					+= $(wildcard $(v4_path_curdir)platform_specific/mac/*.c)
endif
v4_objects                  := $(patsubst %.c, %.o, $(v4_sources))
v4_test_objects				:= $(patsubst %.c, %.o, $(v4_test_sources))
v4_test_depends				:= $(patsubst %.c, %.d, $(v4_test_sources))
v4_depends					:= $(patsubst %.c, %.d, $(v4_sources))
v4_depends_modules			:=  common
v4_test_depends_modules     := v4 test_framework libc common compare process file time system random file_reader hash circular_buffer mod memory 
v4_test_libdepend_objs      = $(foreach dep_module,$(v4_test_depends_modules),$($(dep_module)_objects))
v4_clean_files				:=
v4_clean_files				+= $(v4_install_path_implib)
v4_clean_files				+= $(v4_objects)
v4_clean_files				+= $(v4_test_objects)
v4_clean_files				+= $(v4_depends)

include $(v4_child_makefiles)

#$(v4_path_curtestdir)%.o: $(v4_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(v4_path_curdir)%.o: $(v4_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(v4_test_install_path): $(v4_test_objects) $(v4_test_libdepend_objs)
	$(CC) -o $@ $(v4_test_objects) $(v4_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole tcc/lib/libtcc1-64.a tcc/libtcc.dll

.PHONY: v4_all
v4_all: $(v4_objects) ## build all v4 object files

.PHONY: v4_test_all
v4_test_all: $(v4_test_install_path) ## build v4_test test

.PHONY: v4_clean
v4_clean: $(v4_child_clean_targets) ## remove all v4 object files
v4_clean:
	- $(RM) $(v4_clean_files)

.PHONY: v4_test_clean
v4_test_clean: $(v4_test_child_clean_targets) ## remove all v4_test tests
v4_test_clean:
	- $(RM) $(v4_test_install_path) $(v4_test_objects) $(v4_test_depends)

.PHONY: v4_re
v4_re: v4_clean
v4_re: v4_all

.PHONY: v4_test_re
v4_test_re: v4_test_clean
v4_test_re: v4_test_all

.PHONY: v4_test_run_all
v4_test_run_all: $(v4_test_child_run_targets) ## build and run v4_test
ifneq ($(v4_test_objects),)
v4_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(v4_test_install_path)
endif

.PHONY: v4_test_run
v4_test_run: v4_all
v4_test_run: v4_test_all
ifneq ($(v4_test_objects),)
v4_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(v4_test_install_path)
endif

-include $(v4_depends)
-include $(v4_test_depends)
