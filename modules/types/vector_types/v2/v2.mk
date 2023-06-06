v2_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
v2_path_curtestdir			:= $(v2_path_curdir)test/
v2_child_makefiles			:= $(wildcard $(v2_path_curdir)*/*mk)
v2_child_module_names		:= $(basename $(notdir $(v2_child_makefiles)))
v2_child_all_targets		:= $(foreach child_module,$(v2_child_module_names),$(child_module)_all)
v2_child_clean_targets		:= $(foreach child_module,$(v2_child_module_names),$(child_module)_clean)
v2_test_child_all_targets	:= $(foreach test_module,$(v2_child_module_names),$(test_module)_test_all)
v2_test_child_clean_targets	:= $(foreach test_module,$(v2_child_module_names),$(test_module)_test_clean)
v2_test_child_run_targets	:= $(foreach test_module,$(v2_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
v2_test_install_path_static := $(v2_path_curtestdir)v2_static$(EXT_EXE)
endif
v2_test_sources             := $(wildcard $(v2_path_curtestdir)*.c)
v2_sources					:= $(wildcard $(v2_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
v2_sources					+= $(wildcard $(v2_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
v2_sources					+= $(wildcard $(v2_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
v2_sources					+= $(wildcard $(v2_path_curdir)platform_specific/mac/*.c)
endif
v2_static_objects			:= $(patsubst %.c, %_static.o, $(v2_sources))
v2_test_objects				:= $(patsubst %.c, %.o, $(v2_test_sources))
v2_test_depends				:= $(patsubst %.c, %.d, $(v2_test_sources))
v2_depends					:= $(patsubst %.c, %.d, $(v2_sources))
v2_depends_modules			:= 
v2_test_depends_modules     := v2 test_framework libc common process file time system random compare file_reader hash circular_buffer mod 
v2_test_depends_modules     += v2
v2_test_libdepend_static_objs   = $(foreach dep_module,$(v2_test_depends_modules),$($(dep_module)_static_objects))
v2_clean_files				:=
v2_clean_files				+= $(v2_install_path_implib)
v2_clean_files				+= $(v2_static_objects)
v2_clean_files				+= $(v2_test_objects)
v2_clean_files				+= $(v2_depends)

include $(v2_child_makefiles)

$(v2_path_curtestdir)%.o: $(v2_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(v2_path_curdir)%_static.o: $(v2_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(v2_test_install_path_static): $(v2_test_objects) $(v2_test_libdepend_static_objs)
	$(CC) -o $@ $(v2_test_objects) -Wl,--allow-multiple-definition $(v2_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: v2_all
v2_all: $(v2_static_objects) ## build all v2 object files

.PHONY: v2_test_all
v2_test_all: $(v2_test_install_path_static) ## build v2_test test

.PHONY: v2_clean
v2_clean: $(v2_child_clean_targets) ## remove all v2 object files
v2_clean:
	- $(RM) $(v2_clean_files)

.PHONY: v2_test_clean
v2_test_clean: $(v2_test_child_clean_targets) ## remove all v2_test tests
v2_test_clean:
	- $(RM) $(v2_test_install_path_static) $(v2_test_objects) $(v2_test_depends)

.PHONY: v2_re
v2_re: v2_clean
v2_re: v2_all

.PHONY: v2_test_re
v2_test_re: v2_test_clean
v2_test_re: v2_test_all

.PHONY: v2_test_run_all
v2_test_run_all: $(v2_test_child_all_targets) ## build and run v2_test
v2_test_run_all: $(v2_test_child_run_targets)
ifneq ($(v2_test_objects),)
v2_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(v2_test_install_path_static)
endif

.PHONY: v2_test_run
v2_test_run: v2_test_all
ifneq ($(v2_test_objects),)
v2_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(v2_test_install_path_static)
endif

-include $(v2_depends)
-include $(v2_test_depends)
