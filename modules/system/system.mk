system_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
system_path_curtestdir			:= $(system_path_curdir)test/
system_child_makefiles			:= $(wildcard $(system_path_curdir)*/*mk)
system_child_module_names		:= $(basename $(notdir $(system_child_makefiles)))
system_child_all_targets		:= $(foreach child_module,$(system_child_module_names),$(child_module)_all)
system_child_clean_targets		:= $(foreach child_module,$(system_child_module_names),$(child_module)_clean)
system_test_child_all_targets	:= $(foreach test_module,$(system_child_module_names),$(test_module)_test_all)
system_test_child_clean_targets	:= $(foreach test_module,$(system_child_module_names),$(test_module)_test_clean)
system_test_child_run_targets	:= $(foreach test_module,$(system_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
system_test_install_path_static := $(system_path_curtestdir)system_static$(EXT_EXE)
endif
system_test_sources             := $(wildcard $(system_path_curtestdir)*.c)
system_sources					:= $(wildcard $(system_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
system_sources					+= $(wildcard $(system_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
system_sources					+= $(wildcard $(system_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
system_sources					+= $(wildcard $(system_path_curdir)platform_specific/mac/*.c)
endif
system_static_objects			:= $(patsubst %.c, %_static.o, $(system_sources))
system_test_objects				:= $(patsubst %.c, %.o, $(system_test_sources))
system_test_depends				:= $(patsubst %.c, %.d, $(system_test_sources))
system_depends					:= $(patsubst %.c, %.d, $(system_sources))
system_depends_modules			:= common 
system_test_depends_modules     := system test_framework libc common process file time random compare file_reader hash circular_buffer mod 
system_test_depends_modules     += system
system_test_libdepend_static_objs   = $(foreach dep_module,$(system_test_depends_modules),$($(dep_module)_static_objects))
system_clean_files				:=
system_clean_files				+= $(system_install_path_implib)
system_clean_files				+= $(system_static_objects)
system_clean_files				+= $(system_test_objects)
system_clean_files				+= $(system_depends)

include $(system_child_makefiles)

$(system_path_curtestdir)%.o: $(system_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(system_path_curdir)%_static.o: $(system_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(system_test_install_path_static): $(system_test_objects) $(system_test_libdepend_static_objs)
	$(CC) -o $@ $(system_test_objects) -Wl,--allow-multiple-definition $(system_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: system_all
system_all: $(system_static_objects) ## build all system object files

.PHONY: system_test_all
system_test_all: $(system_test_install_path_static) ## build system_test test

.PHONY: system_clean
system_clean: $(system_child_clean_targets) ## remove all system object files
system_clean:
	- $(RM) $(system_clean_files)

.PHONY: system_test_clean
system_test_clean: $(system_test_child_clean_targets) ## remove all system_test tests
system_test_clean:
	- $(RM) $(system_test_install_path_static) $(system_test_objects) $(system_test_depends)

.PHONY: system_re
system_re: system_clean
system_re: system_all

.PHONY: system_test_re
system_test_re: system_test_clean
system_test_re: system_test_all

.PHONY: system_test_run_all
system_test_run_all: $(system_test_child_all_targets) ## build and run system_test
system_test_run_all: $(system_test_child_run_targets)
ifneq ($(system_test_objects),)
system_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(system_test_install_path_static)
endif

.PHONY: system_test_run
system_test_run: system_test_all
ifneq ($(system_test_objects),)
system_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(system_test_install_path_static)
endif

-include $(system_depends)
-include $(system_test_depends)
