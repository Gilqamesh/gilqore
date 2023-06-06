file_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
file_path_curtestdir			:= $(file_path_curdir)test/
file_child_makefiles			:= $(wildcard $(file_path_curdir)*/*mk)
file_child_module_names		:= $(basename $(notdir $(file_child_makefiles)))
file_child_all_targets		:= $(foreach child_module,$(file_child_module_names),$(child_module)_all)
file_child_clean_targets		:= $(foreach child_module,$(file_child_module_names),$(child_module)_clean)
file_test_child_all_targets	:= $(foreach test_module,$(file_child_module_names),$(test_module)_test_all)
file_test_child_clean_targets	:= $(foreach test_module,$(file_child_module_names),$(test_module)_test_clean)
file_test_child_run_targets	:= $(foreach test_module,$(file_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
file_test_install_path_static := $(file_path_curtestdir)file_static$(EXT_EXE)
endif
file_test_sources             := $(wildcard $(file_path_curtestdir)*.c)
file_sources					:= $(wildcard $(file_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
file_sources					+= $(wildcard $(file_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
file_sources					+= $(wildcard $(file_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
file_sources					+= $(wildcard $(file_path_curdir)platform_specific/mac/*.c)
endif
file_static_objects			:= $(patsubst %.c, %_static.o, $(file_sources))
file_test_objects				:= $(patsubst %.c, %.o, $(file_test_sources))
file_test_depends				:= $(patsubst %.c, %.d, $(file_test_sources))
file_depends					:= $(patsubst %.c, %.d, $(file_sources))
file_depends_modules			:= common time system libc random compare 
file_test_depends_modules     := file test_framework libc common process file_reader hash compare circular_buffer mod random time system 
file_test_depends_modules     += file
file_test_libdepend_static_objs   = $(foreach dep_module,$(file_test_depends_modules),$($(dep_module)_static_objects))
file_clean_files				:=
file_clean_files				+= $(file_install_path_implib)
file_clean_files				+= $(file_static_objects)
file_clean_files				+= $(file_test_objects)
file_clean_files				+= $(file_depends)

include $(file_child_makefiles)

$(file_path_curtestdir)%.o: $(file_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(file_path_curdir)%_static.o: $(file_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(file_test_install_path_static): $(file_test_objects) $(file_test_libdepend_static_objs)
	$(CC) -o $@ $(file_test_objects) -Wl,--allow-multiple-definition $(file_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: file_all
file_all: $(file_static_objects) ## build all file object files

.PHONY: file_test_all
file_test_all: $(file_test_install_path_static) ## build file_test test

.PHONY: file_clean
file_clean: $(file_child_clean_targets) ## remove all file object files
file_clean:
	- $(RM) $(file_clean_files)

.PHONY: file_test_clean
file_test_clean: $(file_test_child_clean_targets) ## remove all file_test tests
file_test_clean:
	- $(RM) $(file_test_install_path_static) $(file_test_objects) $(file_test_depends)

.PHONY: file_re
file_re: file_clean
file_re: file_all

.PHONY: file_test_re
file_test_re: file_test_clean
file_test_re: file_test_all

.PHONY: file_test_run_all
file_test_run_all: $(file_test_child_all_targets) ## build and run file_test
file_test_run_all: $(file_test_child_run_targets)
ifneq ($(file_test_objects),)
file_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(file_test_install_path_static)
endif

.PHONY: file_test_run
file_test_run: file_test_all
ifneq ($(file_test_objects),)
file_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(file_test_install_path_static)
endif

-include $(file_depends)
-include $(file_test_depends)
