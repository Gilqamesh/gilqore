color_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
color_path_curtestdir			:= $(color_path_curdir)test/
color_child_makefiles			:= $(wildcard $(color_path_curdir)*/*mk)
color_child_module_names		:= $(basename $(notdir $(color_child_makefiles)))
color_child_all_targets		:= $(foreach child_module,$(color_child_module_names),$(child_module)_all)
color_child_clean_targets		:= $(foreach child_module,$(color_child_module_names),$(child_module)_clean)
color_test_child_all_targets	:= $(foreach test_module,$(color_child_module_names),$(test_module)_test_all)
color_test_child_clean_targets	:= $(foreach test_module,$(color_child_module_names),$(test_module)_test_clean)
color_test_child_run_targets	:= $(foreach test_module,$(color_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
color_test_install_path_static := $(color_path_curtestdir)color_static$(EXT_EXE)
endif
color_test_sources             := $(wildcard $(color_path_curtestdir)*.c)
color_sources					:= $(wildcard $(color_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
color_sources					+= $(wildcard $(color_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
color_sources					+= $(wildcard $(color_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
color_sources					+= $(wildcard $(color_path_curdir)platform_specific/mac/*.c)
endif
color_static_objects			:= $(patsubst %.c, %_static.o, $(color_sources))
color_test_objects				:= $(patsubst %.c, %.o, $(color_test_sources))
color_test_depends				:= $(patsubst %.c, %.d, $(color_test_sources))
color_depends					:= $(patsubst %.c, %.d, $(color_sources))
color_depends_modules			:= 
color_test_depends_modules     := color test_framework libc common process file time system random compare file_reader hash circular_buffer mod 
color_test_depends_modules     += color
color_test_libdepend_static_objs   = $(foreach dep_module,$(color_test_depends_modules),$($(dep_module)_static_objects))
color_clean_files				:=
color_clean_files				+= $(color_install_path_implib)
color_clean_files				+= $(color_static_objects)
color_clean_files				+= $(color_test_objects)
color_clean_files				+= $(color_depends)

include $(color_child_makefiles)

$(color_path_curtestdir)%.o: $(color_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(color_path_curdir)%_static.o: $(color_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(color_test_install_path_static): $(color_test_objects) $(color_test_libdepend_static_objs)
	$(CC) -o $@ $(color_test_objects) -Wl,--allow-multiple-definition $(color_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: color_all
color_all: $(color_static_objects) ## build all color object files

.PHONY: color_test_all
color_test_all: $(color_test_install_path_static) ## build color_test test

.PHONY: color_clean
color_clean: $(color_child_clean_targets) ## remove all color object files
color_clean:
	- $(RM) $(color_clean_files)

.PHONY: color_test_clean
color_test_clean: $(color_test_child_clean_targets) ## remove all color_test tests
color_test_clean:
	- $(RM) $(color_test_install_path_static) $(color_test_objects) $(color_test_depends)

.PHONY: color_re
color_re: color_clean
color_re: color_all

.PHONY: color_test_re
color_test_re: color_test_clean
color_test_re: color_test_all

.PHONY: color_test_run_all
color_test_run_all: $(color_test_child_all_targets) ## build and run color_test
color_test_run_all: $(color_test_child_run_targets)
ifneq ($(color_test_objects),)
color_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(color_test_install_path_static)
endif

.PHONY: color_test_run
color_test_run: color_test_all
ifneq ($(color_test_objects),)
color_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(color_test_install_path_static)
endif

-include $(color_depends)
-include $(color_test_depends)
