compare_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
compare_path_curtestdir			:= $(compare_path_curdir)test/
compare_child_makefiles			:= $(wildcard $(compare_path_curdir)*/*mk)
compare_child_module_names		:= $(basename $(notdir $(compare_child_makefiles)))
compare_child_all_targets		:= $(foreach child_module,$(compare_child_module_names),$(child_module)_all)
compare_child_clean_targets		:= $(foreach child_module,$(compare_child_module_names),$(child_module)_clean)
compare_test_child_all_targets	:= $(foreach test_module,$(compare_child_module_names),$(test_module)_test_all)
compare_test_child_clean_targets	:= $(foreach test_module,$(compare_child_module_names),$(test_module)_test_clean)
compare_test_child_run_targets	:= $(foreach test_module,$(compare_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
compare_test_install_path        := $(compare_path_curtestdir)compare$(EXT_EXE)
endif
compare_test_sources             := $(wildcard $(compare_path_curtestdir)*.c)
compare_sources					:= $(wildcard $(compare_path_curdir)*.c)
compare_sources					+= $(wildcard $(compare_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
compare_sources					+= $(wildcard $(compare_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
compare_sources					+= $(wildcard $(compare_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
compare_sources					+= $(wildcard $(compare_path_curdir)platform_specific/mac/*.c)
endif
compare_objects                  := $(patsubst %.c, %.o, $(compare_sources))
compare_test_objects				:= $(patsubst %.c, %.o, $(compare_test_sources))
compare_test_depends				:= $(patsubst %.c, %.d, $(compare_test_sources))
compare_depends					:= $(patsubst %.c, %.d, $(compare_sources))
compare_depends_modules			:=  common
compare_test_depends_modules     := compare test_framework libc common process file time system random file_reader hash circular_buffer mod 
compare_test_libdepend_objs      = $(foreach dep_module,$(compare_test_depends_modules),$($(dep_module)_objects))
compare_clean_files				:=
compare_clean_files				+= $(compare_install_path_implib)
compare_clean_files				+= $(compare_objects)
compare_clean_files				+= $(compare_test_objects)
compare_clean_files				+= $(compare_depends)

include $(compare_child_makefiles)

#$(compare_path_curtestdir)%.o: $(compare_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(compare_path_curdir)%.o: $(compare_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(compare_test_install_path): $(compare_test_objects) $(compare_test_libdepend_objs)
	$(CC) -o $@ $(compare_test_objects) -Wl,--allow-multiple-definition $(compare_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: compare_all
compare_all: $(compare_objects) ## build all compare object files

.PHONY: compare_test_all
compare_test_all: $(compare_test_install_path) ## build compare_test test

.PHONY: compare_clean
compare_clean: $(compare_child_clean_targets) ## remove all compare object files
compare_clean:
	- $(RM) $(compare_clean_files)

.PHONY: compare_test_clean
compare_test_clean: $(compare_test_child_clean_targets) ## remove all compare_test tests
compare_test_clean:
	- $(RM) $(compare_test_install_path) $(compare_test_objects) $(compare_test_depends)

.PHONY: compare_re
compare_re: compare_clean
compare_re: compare_all

.PHONY: compare_test_re
compare_test_re: compare_test_clean
compare_test_re: compare_test_all

.PHONY: compare_test_run_all
compare_test_run_all: $(compare_test_child_run_targets) ## build and run compare_test
ifneq ($(compare_test_objects),)
compare_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(compare_test_install_path)
endif

.PHONY: compare_test_run
compare_test_run: compare_all
compare_test_run: compare_test_all
ifneq ($(compare_test_objects),)
compare_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(compare_test_install_path)
endif

-include $(compare_depends)
-include $(compare_test_depends)
