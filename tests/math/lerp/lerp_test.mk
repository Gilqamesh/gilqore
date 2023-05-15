lerp_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
lerp_test_child_makefiles			        := $(wildcard $(lerp_test_path_curdir)*/*mk)
lerp_test_child_module_names		        := $(basename $(notdir $(lerp_test_child_makefiles)))
lerp_test_child_all_targets		        := $(foreach test_module,$(lerp_test_child_module_names),$(test_module)_all)
lerp_test_child_clean_targets		        := $(foreach test_module,$(lerp_test_child_module_names),$(test_module)_clean)
lerp_test_child_run_targets		        := $(foreach test_module,$(lerp_test_child_module_names),$(test_module)_run)
lerp_test_install_path_static		        := $(lerp_test_path_curdir)lerp_static$(EXT_EXE)
lerp_test_sources					        := $(wildcard $(lerp_test_path_curdir)*.c)
lerp_test_objects					        := $(patsubst %.c, %.o, $(lerp_test_sources))
lerp_test_depends					        := $(patsubst %.c, %.d, $(lerp_test_sources))
lerp_test_depends_modules			        := $(MODULE_LIBDEP_MODULES)
lerp_test_depends_modules			        += lerp
lerp_test_libdepend_static_objs	        := $(foreach dep_module,$(lerp_depends_modules),$($(dep_module)_static_objects))
lerp_test_libdepend_static_objs	        += $(foreach dep_module,$(lerp_test_depends_modules),$($(dep_module)_static_objects))

include $(lerp_test_child_makefiles)

$(lerp_test_path_curdir)%.o: $(lerp_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(lerp_test_install_path_static): $(lerp_test_objects) $(lerp_test_libdepend_static_objs)
	$(CC) -o $@ $(lerp_test_objects) -Wl,--allow-multiple-definition $(lerp_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: lerp_test_all
lerp_test_all: $(lerp_test_child_all_targets) ## build all lerp_test tests
ifneq ($(lerp_test_objects),)
lerp_test_all: $(lerp_test_install_path_static)
endif

.PHONY: lerp_test_clean
lerp_test_clean: $(lerp_test_child_clean_targets) ## remove all lerp_test tests
lerp_test_clean:
	- $(RM) $(lerp_test_install_path_static) $(lerp_test_objects) $(lerp_test_depends)

.PHONY: lerp_test_re
lerp_test_re: lerp_test_clean
lerp_test_re: lerp_test_all

.PHONY: lerp_test_run_all
lerp_test_run_all: lerp_test_all ## build and run static lerp_test
lerp_test_run_all: $(lerp_test_child_run_targets)
ifneq ($(lerp_test_objects),)
lerp_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(lerp_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(lerp_test_install_path_static)
endif

.PHONY: lerp_test_run
lerp_test_run: lerp_test_all
ifneq ($(lerp_test_objects),)
lerp_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(lerp_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(lerp_test_install_path_static)
endif

-include $(lerp_test_depends)
