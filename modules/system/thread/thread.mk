thread_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
thread_path_curtestdir			:= $(thread_path_curdir)test/
thread_child_makefiles			:= $(wildcard $(thread_path_curdir)*/*mk)
thread_child_module_names		:= $(basename $(notdir $(thread_child_makefiles)))
thread_child_all_targets		:= $(foreach child_module,$(thread_child_module_names),$(child_module)_all)
thread_child_clean_targets		:= $(foreach child_module,$(thread_child_module_names),$(child_module)_clean)
thread_test_child_all_targets	:= $(foreach test_module,$(thread_child_module_names),$(test_module)_test_all)
thread_test_child_clean_targets	:= $(foreach test_module,$(thread_child_module_names),$(test_module)_test_clean)
thread_test_child_run_targets	:= $(foreach test_module,$(thread_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
thread_test_install_path        := $(thread_path_curtestdir)thread$(EXT_EXE)
endif
thread_test_sources             := $(wildcard $(thread_path_curtestdir)*.c)
thread_sources					:= $(wildcard $(thread_path_curdir)*.c)
thread_sources					+= $(wildcard $(thread_path_curdir)impl/*.c)
ifeq ($(PLATFORM), WINDOWS)
thread_sources					+= $(wildcard $(thread_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
thread_sources					+= $(wildcard $(thread_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
thread_sources					+= $(wildcard $(thread_path_curdir)platform_specific/mac/*.c)
endif
thread_objects                  := $(patsubst %.c, %.o, $(thread_sources))
thread_test_objects				:= $(patsubst %.c, %.o, $(thread_test_sources))
thread_test_depends				:= $(patsubst %.c, %.d, $(thread_test_sources))
thread_depends					:= $(patsubst %.c, %.d, $(thread_sources))
thread_depends_modules			:=  common
thread_test_depends_modules     := thread test_framework libc common process file time system random compare file_reader hash circular_buffer mod 
thread_test_libdepend_objs      = $(foreach dep_module,$(thread_test_depends_modules),$($(dep_module)_objects))
thread_clean_files				:=
thread_clean_files				+= $(thread_install_path_implib)
thread_clean_files				+= $(thread_objects)
thread_clean_files				+= $(thread_test_objects)
thread_clean_files				+= $(thread_depends)

include $(thread_child_makefiles)

#$(thread_path_curtestdir)%.o: $(thread_path_curtestdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

#$(thread_path_curdir)%.o: $(thread_path_curdir)%.c
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)

$(thread_test_install_path): $(thread_test_objects) $(thread_test_libdepend_objs)
	$(CC) -o $@ $(thread_test_objects) -Wl,--allow-multiple-definition $(thread_test_libdepend_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: thread_all
thread_all: $(thread_objects) ## build all thread object files

.PHONY: thread_test_all
thread_test_all: $(thread_test_install_path) ## build thread_test test

.PHONY: thread_clean
thread_clean: $(thread_child_clean_targets) ## remove all thread object files
thread_clean:
	- $(RM) $(thread_clean_files)

.PHONY: thread_test_clean
thread_test_clean: $(thread_test_child_clean_targets) ## remove all thread_test tests
thread_test_clean:
	- $(RM) $(thread_test_install_path) $(thread_test_objects) $(thread_test_depends)

.PHONY: thread_re
thread_re: thread_clean
thread_re: thread_all

.PHONY: thread_test_re
thread_test_re: thread_test_clean
thread_test_re: thread_test_all

.PHONY: thread_test_run_all
thread_test_run_all: $(thread_test_child_run_targets) ## build and run thread_test
ifneq ($(thread_test_objects),)
thread_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(thread_test_install_path)
endif

.PHONY: thread_test_run
thread_test_run: thread_all
thread_test_run: thread_test_all
ifneq ($(thread_test_objects),)
thread_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(thread_test_install_path)
endif

-include $(thread_depends)
-include $(thread_test_depends)
