compare_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
compare_test_child_makefiles			        := $(wildcard $(compare_test_path_curdir)*/*mk)
compare_test_child_module_names		        := $(basename $(notdir $(compare_test_child_makefiles)))
compare_test_child_all_targets		        := $(foreach test_module,$(compare_test_child_module_names),$(test_module)_all)
compare_test_child_clean_targets		        := $(foreach test_module,$(compare_test_child_module_names),$(test_module)_clean)
compare_test_child_run_targets		        := $(foreach test_module,$(compare_test_child_module_names),$(test_module)_run)
compare_test_install_path_static		        := $(compare_test_path_curdir)compare_static$(EXT_EXE)
compare_test_sources					        := $(wildcard $(compare_test_path_curdir)*.c)
compare_test_objects					        := $(patsubst %.c, %.o, $(compare_test_sources))
compare_test_depends					        := $(patsubst %.c, %.d, $(compare_test_sources))
compare_test_depends_modules			        := 
compare_test_depends_modules			        += compare
compare_test_libdepend_static_objs	        := $(foreach dep_module,$(compare_depends_modules),$($(dep_module)_static_objects))
compare_test_libdepend_static_objs	        += $(foreach dep_module,$(compare_test_depends_modules),$($(dep_module)_static_objects))

include $(compare_test_child_makefiles)

$(compare_test_path_curdir)%.o: $(compare_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(compare_test_install_path_static): $(compare_test_objects) $(compare_test_libdepend_static_objs)
	$(CC) -o $@ $(compare_test_objects) -Wl,--allow-multiple-definition $(compare_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: compare_test_all
compare_test_all: $(compare_test_child_all_targets) ## build all compare_test tests
ifneq ($(compare_test_objects),)
compare_test_all: $(compare_test_install_path_static)
endif

.PHONY: compare_test_clean
compare_test_clean: $(compare_test_child_clean_targets) ## remove all compare_test tests
compare_test_clean:
	- $(RM) $(compare_test_install_path_static) $(compare_test_objects) $(compare_test_depends)

.PHONY: compare_test_re
compare_test_re: compare_test_clean
compare_test_re: compare_test_all

.PHONY: compare_test_run_all
compare_test_run_all: compare_test_all ## build and run static compare_test
compare_test_run_all: $(compare_test_child_run_targets)
ifneq ($(compare_test_objects),)
compare_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(compare_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(compare_test_install_path_static)
endif

.PHONY: compare_test_run
compare_test_run: compare_test_all
ifneq ($(compare_test_objects),)
compare_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(compare_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(compare_test_install_path_static)
endif

-include $(compare_test_depends)
