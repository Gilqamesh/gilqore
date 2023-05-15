time_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
time_test_child_makefiles			        := $(wildcard $(time_test_path_curdir)*/*mk)
time_test_child_module_names		        := $(basename $(notdir $(time_test_child_makefiles)))
time_test_child_all_targets		        := $(foreach test_module,$(time_test_child_module_names),$(test_module)_all)
time_test_child_clean_targets		        := $(foreach test_module,$(time_test_child_module_names),$(test_module)_clean)
time_test_child_run_targets		        := $(foreach test_module,$(time_test_child_module_names),$(test_module)_run)
time_test_install_path_static		        := $(time_test_path_curdir)time_static$(EXT_EXE)
time_test_sources					        := $(wildcard $(time_test_path_curdir)*.c)
time_test_objects					        := $(patsubst %.c, %.o, $(time_test_sources))
time_test_depends					        := $(patsubst %.c, %.d, $(time_test_sources))
time_test_depends_modules			        := common 
time_test_depends_modules			        += time
time_test_libdepend_static_objs	        := $(foreach dep_module,$(time_depends_modules),$($(dep_module)_static_objects))
time_test_libdepend_static_objs	        += $(foreach dep_module,$(time_test_depends_modules),$($(dep_module)_static_objects))

include $(time_test_child_makefiles)

$(time_test_path_curdir)%.o: $(time_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(time_test_install_path_static): $(time_test_objects) $(time_test_libdepend_static_objs)
	$(CC) -o $@ $(time_test_objects) -Wl,--allow-multiple-definition $(time_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: time_test_all
time_test_all: $(time_test_child_all_targets) ## build all time_test tests
ifneq ($(time_test_objects),)
time_test_all: $(time_test_install_path_static)
endif

.PHONY: time_test_clean
time_test_clean: $(time_test_child_clean_targets) ## remove all time_test tests
time_test_clean:
	- $(RM) $(time_test_install_path_static) $(time_test_objects) $(time_test_depends)

.PHONY: time_test_re
time_test_re: time_test_clean
time_test_re: time_test_all

.PHONY: time_test_run_all
time_test_run_all: time_test_all ## build and run static time_test
time_test_run_all: $(time_test_child_run_targets)
ifneq ($(time_test_objects),)
time_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(time_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(time_test_install_path_static)
endif

.PHONY: time_test_run
time_test_run: time_test_all
ifneq ($(time_test_objects),)
time_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(time_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(time_test_install_path_static)
endif

-include $(time_test_depends)
