math_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
math_test_child_makefiles			        := $(wildcard $(math_test_path_curdir)*/*mk)
math_test_child_module_names		        := $(basename $(notdir $(math_test_child_makefiles)))
math_test_child_all_targets		        := $(foreach test_module,$(math_test_child_module_names),$(test_module)_all)
math_test_child_clean_targets		        := $(foreach test_module,$(math_test_child_module_names),$(test_module)_clean)
math_test_child_run_targets		        := $(foreach test_module,$(math_test_child_module_names),$(test_module)_run)
math_test_install_path_static		        := $(math_test_path_curdir)math_static$(EXT_EXE)
math_test_sources					        := $(wildcard $(math_test_path_curdir)*.c)
math_test_objects					        := $(patsubst %.c, %.o, $(math_test_sources))
math_test_depends					        := $(patsubst %.c, %.d, $(math_test_sources))
math_test_depends_modules			        := 
# math_test_depends_modules			        += test_framework
math_test_depends_modules			        += math
math_test_libdepend_static_objs	        := $(foreach dep_module,$(math_depends_modules),$($(dep_module)_static_objects))
math_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(math_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
math_test_libdepend_static_objs	        += $(foreach dep_module,$(math_test_depends_modules),$($(dep_module)_static_objects))

include $(math_test_child_makefiles)

$(math_test_path_curdir)%.o: $(math_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(math_test_install_path_static): $(math_test_libdepend_static_objs)
$(math_test_install_path_static): $(math_test_objects)
	$(CC) -o $@ $(math_test_objects) -Wl,--allow-multiple-definition $(math_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: math_test_all
math_test_all: $(math_test_child_all_targets) ## build all math_test tests
ifneq ($(math_test_objects),)
math_test_all: $(math_test_install_path_static)
endif

.PHONY: math_test_clean
math_test_clean: $(math_test_child_clean_targets) ## remove all math_test tests
math_test_clean:
	- $(RM) $(math_test_install_path_static) $(math_test_objects) $(math_test_depends)

.PHONY: math_test_re
math_test_re: math_test_clean
math_test_re: math_test_all

.PHONY: math_test_run_all
math_test_run_all: math_test_all ## build and run static math_test
math_test_run_all: $(math_test_child_run_targets)
ifneq ($(math_test_objects),)
math_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(math_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(math_test_install_path_static)
endif

.PHONY: math_test_run
math_test_run: math_test_all
ifneq ($(math_test_objects),)
math_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(math_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(math_test_install_path_static)
endif

-include $(math_test_depends)
