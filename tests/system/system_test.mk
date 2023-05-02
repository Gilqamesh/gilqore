system_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
system_test_child_makefiles			        := $(wildcard $(system_test_path_curdir)*/*mk)
system_test_child_module_names		        := $(basename $(notdir $(system_test_child_makefiles)))
system_test_child_all_targets		        := $(foreach test_module,$(system_test_child_module_names),$(test_module)_all)
system_test_child_clean_targets		        := $(foreach test_module,$(system_test_child_module_names),$(test_module)_clean)
system_test_child_run_targets		        := $(foreach test_module,$(system_test_child_module_names),$(test_module)_run)
system_test_install_path_static		        := $(system_test_path_curdir)system_static$(EXT_EXE)
system_test_sources					        := $(wildcard $(system_test_path_curdir)*.c)
system_test_objects					        := $(patsubst %.c, %.o, $(system_test_sources))
system_test_depends					        := $(patsubst %.c, %.d, $(system_test_sources))
system_test_depends_modules			        :=  system test_framework
system_test_libdepend_static_objs	        := $(foreach dep_module,$(system_depends_modules),$($(dep_module)_static_objects))
system_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(system_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
system_test_libdepend_static_objs	        += $(foreach dep_module,$(system_test_depends_modules),$($(dep_module)_static_objects))

include $(system_test_child_makefiles)

$(system_test_path_curdir)%.o: $(system_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(system_test_install_path_static): $(system_test_libdepend_static_objs)
$(system_test_install_path_static): $(system_test_objects)
	$(CC) -o $@ $(system_test_objects) -Wl,--allow-multiple-definition $(system_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: system_test_all
system_test_all: $(system_test_child_all_targets) ## build all system_test tests
ifneq ($(system_test_objects),)
system_test_all: $(system_test_install_path_static)
endif

.PHONY: system_test_clean
system_test_clean: $(system_test_child_clean_targets) ## remove all system_test tests
system_test_clean:
	- $(RM) $(system_test_install_path_static) $(system_test_objects) $(system_test_depends)

.PHONY: system_test_re
system_test_re: system_test_clean
system_test_re: system_test_all

.PHONY: system_test_run
system_test_run: system_test_all ## build and run static system_test
system_test_run: $(system_test_child_run_targets)
ifneq ($(system_test_objects),)
system_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(system_test_install_path_static)
endif

-include $(system_test_depends)
