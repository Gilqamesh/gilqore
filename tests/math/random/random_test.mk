random_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
random_test_child_makefiles			        := $(wildcard $(random_test_path_curdir)*/*mk)
random_test_child_module_names		        := $(basename $(notdir $(random_test_child_makefiles)))
random_test_child_all_targets		        := $(foreach test_module,$(random_test_child_module_names),$(test_module)_all)
random_test_child_clean_targets		        := $(foreach test_module,$(random_test_child_module_names),$(test_module)_clean)
random_test_child_run_targets		        := $(foreach test_module,$(random_test_child_module_names),$(test_module)_run)
random_test_install_path_static		        := $(random_test_path_curdir)random_static$(EXT_EXE)
random_test_sources					        := $(wildcard $(random_test_path_curdir)*.c)
random_test_objects					        := $(patsubst %.c, %.o, $(random_test_sources))
random_test_depends					        := $(patsubst %.c, %.d, $(random_test_sources))
random_test_depends_modules			        :=  random test_framework
random_test_libdepend_static_objs	        := $(foreach dep_module,$(random_depends_modules),$($(dep_module)_static_objects))
random_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(random_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
random_test_libdepend_static_objs	        += $(foreach dep_module,$(random_test_depends_modules),$($(dep_module)_static_objects))

include $(random_test_child_makefiles)

$(random_test_path_curdir)%.o: $(random_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(random_test_install_path_static): $(random_test_libdepend_static_objs)
$(random_test_install_path_static): $(random_test_objects)
	$(CC) -o $@ $(random_test_objects) -Wl,--allow-multiple-definition $(random_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: random_test_all
random_test_all: $(random_test_child_all_targets) ## build all random_test tests
ifneq ($(random_test_objects),)
random_test_all: $(random_test_install_path_static)
endif

.PHONY: random_test_clean
random_test_clean: $(random_test_child_clean_targets) ## remove all random_test tests
random_test_clean:
	- $(RM) $(random_test_install_path_static) $(random_test_objects) $(random_test_depends)

.PHONY: random_test_re
random_test_re: random_test_clean
random_test_re: random_test_all

.PHONY: random_test_run
random_test_run: random_test_all ## build and run static random_test
random_test_run: $(random_test_child_run_targets)
ifneq ($(random_test_objects),)
random_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(random_test_install_path_static)
endif

-include $(random_test_depends)
