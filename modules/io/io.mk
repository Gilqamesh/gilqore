io_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
io_path_curtestdir			:= $(io_path_curdir)test/
io_child_makefiles			:= $(wildcard $(io_path_curdir)*/*mk)
io_child_module_names		:= $(basename $(notdir $(io_child_makefiles)))
io_child_all_targets		:= $(foreach child_module,$(io_child_module_names),$(child_module)_all)
io_child_clean_targets		:= $(foreach child_module,$(io_child_module_names),$(child_module)_clean)
io_test_child_all_targets	:= $(foreach test_module,$(io_child_module_names),$(test_module)_test_all)
io_test_child_clean_targets	:= $(foreach test_module,$(io_child_module_names),$(test_module)_test_clean)
io_test_child_run_targets	:= $(foreach test_module,$(io_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
io_test_install_path        := $(io_path_curtestdir)io$(EXT_EXE)
endif
io_test_sources             := $(wildcard $(io_path_curtestdir)*.c)
io_sources					:= $(wildcard $(io_path_curdir)*.c)
io_sources					+= $(wildcard $(io_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
io_sources					+= $(wildcard $(io_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
io_sources					+= $(wildcard $(io_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
io_sources					+= $(wildcard $(io_path_curdir)platform_specific/mac/*.c)
endif
io_objects                  := $(patsubst %.c, %.o, $(io_sources))
io_test_objects				:= $(patsubst %.c, %.o, $(io_test_sources))
io_test_depends				:= $(patsubst %.c, %.d, $(io_test_sources))
io_depends					:= $(patsubst %.c, %.d, $(io_sources))
io_depends_modules			:=  common
io_test_depends_modules     := io test_framework libc common compare process file time system random file_reader hash circular_buffer mod memory 
io_test_libdepend_objs      = $(foreach dep_module,$(io_test_depends_modules),$($(dep_module)_objects))
io_clean_files				:=
io_clean_files				+= $(io_install_path_implib)
io_clean_files				+= $(io_objects)
io_clean_files				+= $(io_test_objects)
io_clean_files				+= $(io_depends)

include $(io_child_makefiles)

#$(io_path_curtestdir)%.o: $(io_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(io_path_curdir)%.o: $(io_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(io_test_install_path): $(io_test_objects) $(io_test_libdepend_objs)
	$(CC) -o $@ $(io_test_objects) $(io_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole tcc/lib/libtcc1-64.a tcc/libtcc.dll

.PHONY: io_all
io_all: $(io_objects) ## build all io object files

.PHONY: io_test_all
io_test_all: $(io_test_install_path) ## build io_test test

.PHONY: io_clean
io_clean: $(io_child_clean_targets) ## remove all io object files
io_clean:
	- $(RM) $(io_clean_files)

.PHONY: io_test_clean
io_test_clean: $(io_test_child_clean_targets) ## remove all io_test tests
io_test_clean:
	- $(RM) $(io_test_install_path) $(io_test_objects) $(io_test_depends)

.PHONY: io_re
io_re: io_clean
io_re: io_all

.PHONY: io_test_re
io_test_re: io_test_clean
io_test_re: io_test_all

.PHONY: io_test_run_all
io_test_run_all: $(io_test_child_run_targets) ## build and run io_test
ifneq ($(io_test_objects),)
io_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(io_test_install_path)
endif

.PHONY: io_test_run
io_test_run: io_all
io_test_run: io_test_all
ifneq ($(io_test_objects),)
io_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(io_test_install_path)
endif

-include $(io_depends)
-include $(io_test_depends)
