algorithms_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
algorithms_test_child_makefiles			        := $(wildcard $(algorithms_test_path_curdir)*/*mk)
algorithms_test_child_module_names		        := $(basename $(notdir $(algorithms_test_child_makefiles)))
algorithms_test_child_all_targets		        := $(foreach test_module,$(algorithms_test_child_module_names),$(test_module)_all)
algorithms_test_child_clean_targets		        := $(foreach test_module,$(algorithms_test_child_module_names),$(test_module)_clean)
algorithms_test_child_run_targets		        := $(foreach test_module,$(algorithms_test_child_module_names),$(test_module)_run)
algorithms_test_install_path_static		        := $(algorithms_test_path_curdir)algorithms_static$(EXT_EXE)
algorithms_test_sources					        := $(wildcard $(algorithms_test_path_curdir)*.c)
algorithms_test_objects					        := $(patsubst %.c, %.o, $(algorithms_test_sources))
algorithms_test_depends					        := $(patsubst %.c, %.d, $(algorithms_test_sources))
algorithms_test_depends_modules			        := 
# algorithms_test_depends_modules			        += test_framework
algorithms_test_depends_modules			        += algorithms
algorithms_test_libdepend_static_objs	        := $(foreach dep_module,$(algorithms_depends_modules),$($(dep_module)_static_objects))
algorithms_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(algorithms_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
algorithms_test_libdepend_static_objs	        += $(foreach dep_module,$(algorithms_test_depends_modules),$($(dep_module)_static_objects))

include $(algorithms_test_child_makefiles)

$(algorithms_test_path_curdir)%.o: $(algorithms_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(algorithms_test_install_path_static): $(algorithms_test_libdepend_static_objs)
$(algorithms_test_install_path_static): $(algorithms_test_objects)
	$(CC) -o $@ $(algorithms_test_objects) -Wl,--allow-multiple-definition $(algorithms_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: algorithms_test_all
algorithms_test_all: $(algorithms_test_child_all_targets) ## build all algorithms_test tests
ifneq ($(algorithms_test_objects),)
algorithms_test_all: $(algorithms_test_install_path_static)
endif

.PHONY: algorithms_test_clean
algorithms_test_clean: $(algorithms_test_child_clean_targets) ## remove all algorithms_test tests
algorithms_test_clean:
	- $(RM) $(algorithms_test_install_path_static) $(algorithms_test_objects) $(algorithms_test_depends)

.PHONY: algorithms_test_re
algorithms_test_re: algorithms_test_clean
algorithms_test_re: algorithms_test_all

.PHONY: algorithms_test_run_all
algorithms_test_run_all: algorithms_test_all ## build and run static algorithms_test
algorithms_test_run_all: $(algorithms_test_child_run_targets)
ifneq ($(algorithms_test_objects),)
algorithms_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(algorithms_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(algorithms_test_install_path_static)
endif

.PHONY: algorithms_test_run
algorithms_test_run: algorithms_test_all
ifneq ($(algorithms_test_objects),)
algorithms_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(algorithms_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(algorithms_test_install_path_static)
endif

-include $(algorithms_test_depends)
