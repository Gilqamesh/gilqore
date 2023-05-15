v2_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
v2_test_child_makefiles			        := $(wildcard $(v2_test_path_curdir)*/*mk)
v2_test_child_module_names		        := $(basename $(notdir $(v2_test_child_makefiles)))
v2_test_child_all_targets		        := $(foreach test_module,$(v2_test_child_module_names),$(test_module)_all)
v2_test_child_clean_targets		        := $(foreach test_module,$(v2_test_child_module_names),$(test_module)_clean)
v2_test_child_run_targets		        := $(foreach test_module,$(v2_test_child_module_names),$(test_module)_run)
v2_test_install_path_static		        := $(v2_test_path_curdir)v2_static$(EXT_EXE)
v2_test_sources					        := $(wildcard $(v2_test_path_curdir)*.c)
v2_test_objects					        := $(patsubst %.c, %.o, $(v2_test_sources))
v2_test_depends					        := $(patsubst %.c, %.d, $(v2_test_sources))
v2_test_depends_modules			        := 
v2_test_depends_modules			        += v2
v2_test_libdepend_static_objs	        := $(foreach dep_module,$(v2_depends_modules),$($(dep_module)_static_objects))
v2_test_libdepend_static_objs	        += $(foreach dep_module,$(v2_test_depends_modules),$($(dep_module)_static_objects))

include $(v2_test_child_makefiles)

$(v2_test_path_curdir)%.o: $(v2_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(v2_test_install_path_static): $(v2_test_objects) $(v2_test_libdepend_static_objs)
	$(CC) -o $@ $(v2_test_objects) -Wl,--allow-multiple-definition $(v2_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: v2_test_all
v2_test_all: $(v2_test_child_all_targets) ## build all v2_test tests
ifneq ($(v2_test_objects),)
v2_test_all: $(v2_test_install_path_static)
endif

.PHONY: v2_test_clean
v2_test_clean: $(v2_test_child_clean_targets) ## remove all v2_test tests
v2_test_clean:
	- $(RM) $(v2_test_install_path_static) $(v2_test_objects) $(v2_test_depends)

.PHONY: v2_test_re
v2_test_re: v2_test_clean
v2_test_re: v2_test_all

.PHONY: v2_test_run_all
v2_test_run_all: v2_test_all ## build and run static v2_test
v2_test_run_all: $(v2_test_child_run_targets)
ifneq ($(v2_test_objects),)
v2_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(v2_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(v2_test_install_path_static)
endif

.PHONY: v2_test_run
v2_test_run: v2_test_all
ifneq ($(v2_test_objects),)
v2_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(v2_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(v2_test_install_path_static)
endif

-include $(v2_test_depends)
