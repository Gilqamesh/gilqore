time_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
time_path_curtestdir			:= $(time_path_curdir)test/
time_child_makefiles			:= $(wildcard $(time_path_curdir)*/*mk)
time_child_module_names		:= $(basename $(notdir $(time_child_makefiles)))
time_child_all_targets		:= $(foreach child_module,$(time_child_module_names),$(child_module)_all)
time_child_clean_targets		:= $(foreach child_module,$(time_child_module_names),$(child_module)_clean)
time_test_child_all_targets	:= $(foreach test_module,$(time_child_module_names),$(test_module)_test_all)
time_test_child_clean_targets	:= $(foreach test_module,$(time_child_module_names),$(test_module)_test_clean)
time_test_child_run_targets	:= $(foreach test_module,$(time_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
time_test_install_path        := $(time_path_curtestdir)time$(EXT_EXE)
endif
time_test_sources             := $(wildcard $(time_path_curtestdir)*.c)
time_sources					:= $(wildcard $(time_path_curdir)*.c)
time_sources					+= $(wildcard $(time_path_curdir)impl/*.c)
ifeq ($(PLATFORM), WINDOWS)
time_sources					+= $(wildcard $(time_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
time_sources					+= $(wildcard $(time_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
time_sources					+= $(wildcard $(time_path_curdir)platform_specific/mac/*.c)
endif
time_objects                  := $(patsubst %.c, %.o, $(time_sources))
time_test_objects				:= $(patsubst %.c, %.o, $(time_test_sources))
time_test_depends				:= $(patsubst %.c, %.d, $(time_test_sources))
time_depends					:= $(patsubst %.c, %.d, $(time_sources))
time_depends_modules			:= common system  common
time_test_depends_modules     := time test_framework libc common process file random compare file_reader hash circular_buffer mod system 
time_test_libdepend_objs      = $(foreach dep_module,$(time_test_depends_modules),$($(dep_module)_objects))
time_clean_files				:=
time_clean_files				+= $(time_install_path_implib)
time_clean_files				+= $(time_objects)
time_clean_files				+= $(time_test_objects)
time_clean_files				+= $(time_depends)

include $(time_child_makefiles)

#$(time_path_curtestdir)%.o: $(time_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(time_path_curdir)%.o: $(time_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(time_test_install_path): $(time_test_objects) $(time_test_libdepend_objs)
	$(CC) -o $@ $(time_test_objects) -Wl,--allow-multiple-definition $(time_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: time_all
time_all: $(time_objects) ## build all time object files

.PHONY: time_test_all
time_test_all: $(time_test_install_path) ## build time_test test

.PHONY: time_clean
time_clean: $(time_child_clean_targets) ## remove all time object files
time_clean:
	- $(RM) $(time_clean_files)

.PHONY: time_test_clean
time_test_clean: $(time_test_child_clean_targets) ## remove all time_test tests
time_test_clean:
	- $(RM) $(time_test_install_path) $(time_test_objects) $(time_test_depends)

.PHONY: time_re
time_re: time_clean
time_re: time_all

.PHONY: time_test_re
time_test_re: time_test_clean
time_test_re: time_test_all

.PHONY: time_test_run_all
time_test_run_all: $(time_test_child_run_targets) ## build and run time_test
ifneq ($(time_test_objects),)
time_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(time_test_install_path)
endif

.PHONY: time_test_run
time_test_run: time_all
time_test_run: time_test_all
ifneq ($(time_test_objects),)
time_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(time_test_install_path)
endif

-include $(time_depends)
-include $(time_test_depends)
