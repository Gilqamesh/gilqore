v4_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
v4_test_child_makefiles			        := $(wildcard $(v4_test_path_curdir)*/*mk)
v4_test_child_module_names		        := $(basename $(notdir $(v4_test_child_makefiles)))
v4_test_child_all_targets		        := $(foreach test_module,$(v4_test_child_module_names),$(test_module)_all)
v4_test_child_clean_targets		        := $(foreach test_module,$(v4_test_child_module_names),$(test_module)_clean)
v4_test_child_run_targets		        := $(foreach test_module,$(v4_test_child_module_names),$(test_module)_run)
v4_test_install_path_static		        := $(v4_test_path_curdir)v4_static$(EXT_EXE)
v4_test_sources					        := $(wildcard $(v4_test_path_curdir)*.c)
v4_test_objects					        := $(patsubst %.c, %.o, $(v4_test_sources))
v4_test_depends					        := $(patsubst %.c, %.d, $(v4_test_sources))
v4_test_depends_modules			        :=  v4 test_framework
v4_test_libdepend_static_objs	        := $(foreach dep_module,$(v4_depends_modules),$($(dep_module)_static_objects))
v4_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(v4_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
v4_test_libdepend_static_objs	        += $(foreach dep_module,$(v4_test_depends_modules),$($(dep_module)_static_objects))

include $(v4_test_child_makefiles)

$(v4_test_path_curdir)%.o: $(v4_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(v4_test_install_path_static): $(v4_test_libdepend_static_objs)
$(v4_test_install_path_static): $(v4_test_objects)
	$(CC) -o $@ $(v4_test_objects) -Wl,--allow-multiple-definition $(v4_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: v4_test_all
v4_test_all: $(v4_test_child_all_targets) ## build all v4_test tests
ifneq ($(v4_test_objects),)
v4_test_all: $(v4_test_install_path_static)
endif

.PHONY: v4_test_clean
v4_test_clean: $(v4_test_child_clean_targets) ## remove all v4_test tests
v4_test_clean:
	- $(RM) $(v4_test_install_path_static) $(v4_test_objects) $(v4_test_depends)

.PHONY: v4_test_re
v4_test_re: v4_test_clean
v4_test_re: v4_test_all

.PHONY: v4_test_run
v4_test_run: v4_test_all ## build and run static v4_test
v4_test_run: $(v4_test_child_run_targets)
ifneq ($(v4_test_objects),)
v4_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(v4_test_install_path_static)
endif

-include $(v4_test_depends)
