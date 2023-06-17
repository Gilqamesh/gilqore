stack_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
stack_path_curtestdir			:= $(stack_path_curdir)test/
stack_child_makefiles			:= $(wildcard $(stack_path_curdir)*/*mk)
stack_child_module_names		:= $(basename $(notdir $(stack_child_makefiles)))
stack_child_all_targets		:= $(foreach child_module,$(stack_child_module_names),$(child_module)_all)
stack_child_clean_targets		:= $(foreach child_module,$(stack_child_module_names),$(child_module)_clean)
stack_test_child_all_targets	:= $(foreach test_module,$(stack_child_module_names),$(test_module)_test_all)
stack_test_child_clean_targets	:= $(foreach test_module,$(stack_child_module_names),$(test_module)_test_clean)
stack_test_child_run_targets	:= $(foreach test_module,$(stack_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
stack_test_install_path        := $(stack_path_curtestdir)stack$(EXT_EXE)
endif
stack_test_sources             := $(wildcard $(stack_path_curtestdir)*.c)
stack_sources					:= $(wildcard $(stack_path_curdir)*.c)
stack_sources					+= $(wildcard $(stack_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
stack_sources					+= $(wildcard $(stack_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
stack_sources					+= $(wildcard $(stack_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
stack_sources					+= $(wildcard $(stack_path_curdir)platform_specific/mac/*.c)
endif
stack_objects                  := $(patsubst %.c, %.o, $(stack_sources))
stack_test_objects				:= $(patsubst %.c, %.o, $(stack_test_sources))
stack_test_depends				:= $(patsubst %.c, %.d, $(stack_test_sources))
stack_depends					:= $(patsubst %.c, %.d, $(stack_sources))
stack_depends_modules			:= libc common memory  common
stack_test_depends_modules     := stack test_framework libc common process file time system random compare file_reader hash circular_buffer mod memory 
stack_test_libdepend_objs      = $(foreach dep_module,$(stack_test_depends_modules),$($(dep_module)_objects))
stack_clean_files				:=
stack_clean_files				+= $(stack_install_path_implib)
stack_clean_files				+= $(stack_objects)
stack_clean_files				+= $(stack_test_objects)
stack_clean_files				+= $(stack_depends)

include $(stack_child_makefiles)

#$(stack_path_curtestdir)%.o: $(stack_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(stack_path_curdir)%.o: $(stack_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(stack_test_install_path): $(stack_test_objects) $(stack_test_libdepend_objs)
	$(CC) -o $@ $(stack_test_objects) -Wl,--allow-multiple-definition $(stack_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: stack_all
stack_all: $(stack_objects) ## build all stack object files

.PHONY: stack_test_all
stack_test_all: $(stack_test_install_path) ## build stack_test test

.PHONY: stack_clean
stack_clean: $(stack_child_clean_targets) ## remove all stack object files
stack_clean:
	- $(RM) $(stack_clean_files)

.PHONY: stack_test_clean
stack_test_clean: $(stack_test_child_clean_targets) ## remove all stack_test tests
stack_test_clean:
	- $(RM) $(stack_test_install_path) $(stack_test_objects) $(stack_test_depends)

.PHONY: stack_re
stack_re: stack_clean
stack_re: stack_all

.PHONY: stack_test_re
stack_test_re: stack_test_clean
stack_test_re: stack_test_all

.PHONY: stack_test_run_all
stack_test_run_all: $(stack_test_child_run_targets) ## build and run stack_test
ifneq ($(stack_test_objects),)
stack_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(stack_test_install_path)
endif

.PHONY: stack_test_run
stack_test_run: stack_all
stack_test_run: stack_test_all
ifneq ($(stack_test_objects),)
stack_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(stack_test_install_path)
endif

-include $(stack_depends)
-include $(stack_test_depends)
