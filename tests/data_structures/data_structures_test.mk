data_structures_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
data_structures_test_child_makefiles			        := $(wildcard $(data_structures_test_path_curdir)*/*mk)
data_structures_test_child_module_names		        := $(basename $(notdir $(data_structures_test_child_makefiles)))
data_structures_test_child_all_targets		        := $(foreach test_module,$(data_structures_test_child_module_names),$(test_module)_all)
data_structures_test_child_clean_targets		        := $(foreach test_module,$(data_structures_test_child_module_names),$(test_module)_clean)
data_structures_test_child_run_targets		        := $(foreach test_module,$(data_structures_test_child_module_names),$(test_module)_run)
data_structures_test_install_path_static		        := $(data_structures_test_path_curdir)data_structures_static$(EXT_EXE)
data_structures_test_sources					        := $(wildcard $(data_structures_test_path_curdir)*.c)
data_structures_test_objects					        := $(patsubst %.c, %.o, $(data_structures_test_sources))
data_structures_test_depends					        := $(patsubst %.c, %.d, $(data_structures_test_sources))
data_structures_test_depends_modules			        := 
# data_structures_test_depends_modules			        += test_framework
data_structures_test_depends_modules			        += data_structures
data_structures_test_libdepend_static_objs	        := $(foreach dep_module,$(data_structures_depends_modules),$($(dep_module)_static_objects))
data_structures_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(data_structures_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
data_structures_test_libdepend_static_objs	        += $(foreach dep_module,$(data_structures_test_depends_modules),$($(dep_module)_static_objects))

include $(data_structures_test_child_makefiles)

$(data_structures_test_path_curdir)%.o: $(data_structures_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(data_structures_test_install_path_static): $(data_structures_test_libdepend_static_objs)
$(data_structures_test_install_path_static): $(data_structures_test_objects)
	$(CC) -o $@ $(data_structures_test_objects) -Wl,--allow-multiple-definition $(data_structures_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: data_structures_test_all
data_structures_test_all: $(data_structures_test_child_all_targets) ## build all data_structures_test tests
ifneq ($(data_structures_test_objects),)
data_structures_test_all: $(data_structures_test_install_path_static)
endif

.PHONY: data_structures_test_clean
data_structures_test_clean: $(data_structures_test_child_clean_targets) ## remove all data_structures_test tests
data_structures_test_clean:
	- $(RM) $(data_structures_test_install_path_static) $(data_structures_test_objects) $(data_structures_test_depends)

.PHONY: data_structures_test_re
data_structures_test_re: data_structures_test_clean
data_structures_test_re: data_structures_test_all

.PHONY: data_structures_test_run_all
data_structures_test_run_all: data_structures_test_all ## build and run static data_structures_test
data_structures_test_run_all: $(data_structures_test_child_run_targets)
ifneq ($(data_structures_test_objects),)
data_structures_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(data_structures_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(data_structures_test_install_path_static)
endif

.PHONY: data_structures_test_run
data_structures_test_run: data_structures_test_all
ifneq ($(data_structures_test_objects),)
data_structures_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(data_structures_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(data_structures_test_install_path_static)
endif

-include $(data_structures_test_depends)
