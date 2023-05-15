graphics_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
graphics_test_child_makefiles			        := $(wildcard $(graphics_test_path_curdir)*/*mk)
graphics_test_child_module_names		        := $(basename $(notdir $(graphics_test_child_makefiles)))
graphics_test_child_all_targets		        := $(foreach test_module,$(graphics_test_child_module_names),$(test_module)_all)
graphics_test_child_clean_targets		        := $(foreach test_module,$(graphics_test_child_module_names),$(test_module)_clean)
graphics_test_child_run_targets		        := $(foreach test_module,$(graphics_test_child_module_names),$(test_module)_run)
graphics_test_install_path_static		        := $(graphics_test_path_curdir)graphics_static$(EXT_EXE)
graphics_test_sources					        := $(wildcard $(graphics_test_path_curdir)*.c)
graphics_test_objects					        := $(patsubst %.c, %.o, $(graphics_test_sources))
graphics_test_depends					        := $(patsubst %.c, %.d, $(graphics_test_sources))
graphics_test_depends_modules			        := $(MODULE_LIBDEP_MODULES)
graphics_test_depends_modules			        += graphics
graphics_test_libdepend_static_objs	        := $(foreach dep_module,$(graphics_depends_modules),$($(dep_module)_static_objects))
graphics_test_libdepend_static_objs	        += $(foreach dep_module,$(graphics_test_depends_modules),$($(dep_module)_static_objects))

include $(graphics_test_child_makefiles)

$(graphics_test_path_curdir)%.o: $(graphics_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(graphics_test_install_path_static): $(graphics_test_objects) $(graphics_test_libdepend_static_objs)
	$(CC) -o $@ $(graphics_test_objects) -Wl,--allow-multiple-definition $(graphics_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: graphics_test_all
graphics_test_all: $(graphics_test_child_all_targets) ## build all graphics_test tests
ifneq ($(graphics_test_objects),)
graphics_test_all: $(graphics_test_install_path_static)
endif

.PHONY: graphics_test_clean
graphics_test_clean: $(graphics_test_child_clean_targets) ## remove all graphics_test tests
graphics_test_clean:
	- $(RM) $(graphics_test_install_path_static) $(graphics_test_objects) $(graphics_test_depends)

.PHONY: graphics_test_re
graphics_test_re: graphics_test_clean
graphics_test_re: graphics_test_all

.PHONY: graphics_test_run_all
graphics_test_run_all: graphics_test_all ## build and run static graphics_test
graphics_test_run_all: $(graphics_test_child_run_targets)
ifneq ($(graphics_test_objects),)
graphics_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(graphics_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(graphics_test_install_path_static)
endif

.PHONY: graphics_test_run
graphics_test_run: graphics_test_all
ifneq ($(graphics_test_objects),)
graphics_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(graphics_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(graphics_test_install_path_static)
endif

-include $(graphics_test_depends)
