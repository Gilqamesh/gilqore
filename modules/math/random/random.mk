random_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
random_path_curtestdir			:= $(random_path_curdir)test/
random_child_makefiles			:= $(wildcard $(random_path_curdir)*/*mk)
random_child_module_names		:= $(basename $(notdir $(random_child_makefiles)))
random_child_all_targets		:= $(foreach child_module,$(random_child_module_names),$(child_module)_all)
random_child_clean_targets		:= $(foreach child_module,$(random_child_module_names),$(child_module)_clean)
random_test_child_all_targets	:= $(foreach test_module,$(random_child_module_names),$(test_module)_test_all)
random_test_child_clean_targets	:= $(foreach test_module,$(random_child_module_names),$(test_module)_test_clean)
random_test_child_run_targets	:= $(foreach test_module,$(random_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
random_test_install_path        := $(random_path_curtestdir)random$(EXT_EXE)
endif
random_test_sources             := $(wildcard $(random_path_curtestdir)*.c)
random_sources					:= $(wildcard $(random_path_curdir)*.c)
random_sources					+= $(wildcard $(random_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
random_sources					+= $(wildcard $(random_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
random_sources					+= $(wildcard $(random_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
random_sources					+= $(wildcard $(random_path_curdir)platform_specific/mac/*.c)
endif
random_objects                  := $(patsubst %.c, %.o, $(random_sources))
random_test_objects				:= $(patsubst %.c, %.o, $(random_test_sources))
random_test_depends				:= $(patsubst %.c, %.d, $(random_test_sources))
random_depends					:= $(patsubst %.c, %.d, $(random_sources))
random_depends_modules			:=  common
random_test_depends_modules     := random test_framework libc common process file time system compare file_reader hash circular_buffer mod memory 
random_test_libdepend_objs      = $(foreach dep_module,$(random_test_depends_modules),$($(dep_module)_objects))
random_clean_files				:=
random_clean_files				+= $(random_install_path_implib)
random_clean_files				+= $(random_objects)
random_clean_files				+= $(random_test_objects)
random_clean_files				+= $(random_depends)

include $(random_child_makefiles)

#$(random_path_curtestdir)%.o: $(random_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(random_path_curdir)%.o: $(random_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(random_test_install_path): $(random_test_objects) $(random_test_libdepend_objs)
	$(CC) -o $@ $(random_test_objects) -Wl,--allow-multiple-definition $(random_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: random_all
random_all: $(random_objects) ## build all random object files

.PHONY: random_test_all
random_test_all: $(random_test_install_path) ## build random_test test

.PHONY: random_clean
random_clean: $(random_child_clean_targets) ## remove all random object files
random_clean:
	- $(RM) $(random_clean_files)

.PHONY: random_test_clean
random_test_clean: $(random_test_child_clean_targets) ## remove all random_test tests
random_test_clean:
	- $(RM) $(random_test_install_path) $(random_test_objects) $(random_test_depends)

.PHONY: random_re
random_re: random_clean
random_re: random_all

.PHONY: random_test_re
random_test_re: random_test_clean
random_test_re: random_test_all

.PHONY: random_test_run_all
random_test_run_all: $(random_test_child_run_targets) ## build and run random_test
ifneq ($(random_test_objects),)
random_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(random_test_install_path)
endif

.PHONY: random_test_run
random_test_run: random_all
random_test_run: random_test_all
ifneq ($(random_test_objects),)
random_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(random_test_install_path)
endif

-include $(random_depends)
-include $(random_test_depends)
