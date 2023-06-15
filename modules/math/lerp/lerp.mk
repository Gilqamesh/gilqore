lerp_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
lerp_path_curtestdir			:= $(lerp_path_curdir)test/
lerp_child_makefiles			:= $(wildcard $(lerp_path_curdir)*/*mk)
lerp_child_module_names		:= $(basename $(notdir $(lerp_child_makefiles)))
lerp_child_all_targets		:= $(foreach child_module,$(lerp_child_module_names),$(child_module)_all)
lerp_child_clean_targets		:= $(foreach child_module,$(lerp_child_module_names),$(child_module)_clean)
lerp_test_child_all_targets	:= $(foreach test_module,$(lerp_child_module_names),$(test_module)_test_all)
lerp_test_child_clean_targets	:= $(foreach test_module,$(lerp_child_module_names),$(test_module)_test_clean)
lerp_test_child_run_targets	:= $(foreach test_module,$(lerp_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
lerp_test_install_path        := $(lerp_path_curtestdir)lerp$(EXT_EXE)
endif
lerp_test_sources             := $(wildcard $(lerp_path_curtestdir)*.c)
lerp_sources					:= $(wildcard $(lerp_path_curdir)*.c)
lerp_sources					+= $(wildcard $(lerp_path_curdir)impl/*.c)
ifeq ($(PLATFORM), WINDOWS)
lerp_sources					+= $(wildcard $(lerp_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
lerp_sources					+= $(wildcard $(lerp_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
lerp_sources					+= $(wildcard $(lerp_path_curdir)platform_specific/mac/*.c)
endif
lerp_objects                  := $(patsubst %.c, %.o, $(lerp_sources))
lerp_test_objects				:= $(patsubst %.c, %.o, $(lerp_test_sources))
lerp_test_depends				:= $(patsubst %.c, %.d, $(lerp_test_sources))
lerp_depends					:= $(patsubst %.c, %.d, $(lerp_sources))
lerp_depends_modules			:= color v4  common
lerp_test_depends_modules     := lerp test_framework libc common process file time system random compare file_reader hash circular_buffer mod color v4 
lerp_test_libdepend_objs      = $(foreach dep_module,$(lerp_test_depends_modules),$($(dep_module)_objects))
lerp_clean_files				:=
lerp_clean_files				+= $(lerp_install_path_implib)
lerp_clean_files				+= $(lerp_objects)
lerp_clean_files				+= $(lerp_test_objects)
lerp_clean_files				+= $(lerp_depends)

include $(lerp_child_makefiles)

#$(lerp_path_curtestdir)%.o: $(lerp_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(lerp_path_curdir)%.o: $(lerp_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(lerp_test_install_path): $(lerp_test_objects) $(lerp_test_libdepend_objs)
	$(CC) -o $@ $(lerp_test_objects) -Wl,--allow-multiple-definition $(lerp_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: lerp_all
lerp_all: $(lerp_objects) ## build all lerp object files

.PHONY: lerp_test_all
lerp_test_all: $(lerp_test_install_path) ## build lerp_test test

.PHONY: lerp_clean
lerp_clean: $(lerp_child_clean_targets) ## remove all lerp object files
lerp_clean:
	- $(RM) $(lerp_clean_files)

.PHONY: lerp_test_clean
lerp_test_clean: $(lerp_test_child_clean_targets) ## remove all lerp_test tests
lerp_test_clean:
	- $(RM) $(lerp_test_install_path) $(lerp_test_objects) $(lerp_test_depends)

.PHONY: lerp_re
lerp_re: lerp_clean
lerp_re: lerp_all

.PHONY: lerp_test_re
lerp_test_re: lerp_test_clean
lerp_test_re: lerp_test_all

.PHONY: lerp_test_run_all
lerp_test_run_all: $(lerp_test_child_run_targets) ## build and run lerp_test
ifneq ($(lerp_test_objects),)
lerp_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(lerp_test_install_path)
endif

.PHONY: lerp_test_run
lerp_test_run: lerp_all
lerp_test_run: lerp_test_all
ifneq ($(lerp_test_objects),)
lerp_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(lerp_test_install_path)
endif

-include $(lerp_depends)
-include $(lerp_test_depends)
