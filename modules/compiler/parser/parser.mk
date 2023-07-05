parser_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
parser_path_curtestdir			:= $(parser_path_curdir)test/
parser_child_makefiles			:= $(wildcard $(parser_path_curdir)*/*mk)
parser_child_module_names		:= $(basename $(notdir $(parser_child_makefiles)))
parser_child_all_targets		:= $(foreach child_module,$(parser_child_module_names),$(child_module)_all)
parser_child_clean_targets		:= $(foreach child_module,$(parser_child_module_names),$(child_module)_clean)
parser_test_child_all_targets	:= $(foreach test_module,$(parser_child_module_names),$(test_module)_test_all)
parser_test_child_clean_targets	:= $(foreach test_module,$(parser_child_module_names),$(test_module)_test_clean)
parser_test_child_run_targets	:= $(foreach test_module,$(parser_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
parser_test_install_path        := $(parser_path_curtestdir)parser$(EXT_EXE)
endif
parser_test_sources             := $(wildcard $(parser_path_curtestdir)*.c)
parser_sources					:= $(wildcard $(parser_path_curdir)*.c)
parser_sources					+= $(wildcard $(parser_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
parser_sources					+= $(wildcard $(parser_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
parser_sources					+= $(wildcard $(parser_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
parser_sources					+= $(wildcard $(parser_path_curdir)platform_specific/mac/*.c)
endif
parser_objects                  := $(patsubst %.c, %.o, $(parser_sources))
parser_test_objects				:= $(patsubst %.c, %.o, $(parser_test_sources))
parser_test_depends				:= $(patsubst %.c, %.d, $(parser_test_sources))
parser_depends					:= $(patsubst %.c, %.d, $(parser_sources))
parser_depends_modules			:= memory libc common compare  common
parser_test_depends_modules     := parser memory libc common compare test_framework process file time system random file_reader hash circular_buffer mod 
parser_test_libdepend_objs      = $(foreach dep_module,$(parser_test_depends_modules),$($(dep_module)_objects))
parser_clean_files				:=
parser_clean_files				+= $(parser_install_path_implib)
parser_clean_files				+= $(parser_objects)
parser_clean_files				+= $(parser_test_objects)
parser_clean_files				+= $(parser_depends)

include $(parser_child_makefiles)

#$(parser_path_curtestdir)%.o: $(parser_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(parser_path_curdir)%.o: $(parser_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(parser_test_install_path): $(parser_test_objects) $(parser_test_libdepend_objs)
	$(CC) -o $@ $(parser_test_objects) $(parser_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: parser_all
parser_all: $(parser_objects) ## build all parser object files

.PHONY: parser_test_all
parser_test_all: $(parser_test_install_path) ## build parser_test test

.PHONY: parser_clean
parser_clean: $(parser_child_clean_targets) ## remove all parser object files
parser_clean:
	- $(RM) $(parser_clean_files)

.PHONY: parser_test_clean
parser_test_clean: $(parser_test_child_clean_targets) ## remove all parser_test tests
parser_test_clean:
	- $(RM) $(parser_test_install_path) $(parser_test_objects) $(parser_test_depends)

.PHONY: parser_re
parser_re: parser_clean
parser_re: parser_all

.PHONY: parser_test_re
parser_test_re: parser_test_clean
parser_test_re: parser_test_all

.PHONY: parser_test_run_all
parser_test_run_all: $(parser_test_child_run_targets) ## build and run parser_test
ifneq ($(parser_test_objects),)
parser_test_run_all: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(parser_test_install_path)
endif

.PHONY: parser_test_run
parser_test_run: parser_all
parser_test_run: parser_test_all
ifneq ($(parser_test_objects),)
parser_test_run: $(TEST_FRAMEWORK_EXE)
	@$(TEST_FRAMEWORK_EXE) $(parser_test_install_path)
endif

-include $(parser_depends)
-include $(parser_test_depends)
