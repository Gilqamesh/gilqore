test_framework_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
test_framework_test_child_makefiles			        := $(wildcard $(test_framework_test_path_curdir)*/*mk)
test_framework_test_child_module_names		        := $(basename $(notdir $(test_framework_test_child_makefiles)))
test_framework_test_child_all_targets		        := $(foreach test_module,$(test_framework_test_child_module_names),$(test_module)_all)
test_framework_test_child_clean_targets		        := $(foreach test_module,$(test_framework_test_child_module_names),$(test_module)_clean)
test_framework_test_child_run_targets		        := $(foreach test_module,$(test_framework_test_child_module_names),$(test_module)_run)
test_framework_test_install_path_static		        := $(test_framework_test_path_curdir)test_framework_static$(EXT_EXE)
test_framework_test_sources					        := $(wildcard $(test_framework_test_path_curdir)*.c)
test_framework_test_objects					        := $(patsubst %.c, %.o, $(test_framework_test_sources))
test_framework_test_depends					        := $(patsubst %.c, %.d, $(test_framework_test_sources))
test_framework_test_depends_modules			        := 
# test_framework_test_depends_modules			        += test_framework
test_framework_test_depends_modules			        += test_framework
test_framework_test_libdepend_static_objs	        := $(foreach dep_module,$(test_framework_depends_modules),$($(dep_module)_static_objects))
test_framework_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(test_framework_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
test_framework_test_libdepend_static_objs	        += $(foreach dep_module,$(test_framework_test_depends_modules),$($(dep_module)_static_objects))

include $(test_framework_test_child_makefiles)

$(test_framework_test_path_curdir)%.o: $(test_framework_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(test_framework_test_install_path_static): $(test_framework_test_libdepend_static_objs)
$(test_framework_test_install_path_static): $(test_framework_test_objects)
	$(CC) -o $@ $(test_framework_test_objects) -Wl,--allow-multiple-definition $(test_framework_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: test_framework_test_all
test_framework_test_all: $(test_framework_test_child_all_targets) ## build all test_framework_test tests
ifneq ($(test_framework_test_objects),)
test_framework_test_all: $(test_framework_test_install_path_static)
endif

.PHONY: test_framework_test_clean
test_framework_test_clean: $(test_framework_test_child_clean_targets) ## remove all test_framework_test tests
test_framework_test_clean:
	- $(RM) $(test_framework_test_install_path_static) $(test_framework_test_objects) $(test_framework_test_depends)

.PHONY: test_framework_test_re
test_framework_test_re: test_framework_test_clean
test_framework_test_re: test_framework_test_all

.PHONY: test_framework_test_run_all
test_framework_test_run_all: test_framework_test_all ## build and run static test_framework_test
test_framework_test_run_all: $(test_framework_test_child_run_targets)
ifneq ($(test_framework_test_objects),)
test_framework_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(test_framework_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(test_framework_test_install_path_static)
endif

.PHONY: test_framework_test_run
test_framework_test_run: test_framework_test_all
ifneq ($(test_framework_test_objects),)
test_framework_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(test_framework_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(test_framework_test_install_path_static)
endif

-include $(test_framework_test_depends)
