lox_parser_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
lox_parser_path_curtestdir			:= $(lox_parser_path_curdir)test/
lox_parser_child_makefiles			:= $(wildcard $(lox_parser_path_curdir)*/*mk)
lox_parser_child_module_names		:= $(basename $(notdir $(lox_parser_child_makefiles)))
lox_parser_child_all_targets		:= $(foreach child_module,$(lox_parser_child_module_names),$(child_module)_all)
lox_parser_child_clean_targets		:= $(foreach child_module,$(lox_parser_child_module_names),$(child_module)_clean)
lox_parser_test_child_all_targets	:= $(foreach test_module,$(lox_parser_child_module_names),$(test_module)_test_all)
lox_parser_test_child_clean_targets	:= $(foreach test_module,$(lox_parser_child_module_names),$(test_module)_test_clean)
lox_parser_test_child_run_targets	:= $(foreach test_module,$(lox_parser_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
lox_parser_test_install_path        := $(lox_parser_path_curtestdir)lox_parser$(EXT_EXE)
endif
lox_parser_test_sources             := $(wildcard $(lox_parser_path_curtestdir)*.c)
lox_parser_sources					:= $(wildcard $(lox_parser_path_curdir)*.c)
lox_parser_sources					+= $(wildcard $(lox_parser_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
lox_parser_sources					+= $(wildcard $(lox_parser_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
lox_parser_sources					+= $(wildcard $(lox_parser_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
lox_parser_sources					+= $(wildcard $(lox_parser_path_curdir)platform_specific/mac/*.c)
endif
lox_parser_objects                  := $(patsubst %.c, %.o, $(lox_parser_sources))
lox_parser_test_objects				:= $(patsubst %.c, %.o, $(lox_parser_test_sources))
lox_parser_test_depends				:= $(patsubst %.c, %.d, $(lox_parser_test_sources))
lox_parser_depends					:= $(patsubst %.c, %.d, $(lox_parser_sources))
lox_parser_depends_modules			:= libc common compare parser memory  common
lox_parser_test_depends_modules     := lox_parser libc common compare parser memory test_framework process file time system random file_reader hash circular_buffer mod 
lox_parser_test_libdepend_objs      = $(foreach dep_module,$(lox_parser_test_depends_modules),$($(dep_module)_objects))
lox_parser_clean_files				:=
lox_parser_clean_files				+= $(lox_parser_install_path_implib)
lox_parser_clean_files				+= $(lox_parser_objects)
lox_parser_clean_files				+= $(lox_parser_test_objects)
lox_parser_clean_files				+= $(lox_parser_depends)

include $(lox_parser_child_makefiles)

#$(lox_parser_path_curtestdir)%.o: $(lox_parser_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(lox_parser_path_curdir)%.o: $(lox_parser_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(lox_parser_test_install_path): $(lox_parser_test_objects) $(lox_parser_test_libdepend_objs)
	$(CC) -o $@ $(lox_parser_test_objects) $(lox_parser_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: lox_parser_all
lox_parser_all: $(lox_parser_objects) ## build all lox_parser object files

.PHONY: lox_parser_test_all
lox_parser_test_all: $(lox_parser_test_install_path) ## build lox_parser_test test

.PHONY: lox_parser_clean
lox_parser_clean: $(lox_parser_child_clean_targets) ## remove all lox_parser object files
lox_parser_clean:
	- $(RM) $(lox_parser_clean_files)

.PHONY: lox_parser_test_clean
lox_parser_test_clean: $(lox_parser_test_child_clean_targets) ## remove all lox_parser_test tests
lox_parser_test_clean:
	- $(RM) $(lox_parser_test_install_path) $(lox_parser_test_objects) $(lox_parser_test_depends)

.PHONY: lox_parser_re
lox_parser_re: lox_parser_clean
lox_parser_re: lox_parser_all

.PHONY: lox_parser_test_re
lox_parser_test_re: lox_parser_test_clean
lox_parser_test_re: lox_parser_test_all

.PHONY: lox_parser_test_run_all
lox_parser_test_run_all: $(lox_parser_test_child_run_targets) ## build and run lox_parser_test
ifneq ($(lox_parser_test_objects),)
lox_parser_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(lox_parser_test_install_path)
endif

.PHONY: lox_parser_test_run
lox_parser_test_run: lox_parser_all
lox_parser_test_run: lox_parser_test_all
ifneq ($(lox_parser_test_objects),)
lox_parser_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(lox_parser_test_install_path)
endif

-include $(lox_parser_depends)
-include $(lox_parser_test_depends)
