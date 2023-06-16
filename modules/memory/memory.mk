memory_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
memory_path_curtestdir			:= $(memory_path_curdir)test/
memory_child_makefiles			:= $(wildcard $(memory_path_curdir)*/*mk)
memory_child_module_names		:= $(basename $(notdir $(memory_child_makefiles)))
memory_child_all_targets		:= $(foreach child_module,$(memory_child_module_names),$(child_module)_all)
memory_child_clean_targets		:= $(foreach child_module,$(memory_child_module_names),$(child_module)_clean)
memory_test_child_all_targets	:= $(foreach test_module,$(memory_child_module_names),$(test_module)_test_all)
memory_test_child_clean_targets	:= $(foreach test_module,$(memory_child_module_names),$(test_module)_test_clean)
memory_test_child_run_targets	:= $(foreach test_module,$(memory_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
memory_test_install_path        := $(memory_path_curtestdir)memory$(EXT_EXE)
endif
memory_test_sources             := $(wildcard $(memory_path_curtestdir)*.c)
memory_sources					:= $(wildcard $(memory_path_curdir)*.c)
memory_sources					+= $(wildcard $(memory_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
memory_sources					+= $(wildcard $(memory_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
memory_sources					+= $(wildcard $(memory_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
memory_sources					+= $(wildcard $(memory_path_curdir)platform_specific/mac/*.c)
endif
memory_objects                  := $(patsubst %.c, %.o, $(memory_sources))
memory_test_objects				:= $(patsubst %.c, %.o, $(memory_test_sources))
memory_test_depends				:= $(patsubst %.c, %.d, $(memory_test_sources))
memory_depends					:= $(patsubst %.c, %.d, $(memory_sources))
memory_depends_modules			:=  common
memory_test_depends_modules     := memory test_framework libc common process file time system random compare file_reader hash circular_buffer mod 
memory_test_libdepend_objs      = $(foreach dep_module,$(memory_test_depends_modules),$($(dep_module)_objects))
memory_clean_files				:=
memory_clean_files				+= $(memory_install_path_implib)
memory_clean_files				+= $(memory_objects)
memory_clean_files				+= $(memory_test_objects)
memory_clean_files				+= $(memory_depends)

include $(memory_child_makefiles)

#$(memory_path_curtestdir)%.o: $(memory_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(memory_path_curdir)%.o: $(memory_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(memory_test_install_path): $(memory_test_objects) $(memory_test_libdepend_objs)
	$(CC) -o $@ $(memory_test_objects) -Wl,--allow-multiple-definition $(memory_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: memory_all
memory_all: $(memory_objects) ## build all memory object files

.PHONY: memory_test_all
memory_test_all: $(memory_test_install_path) ## build memory_test test

.PHONY: memory_clean
memory_clean: $(memory_child_clean_targets) ## remove all memory object files
memory_clean:
	- $(RM) $(memory_clean_files)

.PHONY: memory_test_clean
memory_test_clean: $(memory_test_child_clean_targets) ## remove all memory_test tests
memory_test_clean:
	- $(RM) $(memory_test_install_path) $(memory_test_objects) $(memory_test_depends)

.PHONY: memory_re
memory_re: memory_clean
memory_re: memory_all

.PHONY: memory_test_re
memory_test_re: memory_test_clean
memory_test_re: memory_test_all

.PHONY: memory_test_run_all
memory_test_run_all: $(memory_test_child_run_targets) ## build and run memory_test
ifneq ($(memory_test_objects),)
memory_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(memory_test_install_path)
endif

.PHONY: memory_test_run
memory_test_run: memory_all
memory_test_run: memory_test_all
ifneq ($(memory_test_objects),)
memory_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(memory_test_install_path)
endif

-include $(memory_depends)
-include $(memory_test_depends)
