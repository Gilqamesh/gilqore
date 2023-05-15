v3_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
v3_test_child_makefiles			        := $(wildcard $(v3_test_path_curdir)*/*mk)
v3_test_child_module_names		        := $(basename $(notdir $(v3_test_child_makefiles)))
v3_test_child_all_targets		        := $(foreach test_module,$(v3_test_child_module_names),$(test_module)_all)
v3_test_child_clean_targets		        := $(foreach test_module,$(v3_test_child_module_names),$(test_module)_clean)
v3_test_child_run_targets		        := $(foreach test_module,$(v3_test_child_module_names),$(test_module)_run)
v3_test_install_path_static		        := $(v3_test_path_curdir)v3_static$(EXT_EXE)
v3_test_sources					        := $(wildcard $(v3_test_path_curdir)*.c)
v3_test_objects					        := $(patsubst %.c, %.o, $(v3_test_sources))
v3_test_depends					        := $(patsubst %.c, %.d, $(v3_test_sources))
v3_test_depends_modules			        := $(MODULE_LIBDEP_MODULES)
v3_test_depends_modules			        += v3
v3_test_libdepend_static_objs	        := $(foreach dep_module,$(v3_depends_modules),$($(dep_module)_static_objects))
v3_test_libdepend_static_objs	        += $(foreach dep_module,$(v3_test_depends_modules),$($(dep_module)_static_objects))

include $(v3_test_child_makefiles)

$(v3_test_path_curdir)%.o: $(v3_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(v3_test_install_path_static): $(v3_test_objects) $(v3_test_libdepend_static_objs)
	$(CC) -o $@ $(v3_test_objects) -Wl,--allow-multiple-definition $(v3_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: v3_test_all
v3_test_all: $(v3_test_child_all_targets) ## build all v3_test tests
ifneq ($(v3_test_objects),)
v3_test_all: $(v3_test_install_path_static)
endif

.PHONY: v3_test_clean
v3_test_clean: $(v3_test_child_clean_targets) ## remove all v3_test tests
v3_test_clean:
	- $(RM) $(v3_test_install_path_static) $(v3_test_objects) $(v3_test_depends)

.PHONY: v3_test_re
v3_test_re: v3_test_clean
v3_test_re: v3_test_all

.PHONY: v3_test_run_all
v3_test_run_all: v3_test_all ## build and run static v3_test
v3_test_run_all: $(v3_test_child_run_targets)
ifneq ($(v3_test_objects),)
v3_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(v3_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(v3_test_install_path_static)
endif

.PHONY: v3_test_run
v3_test_run: v3_test_all
ifneq ($(v3_test_objects),)
v3_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(v3_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(v3_test_install_path_static)
endif

-include $(v3_test_depends)
