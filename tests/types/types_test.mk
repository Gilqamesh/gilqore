types_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
types_test_child_makefiles			        := $(wildcard $(types_test_path_curdir)*/*mk)
types_test_child_module_names		        := $(basename $(notdir $(types_test_child_makefiles)))
types_test_child_all_targets		        := $(foreach test_module,$(types_test_child_module_names),$(test_module)_all)
types_test_child_clean_targets		        := $(foreach test_module,$(types_test_child_module_names),$(test_module)_clean)
types_test_child_run_targets		        := $(foreach test_module,$(types_test_child_module_names),$(test_module)_run)
types_test_install_path_static		        := $(types_test_path_curdir)types_static$(EXT_EXE)
types_test_sources					        := $(wildcard $(types_test_path_curdir)*.c)
types_test_objects					        := $(patsubst %.c, %.o, $(types_test_sources))
types_test_depends					        := $(patsubst %.c, %.d, $(types_test_sources))
types_test_depends_modules			        :=  types test_framework
types_test_libdepend_static_objs	        := $(foreach dep_module,$(types_depends_modules),$($(dep_module)_static_objects))
types_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(types_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
types_test_libdepend_static_objs	        += $(foreach dep_module,$(types_test_depends_modules),$($(dep_module)_static_objects))

include $(types_test_child_makefiles)

$(types_test_path_curdir)%.o: $(types_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(types_test_install_path_static): $(types_test_libdepend_static_objs)
$(types_test_install_path_static): $(types_test_objects)
	$(CC) -o $@ $(types_test_objects) -Wl,--allow-multiple-definition $(types_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: types_test_all
types_test_all: $(types_test_child_all_targets) ## build all types_test tests
ifneq ($(types_test_objects),)
types_test_all: $(types_test_install_path_static)
endif

.PHONY: types_test_clean
types_test_clean: $(types_test_child_clean_targets) ## remove all types_test tests
types_test_clean:
	- $(RM) $(types_test_install_path_static) $(types_test_objects) $(types_test_depends)

.PHONY: types_test_re
types_test_re: types_test_clean
types_test_re: types_test_all

.PHONY: types_test_run
types_test_run: types_test_all ## build and run static types_test
types_test_run: $(types_test_child_run_targets)
ifneq ($(types_test_objects),)
types_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(types_test_install_path_static)
endif

-include $(types_test_depends)
