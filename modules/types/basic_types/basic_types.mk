basic_types_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
basic_types_path_curtestdir			:= $(basic_types_path_curdir)test/
basic_types_child_makefiles			:= $(wildcard $(basic_types_path_curdir)*/*mk)
basic_types_child_module_names		:= $(basename $(notdir $(basic_types_child_makefiles)))
basic_types_child_all_targets		:= $(foreach child_module,$(basic_types_child_module_names),$(child_module)_all)
basic_types_child_clean_targets		:= $(foreach child_module,$(basic_types_child_module_names),$(child_module)_clean)
basic_types_test_child_all_targets	:= $(foreach test_module,$(basic_types_child_module_names),$(test_module)_test_all)
basic_types_test_child_clean_targets	:= $(foreach test_module,$(basic_types_child_module_names),$(test_module)_test_clean)
basic_types_test_child_run_targets	:= $(foreach test_module,$(basic_types_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
basic_types_test_install_path        := $(basic_types_path_curtestdir)basic_types$(EXT_EXE)
endif
basic_types_test_sources             := $(wildcard $(basic_types_path_curtestdir)*.c)
basic_types_sources					:= $(wildcard $(basic_types_path_curdir)*.c)
basic_types_sources					+= $(wildcard $(basic_types_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
basic_types_sources					+= $(wildcard $(basic_types_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
basic_types_sources					+= $(wildcard $(basic_types_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
basic_types_sources					+= $(wildcard $(basic_types_path_curdir)platform_specific/mac/*.c)
endif
basic_types_objects                  := $(patsubst %.c, %.o, $(basic_types_sources))
basic_types_test_objects				:= $(patsubst %.c, %.o, $(basic_types_test_sources))
basic_types_test_depends				:= $(patsubst %.c, %.d, $(basic_types_test_sources))
basic_types_depends					:= $(patsubst %.c, %.d, $(basic_types_sources))
basic_types_depends_modules			:= math  common
basic_types_test_depends_modules     := basic_types test_framework libc common process file time system random compare file_reader hash circular_buffer mod memory math 
basic_types_test_libdepend_objs      = $(foreach dep_module,$(basic_types_test_depends_modules),$($(dep_module)_objects))
basic_types_clean_files				:=
basic_types_clean_files				+= $(basic_types_install_path_implib)
basic_types_clean_files				+= $(basic_types_objects)
basic_types_clean_files				+= $(basic_types_test_objects)
basic_types_clean_files				+= $(basic_types_depends)

include $(basic_types_child_makefiles)

#$(basic_types_path_curtestdir)%.o: $(basic_types_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(basic_types_path_curdir)%.o: $(basic_types_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(basic_types_test_install_path): $(basic_types_test_objects) $(basic_types_test_libdepend_objs)
	$(CC) -o $@ $(basic_types_test_objects) -Wl,--allow-multiple-definition $(basic_types_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: basic_types_all
basic_types_all: $(basic_types_objects) ## build all basic_types object files

.PHONY: basic_types_test_all
basic_types_test_all: $(basic_types_test_install_path) ## build basic_types_test test

.PHONY: basic_types_clean
basic_types_clean: $(basic_types_child_clean_targets) ## remove all basic_types object files
basic_types_clean:
	- $(RM) $(basic_types_clean_files)

.PHONY: basic_types_test_clean
basic_types_test_clean: $(basic_types_test_child_clean_targets) ## remove all basic_types_test tests
basic_types_test_clean:
	- $(RM) $(basic_types_test_install_path) $(basic_types_test_objects) $(basic_types_test_depends)

.PHONY: basic_types_re
basic_types_re: basic_types_clean
basic_types_re: basic_types_all

.PHONY: basic_types_test_re
basic_types_test_re: basic_types_test_clean
basic_types_test_re: basic_types_test_all

.PHONY: basic_types_test_run_all
basic_types_test_run_all: $(basic_types_test_child_run_targets) ## build and run basic_types_test
ifneq ($(basic_types_test_objects),)
basic_types_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(basic_types_test_install_path)
endif

.PHONY: basic_types_test_run
basic_types_test_run: basic_types_all
basic_types_test_run: basic_types_test_all
ifneq ($(basic_types_test_objects),)
basic_types_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(basic_types_test_install_path)
endif

-include $(basic_types_depends)
-include $(basic_types_test_depends)
