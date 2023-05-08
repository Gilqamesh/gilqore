common_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
common_test_child_makefiles			        := $(wildcard $(common_test_path_curdir)*/*mk)
common_test_child_module_names		        := $(basename $(notdir $(common_test_child_makefiles)))
common_test_child_all_targets		        := $(foreach test_module,$(common_test_child_module_names),$(test_module)_all)
common_test_child_clean_targets		        := $(foreach test_module,$(common_test_child_module_names),$(test_module)_clean)
common_test_child_run_targets		        := $(foreach test_module,$(common_test_child_module_names),$(test_module)_run)
common_test_install_path_static		        := $(common_test_path_curdir)common_static$(EXT_EXE)
common_test_sources					        := $(wildcard $(common_test_path_curdir)*.c)
common_test_objects					        := $(patsubst %.c, %.o, $(common_test_sources))
common_test_depends					        := $(patsubst %.c, %.d, $(common_test_sources))
common_test_depends_modules			        := 
# common_test_depends_modules			        += test_framework
common_test_depends_modules			        += common
common_test_libdepend_static_objs	        := $(foreach dep_module,$(common_depends_modules),$($(dep_module)_static_objects))
common_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(common_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
common_test_libdepend_static_objs	        += $(foreach dep_module,$(common_test_depends_modules),$($(dep_module)_static_objects))

include $(common_test_child_makefiles)

$(common_test_path_curdir)%.o: $(common_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(common_test_install_path_static): $(common_test_libdepend_static_objs)
$(common_test_install_path_static): $(common_test_objects)
	$(CC) -o $@ $(common_test_objects) -Wl,--allow-multiple-definition $(common_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: common_test_all
common_test_all: $(common_test_child_all_targets) ## build all common_test tests
ifneq ($(common_test_objects),)
common_test_all: $(common_test_install_path_static)
endif

.PHONY: common_test_clean
common_test_clean: $(common_test_child_clean_targets) ## remove all common_test tests
common_test_clean:
	- $(RM) $(common_test_install_path_static) $(common_test_objects) $(common_test_depends)

.PHONY: common_test_re
common_test_re: common_test_clean
common_test_re: common_test_all

.PHONY: common_test_run_all
common_test_run_all: common_test_all ## build and run static common_test
common_test_run_all: $(common_test_child_run_targets)
ifneq ($(common_test_objects),)
common_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(common_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(common_test_install_path_static)
endif

.PHONY: common_test_run
common_test_run: common_test_all
ifneq ($(common_test_objects),)
common_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(common_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(common_test_install_path_static)
endif

-include $(common_test_depends)
