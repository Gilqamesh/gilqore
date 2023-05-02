basic_types_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
basic_types_test_child_makefiles			        := $(wildcard $(basic_types_test_path_curdir)*/*mk)
basic_types_test_child_module_names		        := $(basename $(notdir $(basic_types_test_child_makefiles)))
basic_types_test_child_all_targets		        := $(foreach test_module,$(basic_types_test_child_module_names),$(test_module)_all)
basic_types_test_child_clean_targets		        := $(foreach test_module,$(basic_types_test_child_module_names),$(test_module)_clean)
basic_types_test_child_run_targets		        := $(foreach test_module,$(basic_types_test_child_module_names),$(test_module)_run)
basic_types_test_install_path_static		        := $(basic_types_test_path_curdir)basic_types_static$(EXT_EXE)
basic_types_test_sources					        := $(wildcard $(basic_types_test_path_curdir)*.c)
basic_types_test_objects					        := $(patsubst %.c, %.o, $(basic_types_test_sources))
basic_types_test_depends					        := $(patsubst %.c, %.d, $(basic_types_test_sources))
basic_types_test_depends_modules			        :=  basic_types test_framework
basic_types_test_libdepend_static_objs	        := $(foreach dep_module,$(basic_types_depends_modules),$($(dep_module)_static_objects))
basic_types_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(basic_types_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
basic_types_test_libdepend_static_objs	        += $(foreach dep_module,$(basic_types_test_depends_modules),$($(dep_module)_static_objects))

include $(basic_types_test_child_makefiles)

$(basic_types_test_path_curdir)%.o: $(basic_types_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(basic_types_test_install_path_static): $(basic_types_test_libdepend_static_objs)
$(basic_types_test_install_path_static): $(basic_types_test_objects)
	$(CC) -o $@ $(basic_types_test_objects) -Wl,--allow-multiple-definition $(basic_types_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: basic_types_test_all
basic_types_test_all: $(basic_types_test_child_all_targets) ## build all basic_types_test tests
ifneq ($(basic_types_test_objects),)
basic_types_test_all: $(basic_types_test_install_path_static)
endif

.PHONY: basic_types_test_clean
basic_types_test_clean: $(basic_types_test_child_clean_targets) ## remove all basic_types_test tests
basic_types_test_clean:
	- $(RM) $(basic_types_test_install_path_static) $(basic_types_test_objects) $(basic_types_test_depends)

.PHONY: basic_types_test_re
basic_types_test_re: basic_types_test_clean
basic_types_test_re: basic_types_test_all

.PHONY: basic_types_test_run
basic_types_test_run: basic_types_test_all ## build and run static basic_types_test
basic_types_test_run: $(basic_types_test_child_run_targets)
ifneq ($(basic_types_test_objects),)
basic_types_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(basic_types_test_install_path_static)
endif

-include $(basic_types_test_depends)
