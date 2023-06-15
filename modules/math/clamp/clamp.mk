clamp_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
clamp_path_curtestdir			:= $(clamp_path_curdir)test/
clamp_child_makefiles			:= $(wildcard $(clamp_path_curdir)*/*mk)
clamp_child_module_names		:= $(basename $(notdir $(clamp_child_makefiles)))
clamp_child_all_targets		:= $(foreach child_module,$(clamp_child_module_names),$(child_module)_all)
clamp_child_clean_targets		:= $(foreach child_module,$(clamp_child_module_names),$(child_module)_clean)
clamp_test_child_all_targets	:= $(foreach test_module,$(clamp_child_module_names),$(test_module)_test_all)
clamp_test_child_clean_targets	:= $(foreach test_module,$(clamp_child_module_names),$(test_module)_test_clean)
clamp_test_child_run_targets	:= $(foreach test_module,$(clamp_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
clamp_test_install_path        := $(clamp_path_curtestdir)clamp$(EXT_EXE)
endif
clamp_test_sources             := $(wildcard $(clamp_path_curtestdir)*.c)
clamp_sources					:= $(wildcard $(clamp_path_curdir)*.c)
clamp_sources					+= $(wildcard $(clamp_path_curdir)impl/*.c)
ifeq ($(PLATFORM), WINDOWS)
clamp_sources					+= $(wildcard $(clamp_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
clamp_sources					+= $(wildcard $(clamp_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
clamp_sources					+= $(wildcard $(clamp_path_curdir)platform_specific/mac/*.c)
endif
clamp_objects                  := $(patsubst %.c, %.o, $(clamp_sources))
clamp_test_objects				:= $(patsubst %.c, %.o, $(clamp_test_sources))
clamp_test_depends				:= $(patsubst %.c, %.d, $(clamp_test_sources))
clamp_depends					:= $(patsubst %.c, %.d, $(clamp_sources))
clamp_depends_modules			:= v2 sqrt abs v3 v4  common
clamp_test_depends_modules     := clamp test_framework libc common process file time system random compare file_reader hash circular_buffer mod v2 sqrt abs v3 v4 
clamp_test_libdepend_objs      = $(foreach dep_module,$(clamp_test_depends_modules),$($(dep_module)_objects))
clamp_clean_files				:=
clamp_clean_files				+= $(clamp_install_path_implib)
clamp_clean_files				+= $(clamp_objects)
clamp_clean_files				+= $(clamp_test_objects)
clamp_clean_files				+= $(clamp_depends)

include $(clamp_child_makefiles)

#$(clamp_path_curtestdir)%.o: $(clamp_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(clamp_path_curdir)%.o: $(clamp_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(clamp_test_install_path): $(clamp_test_objects) $(clamp_test_libdepend_objs)
	$(CC) -o $@ $(clamp_test_objects) -Wl,--allow-multiple-definition $(clamp_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: clamp_all
clamp_all: $(clamp_objects) ## build all clamp object files

.PHONY: clamp_test_all
clamp_test_all: $(clamp_test_install_path) ## build clamp_test test

.PHONY: clamp_clean
clamp_clean: $(clamp_child_clean_targets) ## remove all clamp object files
clamp_clean:
	- $(RM) $(clamp_clean_files)

.PHONY: clamp_test_clean
clamp_test_clean: $(clamp_test_child_clean_targets) ## remove all clamp_test tests
clamp_test_clean:
	- $(RM) $(clamp_test_install_path) $(clamp_test_objects) $(clamp_test_depends)

.PHONY: clamp_re
clamp_re: clamp_clean
clamp_re: clamp_all

.PHONY: clamp_test_re
clamp_test_re: clamp_test_clean
clamp_test_re: clamp_test_all

.PHONY: clamp_test_run_all
clamp_test_run_all: $(clamp_test_child_run_targets) ## build and run clamp_test
ifneq ($(clamp_test_objects),)
clamp_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(clamp_test_install_path)
endif

.PHONY: clamp_test_run
clamp_test_run: clamp_all
clamp_test_run: clamp_test_all
ifneq ($(clamp_test_objects),)
clamp_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(clamp_test_install_path)
endif

-include $(clamp_depends)
-include $(clamp_test_depends)
