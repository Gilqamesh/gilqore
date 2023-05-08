tests_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
tests_test_child_makefiles			        := $(wildcard $(tests_test_path_curdir)*/*mk)
tests_test_child_module_names		        := $(basename $(notdir $(tests_test_child_makefiles)))
tests_test_child_all_targets		        := $(foreach test_module,$(tests_test_child_module_names),$(test_module)_all)
tests_test_child_clean_targets		        := $(foreach test_module,$(tests_test_child_module_names),$(test_module)_clean)
tests_test_child_run_targets		        := $(foreach test_module,$(tests_test_child_module_names),$(test_module)_run)
tests_test_install_path_static		        := $(tests_test_path_curdir)tests_static$(EXT_EXE)
tests_test_sources					        := $(wildcard $(tests_test_path_curdir)*.c)
tests_test_objects					        := $(patsubst %.c, %.o, $(tests_test_sources))
tests_test_depends					        := $(patsubst %.c, %.d, $(tests_test_sources))
tests_test_depends_modules			        := 
# tests_test_depends_modules			        += test_framework
tests_test_depends_modules			        += tests
tests_test_libdepend_static_objs	        := $(foreach dep_module,$(tests_depends_modules),$($(dep_module)_static_objects))
tests_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(tests_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
tests_test_libdepend_static_objs	        += $(foreach dep_module,$(tests_test_depends_modules),$($(dep_module)_static_objects))

include $(tests_test_child_makefiles)

$(tests_test_path_curdir)%.o: $(tests_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(tests_test_install_path_static): $(tests_test_libdepend_static_objs)
$(tests_test_install_path_static): $(tests_test_objects)
	$(CC) -o $@ $(tests_test_objects) -Wl,--allow-multiple-definition $(tests_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: tests_test_all
tests_test_all: $(tests_test_child_all_targets) ## build all tests_test tests
ifneq ($(tests_test_objects),)
tests_test_all: $(tests_test_install_path_static)
endif

.PHONY: tests_test_clean
tests_test_clean: $(tests_test_child_clean_targets) ## remove all tests_test tests
tests_test_clean:
	- $(RM) $(tests_test_install_path_static) $(tests_test_objects) $(tests_test_depends)

.PHONY: tests_test_re
tests_test_re: tests_test_clean
tests_test_re: tests_test_all

.PHONY: tests_test_run_all
tests_test_run_all: tests_test_all ## build and run static tests_test
tests_test_run_all: $(tests_test_child_run_targets)
ifneq ($(tests_test_objects),)
tests_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(tests_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(tests_test_install_path_static)
endif

.PHONY: tests_test_run
tests_test_run: tests_test_all
ifneq ($(tests_test_objects),)
tests_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(tests_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(tests_test_install_path_static)
endif

-include $(tests_test_depends)
