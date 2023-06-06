data_structures_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
data_structures_path_curtestdir			:= $(data_structures_path_curdir)test/
data_structures_child_makefiles			:= $(wildcard $(data_structures_path_curdir)*/*mk)
data_structures_child_module_names		:= $(basename $(notdir $(data_structures_child_makefiles)))
data_structures_child_all_targets		:= $(foreach child_module,$(data_structures_child_module_names),$(child_module)_all)
data_structures_child_clean_targets		:= $(foreach child_module,$(data_structures_child_module_names),$(child_module)_clean)
data_structures_test_child_all_targets	:= $(foreach test_module,$(data_structures_child_module_names),$(test_module)_test_all)
data_structures_test_child_clean_targets	:= $(foreach test_module,$(data_structures_child_module_names),$(test_module)_test_clean)
data_structures_test_child_run_targets	:= $(foreach test_module,$(data_structures_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
data_structures_test_install_path_static := $(data_structures_path_curtestdir)data_structures_static$(EXT_EXE)
endif
data_structures_test_sources             := $(wildcard $(data_structures_path_curtestdir)*.c)
data_structures_sources					:= $(wildcard $(data_structures_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
data_structures_sources					+= $(wildcard $(data_structures_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
data_structures_sources					+= $(wildcard $(data_structures_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
data_structures_sources					+= $(wildcard $(data_structures_path_curdir)platform_specific/mac/*.c)
endif
data_structures_static_objects			:= $(patsubst %.c, %_static.o, $(data_structures_sources))
data_structures_test_objects				:= $(patsubst %.c, %.o, $(data_structures_test_sources))
data_structures_test_depends				:= $(patsubst %.c, %.d, $(data_structures_test_sources))
data_structures_depends					:= $(patsubst %.c, %.d, $(data_structures_sources))
data_structures_depends_modules			:= 
data_structures_test_depends_modules     := data_structures test_framework libc common process file time system random compare file_reader hash circular_buffer mod 
data_structures_test_depends_modules     += data_structures
data_structures_test_libdepend_static_objs   = $(foreach dep_module,$(data_structures_test_depends_modules),$($(dep_module)_static_objects))
data_structures_clean_files				:=
data_structures_clean_files				+= $(data_structures_install_path_implib)
data_structures_clean_files				+= $(data_structures_static_objects)
data_structures_clean_files				+= $(data_structures_test_objects)
data_structures_clean_files				+= $(data_structures_depends)

include $(data_structures_child_makefiles)

$(data_structures_path_curtestdir)%.o: $(data_structures_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(data_structures_path_curdir)%_static.o: $(data_structures_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(data_structures_test_install_path_static): $(data_structures_test_objects) $(data_structures_test_libdepend_static_objs)
	$(CC) -o $@ $(data_structures_test_objects) -Wl,--allow-multiple-definition $(data_structures_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: data_structures_all
data_structures_all: $(data_structures_static_objects) ## build all data_structures object files

.PHONY: data_structures_test_all
data_structures_test_all: $(data_structures_test_install_path_static) ## build data_structures_test test

.PHONY: data_structures_clean
data_structures_clean: $(data_structures_child_clean_targets) ## remove all data_structures object files
data_structures_clean:
	- $(RM) $(data_structures_clean_files)

.PHONY: data_structures_test_clean
data_structures_test_clean: $(data_structures_test_child_clean_targets) ## remove all data_structures_test tests
data_structures_test_clean:
	- $(RM) $(data_structures_test_install_path_static) $(data_structures_test_objects) $(data_structures_test_depends)

.PHONY: data_structures_re
data_structures_re: data_structures_clean
data_structures_re: data_structures_all

.PHONY: data_structures_test_re
data_structures_test_re: data_structures_test_clean
data_structures_test_re: data_structures_test_all

.PHONY: data_structures_test_run_all
data_structures_test_run_all: $(data_structures_test_child_all_targets) ## build and run data_structures_test
data_structures_test_run_all: $(data_structures_test_child_run_targets)
ifneq ($(data_structures_test_objects),)
data_structures_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(data_structures_test_install_path_static)
endif

.PHONY: data_structures_test_run
data_structures_test_run: data_structures_test_all
ifneq ($(data_structures_test_objects),)
data_structures_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(data_structures_test_install_path_static)
endif

-include $(data_structures_depends)
-include $(data_structures_test_depends)
