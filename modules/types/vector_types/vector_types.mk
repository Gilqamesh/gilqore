vector_types_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
vector_types_path_curtestdir			:= $(vector_types_path_curdir)test/
vector_types_child_makefiles			:= $(wildcard $(vector_types_path_curdir)*/*mk)
vector_types_child_module_names		:= $(basename $(notdir $(vector_types_child_makefiles)))
vector_types_child_all_targets		:= $(foreach child_module,$(vector_types_child_module_names),$(child_module)_all)
vector_types_child_clean_targets		:= $(foreach child_module,$(vector_types_child_module_names),$(child_module)_clean)
vector_types_test_child_all_targets	:= $(foreach test_module,$(vector_types_child_module_names),$(test_module)_test_all)
vector_types_test_child_clean_targets	:= $(foreach test_module,$(vector_types_child_module_names),$(test_module)_test_clean)
vector_types_test_child_run_targets	:= $(foreach test_module,$(vector_types_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
vector_types_test_install_path        := $(vector_types_path_curtestdir)vector_types$(EXT_EXE)
endif
vector_types_test_sources             := $(wildcard $(vector_types_path_curtestdir)*.c)
vector_types_sources					:= $(wildcard $(vector_types_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
vector_types_sources					+= $(wildcard $(vector_types_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
vector_types_sources					+= $(wildcard $(vector_types_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
vector_types_sources					+= $(wildcard $(vector_types_path_curdir)platform_specific/mac/*.c)
endif
vector_types_objects                  := $(patsubst %.c, %.o, $(vector_types_sources))
vector_types_test_objects				:= $(patsubst %.c, %.o, $(vector_types_test_sources))
vector_types_test_depends				:= $(patsubst %.c, %.d, $(vector_types_test_sources))
vector_types_depends					:= $(patsubst %.c, %.d, $(vector_types_sources))
vector_types_depends_modules			:=  common
vector_types_test_depends_modules     := vector_types test_framework libc common process file time system random compare file_reader hash circular_buffer mod 
vector_types_test_libdepend_objs      = $(foreach dep_module,$(vector_types_test_depends_modules),$($(dep_module)_objects))
vector_types_clean_files				:=
vector_types_clean_files				+= $(vector_types_install_path_implib)
vector_types_clean_files				+= $(vector_types_objects)
vector_types_clean_files				+= $(vector_types_test_objects)
vector_types_clean_files				+= $(vector_types_depends)

include $(vector_types_child_makefiles)

#$(vector_types_path_curtestdir)%.o: $(vector_types_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(vector_types_path_curdir)%.o: $(vector_types_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(vector_types_test_install_path): $(vector_types_test_objects) $(vector_types_test_libdepend_objs)
	$(CC) -o $@ $(vector_types_test_objects) -Wl,--allow-multiple-definition $(vector_types_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: vector_types_all
vector_types_all: $(vector_types_objects) ## build all vector_types object files

.PHONY: vector_types_test_all
vector_types_test_all: $(vector_types_test_install_path) ## build vector_types_test test

.PHONY: vector_types_clean
vector_types_clean: $(vector_types_child_clean_targets) ## remove all vector_types object files
vector_types_clean:
	- $(RM) $(vector_types_clean_files)

.PHONY: vector_types_test_clean
vector_types_test_clean: $(vector_types_test_child_clean_targets) ## remove all vector_types_test tests
vector_types_test_clean:
	- $(RM) $(vector_types_test_install_path) $(vector_types_test_objects) $(vector_types_test_depends)

.PHONY: vector_types_re
vector_types_re: vector_types_clean
vector_types_re: vector_types_all

.PHONY: vector_types_test_re
vector_types_test_re: vector_types_test_clean
vector_types_test_re: vector_types_test_all

.PHONY: vector_types_test_run_all
vector_types_test_run_all: $(vector_types_test_child_run_targets) ## build and run vector_types_test
ifneq ($(vector_types_test_objects),)
vector_types_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(vector_types_test_install_path)
endif

.PHONY: vector_types_test_run
vector_types_test_run: vector_types_all
vector_types_test_run: vector_types_test_all
ifneq ($(vector_types_test_objects),)
vector_types_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(vector_types_test_install_path)
endif

-include $(vector_types_depends)
-include $(vector_types_test_depends)
