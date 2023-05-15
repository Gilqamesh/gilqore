console_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
console_test_child_makefiles			        := $(wildcard $(console_test_path_curdir)*/*mk)
console_test_child_module_names		        := $(basename $(notdir $(console_test_child_makefiles)))
console_test_child_all_targets		        := $(foreach test_module,$(console_test_child_module_names),$(test_module)_all)
console_test_child_clean_targets		        := $(foreach test_module,$(console_test_child_module_names),$(test_module)_clean)
console_test_child_run_targets		        := $(foreach test_module,$(console_test_child_module_names),$(test_module)_run)
console_test_install_path_static		        := $(console_test_path_curdir)console_static$(EXT_EXE)
console_test_sources					        := $(wildcard $(console_test_path_curdir)*.c)
console_test_objects					        := $(patsubst %.c, %.o, $(console_test_sources))
console_test_depends					        := $(patsubst %.c, %.d, $(console_test_sources))
console_test_depends_modules			        := $(MODULE_LIBDEP_MODULES)
console_test_depends_modules			        += console
console_test_libdepend_static_objs	        := $(foreach dep_module,$(console_depends_modules),$($(dep_module)_static_objects))
console_test_libdepend_static_objs	        += $(foreach dep_module,$(console_test_depends_modules),$($(dep_module)_static_objects))

include $(console_test_child_makefiles)

$(console_test_path_curdir)%.o: $(console_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(console_test_install_path_static): $(console_test_objects) $(console_test_libdepend_static_objs)
	$(CC) -o $@ $(console_test_objects) -Wl,--allow-multiple-definition $(console_test_libdepend_static_objs) $(LFLAGS_COMMON) -mwindows

.PHONY: console_test_all
console_test_all: $(console_test_child_all_targets) ## build all console_test tests
ifneq ($(console_test_objects),)
console_test_all: $(console_test_install_path_static)
endif

.PHONY: console_test_clean
console_test_clean: $(console_test_child_clean_targets) ## remove all console_test tests
console_test_clean:
	- $(RM) $(console_test_install_path_static) $(console_test_objects) $(console_test_depends)

.PHONY: console_test_re
console_test_re: console_test_clean
console_test_re: console_test_all

.PHONY: console_test_run_all
console_test_run_all: console_test_all ## build and run static console_test
console_test_run_all: $(console_test_child_run_targets)
ifneq ($(console_test_objects),)
console_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(console_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(console_test_install_path_static)
endif

.PHONY: console_test_run
console_test_run: console_test_all
ifneq ($(console_test_objects),)
console_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(console_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(console_test_install_path_static)
endif

-include $(console_test_depends)
