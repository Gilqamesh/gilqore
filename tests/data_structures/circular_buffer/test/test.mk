test_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
test_test_child_makefiles			        := $(wildcard $(test_test_path_curdir)*/*mk)
test_test_child_module_names		        := $(basename $(notdir $(test_test_child_makefiles)))
test_test_child_all_targets		        := $(foreach test_module,$(test_test_child_module_names),$(test_module)_all)
test_test_child_clean_targets		        := $(foreach test_module,$(test_test_child_module_names),$(test_module)_clean)
test_test_child_run_targets		        := $(foreach test_module,$(test_test_child_module_names),$(test_module)_run)
test_test_install_path_static		        := $(test_test_path_curdir)test_static$(EXT_EXE)
test_test_sources					        := $(wildcard $(test_test_path_curdir)*.c)
test_test_objects					        := $(patsubst %.c, %.o, $(test_test_sources))
test_test_depends					        := $(patsubst %.c, %.d, $(test_test_sources))
test_test_depends_modules			        := 
test_test_depends_modules			        += test
test_test_libdepend_static_objs	        := $(foreach dep_module,$(test_depends_modules),$($(dep_module)_static_objects))
test_test_libdepend_static_objs	        += $(foreach dep_module,$(test_test_depends_modules),$($(dep_module)_static_objects))

include $(test_test_child_makefiles)

$(test_test_path_curdir)%.o: $(test_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(test_test_install_path_static): $(test_test_objects) $(test_test_libdepend_static_objs)
	$(CC) -o $@ $(test_test_objects) -Wl,--allow-multiple-definition $(test_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: test_test_all
test_test_all: $(test_test_child_all_targets) ## build all test_test tests
ifneq ($(test_test_objects),)
test_test_all: $(test_test_install_path_static)
endif

.PHONY: test_test_clean
test_test_clean: $(test_test_child_clean_targets) ## remove all test_test tests
test_test_clean:
	- $(RM) $(test_test_install_path_static) $(test_test_objects) $(test_test_depends)

.PHONY: test_test_re
test_test_re: test_test_clean
test_test_re: test_test_all

.PHONY: test_test_run_all
test_test_run_all: test_test_all ## build and run static test_test
test_test_run_all: $(test_test_child_run_targets)
ifneq ($(test_test_objects),)
test_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(test_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(test_test_install_path_static)
endif

.PHONY: test_test_run
test_test_run: test_test_all
ifneq ($(test_test_objects),)
test_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(test_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(test_test_install_path_static)
endif

-include $(test_test_depends)
