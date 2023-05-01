mod_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
mod_test_child_makefiles			        := $(wildcard $(mod_test_path_curdir)*/*mk)
mod_test_child_module_names		        := $(basename $(notdir $(mod_test_child_makefiles)))
mod_test_child_all_targets		        := $(foreach test_module,$(mod_test_child_module_names),$(test_module)_all)
mod_test_child_clean_targets		        := $(foreach test_module,$(mod_test_child_module_names),$(test_module)_clean)
mod_test_child_run_targets		        := $(foreach test_module,$(mod_test_child_module_names),$(test_module)_run)
mod_test_install_path_static		        := $(mod_test_path_curdir)mod_static$(EXT_EXE)
mod_test_sources					        := $(wildcard $(mod_test_path_curdir)*.c)
mod_test_objects					        := $(patsubst %.c, %.o, $(mod_test_sources))
mod_test_depends					        := $(patsubst %.c, %.d, $(mod_test_sources))
mod_test_depends_modules			        :=  mod test_framework
mod_test_libdepend_static_objs	        := $(foreach dep_module,$(mod_depends_modules),$($(dep_module)_static_objects))
mod_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(mod_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
mod_test_libdepend_static_objs	        += $(foreach dep_module,$(mod_test_depends_modules),$($(dep_module)_static_objects))

include $(mod_test_child_makefiles)

$(mod_test_path_curdir)%.o: $(mod_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(mod_test_install_path_static): $(mod_test_libdepend_static_objs)
$(mod_test_install_path_static): $(mod_test_objects)
	$(CC) -o $@ $(mod_test_objects) -Wl,--allow-multiple-definition $(mod_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: mod_test_all
mod_test_all: $(mod_test_child_all_targets) ## build all mod_test tests
ifneq ($(mod_test_objects),)
mod_test_all: $(mod_test_install_path_static)
endif

.PHONY: mod_test_clean
mod_test_clean: $(mod_test_child_clean_targets) ## remove all mod_test tests
mod_test_clean:
	- $(RM) $(mod_test_install_path_static) $(mod_test_objects) $(mod_test_depends)

.PHONY: mod_test_re
mod_test_re: mod_test_clean
mod_test_re: mod_test_all

.PHONY: mod_test_run
mod_test_run: mod_test_all ## build and run static mod_test
mod_test_run: $(mod_test_child_run_targets)
ifneq ($(mod_test_objects),)
mod_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(mod_test_install_path_static)
endif

-include $(mod_test_depends)
