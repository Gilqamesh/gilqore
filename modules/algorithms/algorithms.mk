algorithms_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
algorithms_path_curtestdir			:= $(algorithms_path_curdir)test/
algorithms_child_makefiles			:= $(wildcard $(algorithms_path_curdir)*/*mk)
algorithms_child_module_names		:= $(basename $(notdir $(algorithms_child_makefiles)))
algorithms_child_all_targets		:= $(foreach child_module,$(algorithms_child_module_names),$(child_module)_all)
algorithms_child_clean_targets		:= $(foreach child_module,$(algorithms_child_module_names),$(child_module)_clean)
algorithms_test_child_all_targets	:= $(foreach test_module,$(algorithms_child_module_names),$(test_module)_test_all)
algorithms_test_child_clean_targets	:= $(foreach test_module,$(algorithms_child_module_names),$(test_module)_test_clean)
algorithms_test_child_run_targets	:= $(foreach test_module,$(algorithms_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
algorithms_test_install_path        := $(algorithms_path_curtestdir)algorithms$(EXT_EXE)
endif
algorithms_test_sources             := $(wildcard $(algorithms_path_curtestdir)*.c)
algorithms_sources					:= $(wildcard $(algorithms_path_curdir)*.c)
algorithms_sources					+= $(wildcard $(algorithms_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
algorithms_sources					+= $(wildcard $(algorithms_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
algorithms_sources					+= $(wildcard $(algorithms_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
algorithms_sources					+= $(wildcard $(algorithms_path_curdir)platform_specific/mac/*.c)
endif
algorithms_objects                  := $(patsubst %.c, %.o, $(algorithms_sources))
algorithms_test_objects				:= $(patsubst %.c, %.o, $(algorithms_test_sources))
algorithms_test_depends				:= $(patsubst %.c, %.d, $(algorithms_test_sources))
algorithms_depends					:= $(patsubst %.c, %.d, $(algorithms_sources))
algorithms_depends_modules			:=  common
algorithms_test_depends_modules     := algorithms test_framework libc common process file time system random compare file_reader hash circular_buffer mod 
algorithms_test_libdepend_objs      = $(foreach dep_module,$(algorithms_test_depends_modules),$($(dep_module)_objects))
algorithms_clean_files				:=
algorithms_clean_files				+= $(algorithms_install_path_implib)
algorithms_clean_files				+= $(algorithms_objects)
algorithms_clean_files				+= $(algorithms_test_objects)
algorithms_clean_files				+= $(algorithms_depends)

include $(algorithms_child_makefiles)

#$(algorithms_path_curtestdir)%.o: $(algorithms_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(algorithms_path_curdir)%.o: $(algorithms_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(algorithms_test_install_path): $(algorithms_test_objects) $(algorithms_test_libdepend_objs)
	$(CC) -o $@ $(algorithms_test_objects) -Wl,--allow-multiple-definition $(algorithms_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: algorithms_all
algorithms_all: $(algorithms_objects) ## build all algorithms object files

.PHONY: algorithms_test_all
algorithms_test_all: $(algorithms_test_install_path) ## build algorithms_test test

.PHONY: algorithms_clean
algorithms_clean: $(algorithms_child_clean_targets) ## remove all algorithms object files
algorithms_clean:
	- $(RM) $(algorithms_clean_files)

.PHONY: algorithms_test_clean
algorithms_test_clean: $(algorithms_test_child_clean_targets) ## remove all algorithms_test tests
algorithms_test_clean:
	- $(RM) $(algorithms_test_install_path) $(algorithms_test_objects) $(algorithms_test_depends)

.PHONY: algorithms_re
algorithms_re: algorithms_clean
algorithms_re: algorithms_all

.PHONY: algorithms_test_re
algorithms_test_re: algorithms_test_clean
algorithms_test_re: algorithms_test_all

.PHONY: algorithms_test_run_all
algorithms_test_run_all: $(algorithms_test_child_run_targets) ## build and run algorithms_test
ifneq ($(algorithms_test_objects),)
algorithms_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(algorithms_test_install_path)
endif

.PHONY: algorithms_test_run
algorithms_test_run: algorithms_all
algorithms_test_run: algorithms_test_all
ifneq ($(algorithms_test_objects),)
algorithms_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(algorithms_test_install_path)
endif

-include $(algorithms_depends)
-include $(algorithms_test_depends)
