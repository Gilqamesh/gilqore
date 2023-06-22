bucket_array_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
bucket_array_path_curtestdir			:= $(bucket_array_path_curdir)test/
bucket_array_child_makefiles			:= $(wildcard $(bucket_array_path_curdir)*/*mk)
bucket_array_child_module_names		:= $(basename $(notdir $(bucket_array_child_makefiles)))
bucket_array_child_all_targets		:= $(foreach child_module,$(bucket_array_child_module_names),$(child_module)_all)
bucket_array_child_clean_targets		:= $(foreach child_module,$(bucket_array_child_module_names),$(child_module)_clean)
bucket_array_test_child_all_targets	:= $(foreach test_module,$(bucket_array_child_module_names),$(test_module)_test_all)
bucket_array_test_child_clean_targets	:= $(foreach test_module,$(bucket_array_child_module_names),$(test_module)_test_clean)
bucket_array_test_child_run_targets	:= $(foreach test_module,$(bucket_array_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
bucket_array_test_install_path        := $(bucket_array_path_curtestdir)bucket_array$(EXT_EXE)
endif
bucket_array_test_sources             := $(wildcard $(bucket_array_path_curtestdir)*.c)
bucket_array_sources					:= $(wildcard $(bucket_array_path_curdir)*.c)
bucket_array_sources					+= $(wildcard $(bucket_array_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
bucket_array_sources					+= $(wildcard $(bucket_array_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
bucket_array_sources					+= $(wildcard $(bucket_array_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
bucket_array_sources					+= $(wildcard $(bucket_array_path_curdir)platform_specific/mac/*.c)
endif
bucket_array_objects                  := $(patsubst %.c, %.o, $(bucket_array_sources))
bucket_array_test_objects				:= $(patsubst %.c, %.o, $(bucket_array_test_sources))
bucket_array_test_depends				:= $(patsubst %.c, %.d, $(bucket_array_test_sources))
bucket_array_depends					:= $(patsubst %.c, %.d, $(bucket_array_sources))
bucket_array_depends_modules			:=  common
bucket_array_test_depends_modules     := bucket_array test_framework libc common compare process file time system random file_reader hash circular_buffer mod memory 
bucket_array_test_libdepend_objs      = $(foreach dep_module,$(bucket_array_test_depends_modules),$($(dep_module)_objects))
bucket_array_clean_files				:=
bucket_array_clean_files				+= $(bucket_array_install_path_implib)
bucket_array_clean_files				+= $(bucket_array_objects)
bucket_array_clean_files				+= $(bucket_array_test_objects)
bucket_array_clean_files				+= $(bucket_array_depends)

include $(bucket_array_child_makefiles)

#$(bucket_array_path_curtestdir)%.o: $(bucket_array_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(bucket_array_path_curdir)%.o: $(bucket_array_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(bucket_array_test_install_path): $(bucket_array_test_objects) $(bucket_array_test_libdepend_objs)
	$(CC) -o $@ $(bucket_array_test_objects) $(bucket_array_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole tcc/lib/libtcc1-64.a tcc/libtcc.dll

.PHONY: bucket_array_all
bucket_array_all: $(bucket_array_objects) ## build all bucket_array object files

.PHONY: bucket_array_test_all
bucket_array_test_all: $(bucket_array_test_install_path) ## build bucket_array_test test

.PHONY: bucket_array_clean
bucket_array_clean: $(bucket_array_child_clean_targets) ## remove all bucket_array object files
bucket_array_clean:
	- $(RM) $(bucket_array_clean_files)

.PHONY: bucket_array_test_clean
bucket_array_test_clean: $(bucket_array_test_child_clean_targets) ## remove all bucket_array_test tests
bucket_array_test_clean:
	- $(RM) $(bucket_array_test_install_path) $(bucket_array_test_objects) $(bucket_array_test_depends)

.PHONY: bucket_array_re
bucket_array_re: bucket_array_clean
bucket_array_re: bucket_array_all

.PHONY: bucket_array_test_re
bucket_array_test_re: bucket_array_test_clean
bucket_array_test_re: bucket_array_test_all

.PHONY: bucket_array_test_run_all
bucket_array_test_run_all: $(bucket_array_test_child_run_targets) ## build and run bucket_array_test
ifneq ($(bucket_array_test_objects),)
bucket_array_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(bucket_array_test_install_path)
endif

.PHONY: bucket_array_test_run
bucket_array_test_run: bucket_array_all
bucket_array_test_run: bucket_array_test_all
ifneq ($(bucket_array_test_objects),)
bucket_array_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(bucket_array_test_install_path)
endif

-include $(bucket_array_depends)
-include $(bucket_array_test_depends)
