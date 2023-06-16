string_replacer_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
string_replacer_path_curtestdir			:= $(string_replacer_path_curdir)test/
string_replacer_child_makefiles			:= $(wildcard $(string_replacer_path_curdir)*/*mk)
string_replacer_child_module_names		:= $(basename $(notdir $(string_replacer_child_makefiles)))
string_replacer_child_all_targets		:= $(foreach child_module,$(string_replacer_child_module_names),$(child_module)_all)
string_replacer_child_clean_targets		:= $(foreach child_module,$(string_replacer_child_module_names),$(child_module)_clean)
string_replacer_test_child_all_targets	:= $(foreach test_module,$(string_replacer_child_module_names),$(test_module)_test_all)
string_replacer_test_child_clean_targets	:= $(foreach test_module,$(string_replacer_child_module_names),$(test_module)_test_clean)
string_replacer_test_child_run_targets	:= $(foreach test_module,$(string_replacer_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
string_replacer_test_install_path        := $(string_replacer_path_curtestdir)string_replacer$(EXT_EXE)
endif
string_replacer_test_sources             := $(wildcard $(string_replacer_path_curtestdir)*.c)
string_replacer_sources					:= $(wildcard $(string_replacer_path_curdir)*.c)
string_replacer_sources					+= $(wildcard $(string_replacer_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
string_replacer_sources					+= $(wildcard $(string_replacer_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
string_replacer_sources					+= $(wildcard $(string_replacer_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
string_replacer_sources					+= $(wildcard $(string_replacer_path_curdir)platform_specific/mac/*.c)
endif
string_replacer_objects                  := $(patsubst %.c, %.o, $(string_replacer_sources))
string_replacer_test_objects				:= $(patsubst %.c, %.o, $(string_replacer_test_sources))
string_replacer_test_depends				:= $(patsubst %.c, %.d, $(string_replacer_test_sources))
string_replacer_depends					:= $(patsubst %.c, %.d, $(string_replacer_sources))
string_replacer_depends_modules			:= libc common compare file time system random hash v2 sqrt abs clamp v3 v4 math  common
string_replacer_test_depends_modules     := string_replacer test_framework libc common process file time system random compare file_reader hash circular_buffer mod v2 sqrt abs clamp v3 v4 math 
string_replacer_test_libdepend_objs      = $(foreach dep_module,$(string_replacer_test_depends_modules),$($(dep_module)_objects))
string_replacer_clean_files				:=
string_replacer_clean_files				+= $(string_replacer_install_path_implib)
string_replacer_clean_files				+= $(string_replacer_objects)
string_replacer_clean_files				+= $(string_replacer_test_objects)
string_replacer_clean_files				+= $(string_replacer_depends)

include $(string_replacer_child_makefiles)

#$(string_replacer_path_curtestdir)%.o: $(string_replacer_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(string_replacer_path_curdir)%.o: $(string_replacer_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(string_replacer_test_install_path): $(string_replacer_test_objects) $(string_replacer_test_libdepend_objs)
	$(CC) -o $@ $(string_replacer_test_objects) -Wl,--allow-multiple-definition $(string_replacer_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: string_replacer_all
string_replacer_all: $(string_replacer_objects) ## build all string_replacer object files

.PHONY: string_replacer_test_all
string_replacer_test_all: $(string_replacer_test_install_path) ## build string_replacer_test test

.PHONY: string_replacer_clean
string_replacer_clean: $(string_replacer_child_clean_targets) ## remove all string_replacer object files
string_replacer_clean:
	- $(RM) $(string_replacer_clean_files)

.PHONY: string_replacer_test_clean
string_replacer_test_clean: $(string_replacer_test_child_clean_targets) ## remove all string_replacer_test tests
string_replacer_test_clean:
	- $(RM) $(string_replacer_test_install_path) $(string_replacer_test_objects) $(string_replacer_test_depends)

.PHONY: string_replacer_re
string_replacer_re: string_replacer_clean
string_replacer_re: string_replacer_all

.PHONY: string_replacer_test_re
string_replacer_test_re: string_replacer_test_clean
string_replacer_test_re: string_replacer_test_all

.PHONY: string_replacer_test_run_all
string_replacer_test_run_all: $(string_replacer_test_child_run_targets) ## build and run string_replacer_test
ifneq ($(string_replacer_test_objects),)
string_replacer_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(string_replacer_test_install_path)
endif

.PHONY: string_replacer_test_run
string_replacer_test_run: string_replacer_all
string_replacer_test_run: string_replacer_test_all
ifneq ($(string_replacer_test_objects),)
string_replacer_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(string_replacer_test_install_path)
endif

-include $(string_replacer_depends)
-include $(string_replacer_test_depends)
