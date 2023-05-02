color_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
color_test_child_makefiles			        := $(wildcard $(color_test_path_curdir)*/*mk)
color_test_child_module_names		        := $(basename $(notdir $(color_test_child_makefiles)))
color_test_child_all_targets		        := $(foreach test_module,$(color_test_child_module_names),$(test_module)_all)
color_test_child_clean_targets		        := $(foreach test_module,$(color_test_child_module_names),$(test_module)_clean)
color_test_child_run_targets		        := $(foreach test_module,$(color_test_child_module_names),$(test_module)_run)
color_test_install_path_static		        := $(color_test_path_curdir)color_static$(EXT_EXE)
color_test_sources					        := $(wildcard $(color_test_path_curdir)*.c)
color_test_objects					        := $(patsubst %.c, %.o, $(color_test_sources))
color_test_depends					        := $(patsubst %.c, %.d, $(color_test_sources))
color_test_depends_modules			        :=  color test_framework
color_test_libdepend_static_objs	        := $(foreach dep_module,$(color_depends_modules),$($(dep_module)_static_objects))
color_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(color_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
color_test_libdepend_static_objs	        += $(foreach dep_module,$(color_test_depends_modules),$($(dep_module)_static_objects))

include $(color_test_child_makefiles)

$(color_test_path_curdir)%.o: $(color_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(color_test_install_path_static): $(color_test_libdepend_static_objs)
$(color_test_install_path_static): $(color_test_objects)
	$(CC) -o $@ $(color_test_objects) -Wl,--allow-multiple-definition $(color_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: color_test_all
color_test_all: $(color_test_child_all_targets) ## build all color_test tests
ifneq ($(color_test_objects),)
color_test_all: $(color_test_install_path_static)
endif

.PHONY: color_test_clean
color_test_clean: $(color_test_child_clean_targets) ## remove all color_test tests
color_test_clean:
	- $(RM) $(color_test_install_path_static) $(color_test_objects) $(color_test_depends)

.PHONY: color_test_re
color_test_re: color_test_clean
color_test_re: color_test_all

.PHONY: color_test_run
color_test_run: color_test_all ## build and run static color_test
color_test_run: $(color_test_child_run_targets)
ifneq ($(color_test_objects),)
color_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(color_test_install_path_static)
endif

-include $(color_test_depends)
