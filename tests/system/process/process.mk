process_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
process_test_child_makefiles			        := $(wildcard $(process_test_path_curdir)*/*mk)
process_test_child_module_names		        := $(basename $(notdir $(process_test_child_makefiles)))
process_test_child_all_targets		        := $(foreach test_module,$(process_test_child_module_names),$(test_module)_all)
process_test_child_clean_targets		        := $(foreach test_module,$(process_test_child_module_names),$(test_module)_clean)
process_test_child_run_targets		        := $(foreach test_module,$(process_test_child_module_names),$(test_module)_run)
process_test_install_path_static		        := $(process_test_path_curdir)process_static$(EXT_EXE)
process_test_sources					        := $(wildcard $(process_test_path_curdir)*.c)
process_test_objects					        := $(patsubst %.c, %.o, $(process_test_sources))
process_test_depends					        := $(patsubst %.c, %.d, $(process_test_sources))
process_test_depends_modules			        := 
process_test_depends_modules			        += process
process_test_libdepend_static_objs	        := $(foreach dep_module,$(process_depends_modules),$($(dep_module)_static_objects))
process_test_libdepend_static_objs	        += $(foreach dep_module,$(process_test_depends_modules),$($(dep_module)_static_objects))

include $(process_test_child_makefiles)

$(process_test_path_curdir)%.o: $(process_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(process_test_install_path_static): $(process_test_objects) $(process_test_libdepend_static_objs)
	$(CC) -o $@ $(process_test_objects) -Wl,--allow-multiple-definition $(process_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: process_test_all
process_test_all: $(process_test_child_all_targets) ## build all process_test tests
ifneq ($(process_test_objects),)
process_test_all: $(process_test_install_path_static)
endif

.PHONY: process_test_clean
process_test_clean: $(process_test_child_clean_targets) ## remove all process_test tests
process_test_clean:
	- $(RM) $(process_test_install_path_static) $(process_test_objects) $(process_test_depends)

.PHONY: process_test_re
process_test_re: process_test_clean
process_test_re: process_test_all

.PHONY: process_test_run_all
process_test_run_all: process_test_all ## build and run static process_test
process_test_run_all: $(process_test_child_run_targets)
ifneq ($(process_test_objects),)
process_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(process_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(process_test_install_path_static)
endif

.PHONY: process_test_run
process_test_run: process_test_all
ifneq ($(process_test_objects),)
process_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(process_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(process_test_install_path_static)
endif

-include $(process_test_depends)
