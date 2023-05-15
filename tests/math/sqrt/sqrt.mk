sqrt_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
sqrt_test_child_makefiles			        := $(wildcard $(sqrt_test_path_curdir)*/*mk)
sqrt_test_child_module_names		        := $(basename $(notdir $(sqrt_test_child_makefiles)))
sqrt_test_child_all_targets		        := $(foreach test_module,$(sqrt_test_child_module_names),$(test_module)_all)
sqrt_test_child_clean_targets		        := $(foreach test_module,$(sqrt_test_child_module_names),$(test_module)_clean)
sqrt_test_child_run_targets		        := $(foreach test_module,$(sqrt_test_child_module_names),$(test_module)_run)
sqrt_test_install_path_static		        := $(sqrt_test_path_curdir)sqrt_static$(EXT_EXE)
sqrt_test_sources					        := $(wildcard $(sqrt_test_path_curdir)*.c)
sqrt_test_objects					        := $(patsubst %.c, %.o, $(sqrt_test_sources))
sqrt_test_depends					        := $(patsubst %.c, %.d, $(sqrt_test_sources))
sqrt_test_depends_modules			        := 
sqrt_test_depends_modules			        += sqrt
sqrt_test_libdepend_static_objs	        := $(foreach dep_module,$(sqrt_depends_modules),$($(dep_module)_static_objects))
sqrt_test_libdepend_static_objs	        += $(foreach dep_module,$(sqrt_test_depends_modules),$($(dep_module)_static_objects))

include $(sqrt_test_child_makefiles)

$(sqrt_test_path_curdir)%.o: $(sqrt_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(sqrt_test_install_path_static): $(sqrt_test_objects) $(sqrt_test_libdepend_static_objs)
	$(CC) -o $@ $(sqrt_test_objects) -Wl,--allow-multiple-definition $(sqrt_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: sqrt_test_all
sqrt_test_all: $(sqrt_test_child_all_targets) ## build all sqrt_test tests
ifneq ($(sqrt_test_objects),)
sqrt_test_all: $(sqrt_test_install_path_static)
endif

.PHONY: sqrt_test_clean
sqrt_test_clean: $(sqrt_test_child_clean_targets) ## remove all sqrt_test tests
sqrt_test_clean:
	- $(RM) $(sqrt_test_install_path_static) $(sqrt_test_objects) $(sqrt_test_depends)

.PHONY: sqrt_test_re
sqrt_test_re: sqrt_test_clean
sqrt_test_re: sqrt_test_all

.PHONY: sqrt_test_run_all
sqrt_test_run_all: sqrt_test_all ## build and run static sqrt_test
sqrt_test_run_all: $(sqrt_test_child_run_targets)
ifneq ($(sqrt_test_objects),)
sqrt_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(sqrt_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(sqrt_test_install_path_static)
endif

.PHONY: sqrt_test_run
sqrt_test_run: sqrt_test_all
ifneq ($(sqrt_test_objects),)
sqrt_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(sqrt_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(sqrt_test_install_path_static)
endif

-include $(sqrt_test_depends)
