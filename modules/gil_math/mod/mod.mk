mod_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
mod_path_curtestdir			:= $(mod_path_curdir)test/
mod_child_makefiles			:= $(wildcard $(mod_path_curdir)*/*mk)
mod_child_module_names		:= $(basename $(notdir $(mod_child_makefiles)))
mod_child_all_targets		:= $(foreach child_module,$(mod_child_module_names),$(child_module)_all)
mod_child_clean_targets		:= $(foreach child_module,$(mod_child_module_names),$(child_module)_clean)
mod_test_child_all_targets	:= $(foreach test_module,$(mod_child_module_names),$(test_module)_test_all)
mod_test_child_clean_targets	:= $(foreach test_module,$(mod_child_module_names),$(test_module)_test_clean)
mod_test_child_run_targets	:= $(foreach test_module,$(mod_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
mod_test_install_path        := $(mod_path_curtestdir)mod$(EXT_EXE)
endif
mod_test_sources             := $(wildcard $(mod_path_curtestdir)*.c)
mod_sources					:= $(wildcard $(mod_path_curdir)*.c)
mod_sources					+= $(wildcard $(mod_path_curdir)platform_non_specific/*.c)
ifeq ($(PLATFORM), WINDOWS)
mod_sources					+= $(wildcard $(mod_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
mod_sources					+= $(wildcard $(mod_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
mod_sources					+= $(wildcard $(mod_path_curdir)platform_specific/mac/*.c)
endif
mod_objects                  := $(patsubst %.c, %.o, $(mod_sources))
mod_test_objects				:= $(patsubst %.c, %.o, $(mod_test_sources))
mod_test_depends				:= $(patsubst %.c, %.d, $(mod_test_sources))
mod_depends					:= $(patsubst %.c, %.d, $(mod_sources))
mod_depends_modules			:=  common
mod_test_depends_modules     := mod test_framework libc common compare process file time system random file_reader hash circular_buffer memory 
mod_test_libdepend_objs      = $(foreach dep_module,$(mod_test_depends_modules),$($(dep_module)_objects))
mod_clean_files				:=
mod_clean_files				+= $(mod_install_path_implib)
mod_clean_files				+= $(mod_objects)
mod_clean_files				+= $(mod_test_objects)
mod_clean_files				+= $(mod_depends)

include $(mod_child_makefiles)

#$(mod_path_curtestdir)%.o: $(mod_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(mod_path_curdir)%.o: $(mod_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(mod_test_install_path): $(mod_test_objects) $(mod_test_libdepend_objs)
	$(CC) -o $@ $(mod_test_objects) $(mod_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole tcc/lib/libtcc1-64.a tcc/libtcc.dll

.PHONY: mod_all
mod_all: $(mod_objects) ## build all mod object files

.PHONY: mod_test_all
mod_test_all: $(mod_test_install_path) ## build mod_test test

.PHONY: mod_clean
mod_clean: $(mod_child_clean_targets) ## remove all mod object files
mod_clean:
	- $(RM) $(mod_clean_files)

.PHONY: mod_test_clean
mod_test_clean: $(mod_test_child_clean_targets) ## remove all mod_test tests
mod_test_clean:
	- $(RM) $(mod_test_install_path) $(mod_test_objects) $(mod_test_depends)

.PHONY: mod_re
mod_re: mod_clean
mod_re: mod_all

.PHONY: mod_test_re
mod_test_re: mod_test_clean
mod_test_re: mod_test_all

.PHONY: mod_test_run_all
mod_test_run_all: $(mod_test_child_run_targets) ## build and run mod_test
ifneq ($(mod_test_objects),)
mod_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(mod_test_install_path)
endif

.PHONY: mod_test_run
mod_test_run: mod_all
mod_test_run: mod_test_all
ifneq ($(mod_test_objects),)
mod_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(mod_test_install_path)
endif

-include $(mod_depends)
-include $(mod_test_depends)
