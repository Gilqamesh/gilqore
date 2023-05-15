modules_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
modules_test_child_makefiles			        := $(wildcard $(modules_test_path_curdir)*/*mk)
modules_test_child_module_names		        := $(basename $(notdir $(modules_test_child_makefiles)))
modules_test_child_all_targets		        := $(foreach test_module,$(modules_test_child_module_names),$(test_module)_all)
modules_test_child_clean_targets		        := $(foreach test_module,$(modules_test_child_module_names),$(test_module)_clean)
modules_test_child_run_targets		        := $(foreach test_module,$(modules_test_child_module_names),$(test_module)_run)
modules_test_install_path_static		        := $(modules_test_path_curdir)modules_static$(EXT_EXE)
modules_test_sources					        := $(wildcard $(modules_test_path_curdir)*.c)
modules_test_objects					        := $(patsubst %.c, %.o, $(modules_test_sources))
modules_test_depends					        := $(patsubst %.c, %.d, $(modules_test_sources))
modules_test_depends_modules			        := 
modules_test_depends_modules			        += modules
modules_test_libdepend_static_objs	        := $(foreach dep_module,$(modules_depends_modules),$($(dep_module)_static_objects))
modules_test_libdepend_static_objs	        += $(foreach dep_module,$(modules_test_depends_modules),$($(dep_module)_static_objects))

include $(modules_test_child_makefiles)

$(modules_test_path_curdir)%.o: $(modules_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(modules_test_install_path_static): $(modules_test_objects) $(modules_test_libdepend_static_objs)
	$(CC) -o $@ $(modules_test_objects) -Wl,--allow-multiple-definition $(modules_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: modules_test_all
modules_test_all: $(modules_test_child_all_targets) ## build all modules_test tests
ifneq ($(modules_test_objects),)
modules_test_all: $(modules_test_install_path_static)
endif

.PHONY: modules_test_clean
modules_test_clean: $(modules_test_child_clean_targets) ## remove all modules_test tests
modules_test_clean:
	- $(RM) $(modules_test_install_path_static) $(modules_test_objects) $(modules_test_depends)

.PHONY: modules_test_re
modules_test_re: modules_test_clean
modules_test_re: modules_test_all

.PHONY: modules_test_run_all
modules_test_run_all: modules_test_all ## build and run static modules_test
modules_test_run_all: $(modules_test_child_run_targets)
ifneq ($(modules_test_objects),)
modules_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(modules_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(modules_test_install_path_static)
endif

.PHONY: modules_test_run
modules_test_run: modules_test_all
ifneq ($(modules_test_objects),)
modules_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(modules_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(modules_test_install_path_static)
endif

-include $(modules_test_depends)
