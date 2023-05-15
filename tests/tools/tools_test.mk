tools_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
tools_test_child_makefiles			        := $(wildcard $(tools_test_path_curdir)*/*mk)
tools_test_child_module_names		        := $(basename $(notdir $(tools_test_child_makefiles)))
tools_test_child_all_targets		        := $(foreach test_module,$(tools_test_child_module_names),$(test_module)_all)
tools_test_child_clean_targets		        := $(foreach test_module,$(tools_test_child_module_names),$(test_module)_clean)
tools_test_child_run_targets		        := $(foreach test_module,$(tools_test_child_module_names),$(test_module)_run)
tools_test_install_path_static		        := $(tools_test_path_curdir)tools_static$(EXT_EXE)
tools_test_sources					        := $(wildcard $(tools_test_path_curdir)*.c)
tools_test_objects					        := $(patsubst %.c, %.o, $(tools_test_sources))
tools_test_depends					        := $(patsubst %.c, %.d, $(tools_test_sources))
tools_test_depends_modules			        := $(MODULE_LIBDEP_MODULES)
tools_test_depends_modules			        += tools
tools_test_libdepend_static_objs	        := $(foreach dep_module,$(tools_depends_modules),$($(dep_module)_static_objects))
tools_test_libdepend_static_objs	        += $(foreach dep_module,$(tools_test_depends_modules),$($(dep_module)_static_objects))

include $(tools_test_child_makefiles)

$(tools_test_path_curdir)%.o: $(tools_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(tools_test_install_path_static): $(tools_test_objects) $(tools_test_libdepend_static_objs)
	$(CC) -o $@ $(tools_test_objects) -Wl,--allow-multiple-definition $(tools_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: tools_test_all
tools_test_all: $(tools_test_child_all_targets) ## build all tools_test tests
ifneq ($(tools_test_objects),)
tools_test_all: $(tools_test_install_path_static)
endif

.PHONY: tools_test_clean
tools_test_clean: $(tools_test_child_clean_targets) ## remove all tools_test tests
tools_test_clean:
	- $(RM) $(tools_test_install_path_static) $(tools_test_objects) $(tools_test_depends)

.PHONY: tools_test_re
tools_test_re: tools_test_clean
tools_test_re: tools_test_all

.PHONY: tools_test_run_all
tools_test_run_all: tools_test_all ## build and run static tools_test
tools_test_run_all: $(tools_test_child_run_targets)
ifneq ($(tools_test_objects),)
tools_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(tools_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(tools_test_install_path_static)
endif

.PHONY: tools_test_run
tools_test_run: tools_test_all
ifneq ($(tools_test_objects),)
tools_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(tools_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(tools_test_install_path_static)
endif

-include $(tools_test_depends)
