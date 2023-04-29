mod_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
mod_test_name_curdir          := $(notdir $(patsubst %/,%,$(mod_test_path_curdir)))
mod_test_child_makefiles      := $(wildcard $(mod_test_path_curdir)*/*mk)
mod_test_names                := $(basename $(notdir $(mod_test_child_makefiles)))
mod_test_all_targets          := $(foreach mod_test,$(mod_test_names),$(mod_test)_all)
mod_test_clean_targets        := $(foreach mod_test,$(mod_test_names),$(mod_test)_clean)
mod_test_run_targets          := $(foreach mod_test,$(mod_test_names),$(mod_test)_run)
mod_test_install_path_static  := $(mod_test_path_curdir)$(mod_test_name_curdir)_static$(EXT_EXE)
mod_test_install_path_shared  := $(mod_test_path_curdir)$(mod_test_name_curdir)_shared$(EXT_EXE)
mod_test_sources              := $(wildcard $(mod_test_path_curdir)*.c)
mod_test_objects              := $(patsubst %.c, %.o, $(mod_test_sources))
mod_test_depends              := $(patsubst %.c, %.d, $(mod_test_sources))
mod_test_depends_modules      := 
mod_test_libdepend_target     := $(mod_test_name_curdir)_all $(foreach module,$(mod_test_depends_modules),$(module)_all) test_framework_all
mod_test_libdepend_static     := $(PATH_INSTALL)/$(mod_test_name_curdir)$(EXT_LIB_STATIC)
mod_test_libdepend_static     += $(foreach module_base,$(mod_test_depends_modules),$(PATH_INSTALL)/$(module_base)$(EXT_LIB_STATIC))
mod_test_libdepend_shared     := $(PATH_INSTALL)/lib$(mod_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a
mod_test_libdepend_shared     += $(foreach module_base,$(mod_test_depends_modules),$(PATH_INSTALL)/lib$(module_base)dll.a)

include $(mod_test_child_makefiles)

$(mod_test_path_curdir)%.o: $(mod_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(mod_test_install_path_static): | $(mod_test_libdepend_target)
$(mod_test_install_path_static): $(mod_test_objects)
	$(CC) -o $@ $(mod_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(mod_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(mod_test_install_path_shared): | $(mod_test_libdepend_target)
$(mod_test_install_path_shared): $(mod_test_objects)
	$(CC) -o $@ $(mod_test_objects) -Wl,--whole-archive $(mod_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: mod_test_all
mod_test_all: $(mod_test_all_targets) ## build all mod_test tests
ifneq ($(mod_test_objects),)
mod_test_all: $(mod_test_install_path_static)
mod_test_all: $(mod_test_install_path_shared)
endif

.PHONY: mod_test_clean
mod_test_clean: $(mod_test_clean_targets) ## remove all mod_test tests
mod_test_clean:
	- $(RM) $(mod_test_install_path_static) $(mod_test_install_path_shared) $(mod_test_objects) $(mod_test_depends)

.PHONY: mod_test_re
mod_test_re: mod_test_clean
mod_test_re: mod_test_all

.PHONY: mod_test_run
mod_test_run: mod_test_all ## build and run static mod_test
mod_test_run: $(mod_test_run_targets)
ifneq ($(mod_test_objects),)
mod_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(mod_test_install_path_static)
endif

-include $(mod_test_depends)
