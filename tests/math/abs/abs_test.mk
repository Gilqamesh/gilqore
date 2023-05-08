abs_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
abs_test_child_makefiles			        := $(wildcard $(abs_test_path_curdir)*/*mk)
abs_test_child_module_names		        := $(basename $(notdir $(abs_test_child_makefiles)))
abs_test_child_all_targets		        := $(foreach test_module,$(abs_test_child_module_names),$(test_module)_all)
abs_test_child_clean_targets		        := $(foreach test_module,$(abs_test_child_module_names),$(test_module)_clean)
abs_test_child_run_targets		        := $(foreach test_module,$(abs_test_child_module_names),$(test_module)_run)
abs_test_install_path_static		        := $(abs_test_path_curdir)abs_static$(EXT_EXE)
abs_test_sources					        := $(wildcard $(abs_test_path_curdir)*.c)
abs_test_objects					        := $(patsubst %.c, %.o, $(abs_test_sources))
abs_test_depends					        := $(patsubst %.c, %.d, $(abs_test_sources))
abs_test_depends_modules			        := 
# abs_test_depends_modules			        += test_framework
abs_test_depends_modules			        += abs
abs_test_libdepend_static_objs	        := $(foreach dep_module,$(abs_depends_modules),$($(dep_module)_static_objects))
abs_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(abs_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
abs_test_libdepend_static_objs	        += $(foreach dep_module,$(abs_test_depends_modules),$($(dep_module)_static_objects))

include $(abs_test_child_makefiles)

$(abs_test_path_curdir)%.o: $(abs_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(abs_test_install_path_static): $(abs_test_libdepend_static_objs)
$(abs_test_install_path_static): $(abs_test_objects)
	$(CC) -o $@ $(abs_test_objects) -Wl,--allow-multiple-definition $(abs_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: abs_test_all
abs_test_all: $(abs_test_child_all_targets) ## build all abs_test tests
ifneq ($(abs_test_objects),)
abs_test_all: $(abs_test_install_path_static)
endif

.PHONY: abs_test_clean
abs_test_clean: $(abs_test_child_clean_targets) ## remove all abs_test tests
abs_test_clean:
	- $(RM) $(abs_test_install_path_static) $(abs_test_objects) $(abs_test_depends)

.PHONY: abs_test_re
abs_test_re: abs_test_clean
abs_test_re: abs_test_all

.PHONY: abs_test_run_all
abs_test_run_all: abs_test_all ## build and run static abs_test
abs_test_run_all: $(abs_test_child_run_targets)
ifneq ($(abs_test_objects),)
abs_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(abs_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(abs_test_install_path_static)
endif

.PHONY: abs_test_run
abs_test_run: abs_test_all
ifneq ($(abs_test_objects),)
abs_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(abs_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(abs_test_install_path_static)
endif

-include $(abs_test_depends)
