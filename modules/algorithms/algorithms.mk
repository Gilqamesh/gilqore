algorithms_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
algorithms_path_curtestdir			:= $(algorithms_path_curdir)test/
algorithms_child_makefiles			:= $(wildcard $(algorithms_path_curdir)*/*mk)
algorithms_child_module_names		:= $(basename $(notdir $(algorithms_child_makefiles)))
algorithms_child_all_targets		:= $(foreach child_module,$(algorithms_child_module_names),$(child_module)_all)
algorithms_child_clean_targets		:= $(foreach child_module,$(algorithms_child_module_names),$(child_module)_clean)
algorithms_test_child_all_targets	:= $(foreach test_module,$(algorithms_child_module_names),$(test_module)_test_all)
algorithms_test_child_clean_targets	:= $(foreach test_module,$(algorithms_child_module_names),$(test_module)_test_clean)
algorithms_test_child_run_targets	:= $(foreach test_module,$(algorithms_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
algorithms_test_install_path_static := $(algorithms_path_curtestdir)algorithms_static$(EXT_EXE)
endif
algorithms_test_sources             := $(wildcard $(algorithms_path_curtestdir)*.c)
algorithms_sources					:= $(wildcard $(algorithms_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
algorithms_sources					+= $(wildcard $(algorithms_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
algorithms_sources					+= $(wildcard $(algorithms_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
algorithms_sources					+= $(wildcard $(algorithms_path_curdir)platform_specific/mac/*.c)
endif
algorithms_static_objects			:= $(patsubst %.c, %_static.o, $(algorithms_sources))
algorithms_test_objects				:= $(patsubst %.c, %.o, $(algorithms_test_sources))
algorithms_test_depends				:= $(patsubst %.c, %.d, $(algorithms_test_sources))
algorithms_depends					:= $(patsubst %.c, %.d, $(algorithms_sources))
algorithms_depends_modules			:= 
algorithms_test_depends_modules     = $(algorithms_depends_modules)
algorithms_test_depends_modules     += algorithms
algorithms_test_libdepend_static_objs   = $(foreach dep_module,$(algorithms_depends_modules),$($(dep_module)_static_objects))
algorithms_test_libdepend_static_objs   += $(algorithms_static_objects)
algorithms_clean_files				:=
algorithms_clean_files				+= $(algorithms_install_path_implib)
algorithms_clean_files				+= $(algorithms_static_objects)
algorithms_clean_files				+= $(algorithms_depends)

include $(algorithms_child_makefiles)

$(algorithms_path_curtestdir)%.o: $(algorithms_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(algorithms_path_curdir)%_static.o: $(algorithms_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(algorithms_test_install_path_static): $(algorithms_test_objects) $(algorithms_test_libdepend_static_objs)
	$(CC) -o $@ $(algorithms_test_objects) -Wl,--allow-multiple-definition $(algorithms_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: algorithms_all
algorithms_all: $(algorithms_child_all_targets) ## build all algorithms object files
algorithms_all: $(algorithms_static_objects)

.PHONY: algorithms_test_all
algorithms_test_all: $(algorithms_test_child_all_targets) ## build all algorithms_test tests
ifneq ($(algorithms_test_objects),)
algorithms_test_all: $(algorithms_test_install_path_static)
endif

.PHONY: algorithms_clean
algorithms_clean: $(algorithms_child_clean_targets) ## remove all algorithms object files
algorithms_clean:
	- $(RM) $(algorithms_clean_files)

.PHONY: algorithms_test_clean
algorithms_test_clean: $(algorithms_test_child_clean_targets) ## remove all algorithms_test tests
algorithms_test_clean:
	- $(RM) $(algorithms_test_install_path_static) $(algorithms_test_objects) $(algorithms_test_depends)

.PHONY: algorithms_re
algorithms_re: algorithms_clean
algorithms_re: algorithms_all

.PHONY: algorithms_test_re
algorithms_test_re: algorithms_test_clean
algorithms_test_re: algorithms_test_all

.PHONY: algorithms_test_run_all
algorithms_test_run_all: algorithms_test_all ## build and run algorithms_test
algorithms_test_run_all: $(algorithms_test_child_run_targets)
ifneq ($(algorithms_test_objects),)
algorithms_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(algorithms_test_install_path_static)
endif

.PHONY: algorithms_test_run
algorithms_test_run: algorithms_test_all
ifneq ($(algorithms_test_objects),)
algorithms_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(algorithms_test_install_path_static)
endif

-include $(algorithms_depends)
-include $(algorithms_test_depends)
