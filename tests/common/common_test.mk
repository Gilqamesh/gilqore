common_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
common_test_name_curdir          := $(notdir $(patsubst %/,%,$(common_test_path_curdir)))
common_test_child_makefiles      := $(wildcard $(common_test_path_curdir)*/*mk)
common_test_names                := $(basename $(notdir $(common_test_child_makefiles)))
common_test_all_targets          := $(foreach common_test,$(common_test_names),$(common_test)_all)
common_test_clean_targets        := $(foreach common_test,$(common_test_names),$(common_test)_clean)
common_test_run_targets          := $(foreach common_test,$(common_test_names),$(common_test)_run)
common_test_install_path_static  := $(common_test_path_curdir)$(common_test_name_curdir)_static$(EXT_EXE)
common_test_install_path_shared  := $(common_test_path_curdir)$(common_test_name_curdir)_shared$(EXT_EXE)
common_test_sources              := $(wildcard $(common_test_path_curdir)*.c)
common_test_objects              := $(patsubst %.c, %.o, $(common_test_sources))
common_test_depends              := $(patsubst %.c, %.d, $(common_test_sources))
common_test_depends_modules      := 
common_test_libdepend_target     := $(common_test_name_curdir)_all $(foreach module,$(common_test_depends_modules),$(module)_all) test_framework_all
common_test_libdepend_static     := $(PATH_INSTALL)/$(common_test_name_curdir)$(EXT_LIB_STATIC)
common_test_libdepend_static     += $(foreach module_base,$(common_test_depends_modules),$(PATH_INSTALL)/$(module_base)$(EXT_LIB_STATIC))
common_test_libdepend_shared     := $(PATH_INSTALL)/lib$(common_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a
common_test_libdepend_shared     += $(foreach module_base,$(common_test_depends_modules),$(PATH_INSTALL)/lib$(module_base)dll.a)

include $(common_test_child_makefiles)

$(common_test_path_curdir)%.o: $(common_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(common_test_install_path_static): | $(common_test_libdepend_target)
$(common_test_install_path_static): $(common_test_objects)
	$(CC) -o $@ $(common_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(common_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(common_test_install_path_shared): | $(common_test_libdepend_target)
$(common_test_install_path_shared): $(common_test_objects)
	$(CC) -o $@ $(common_test_objects) -Wl,--whole-archive $(common_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: common_test_all
common_test_all: $(common_test_all_targets) ## build all common_test tests
ifneq ($(common_test_objects),)
common_test_all: $(common_test_install_path_static)
common_test_all: $(common_test_install_path_shared)
endif

.PHONY: common_test_clean
common_test_clean: $(common_test_clean_targets) ## remove all common_test tests
common_test_clean:
	- $(RM) $(common_test_install_path_static) $(common_test_install_path_shared) $(common_test_objects) $(common_test_depends)

.PHONY: common_test_re
common_test_re: common_test_clean
common_test_re: common_test_all

.PHONY: common_test_run
common_test_run: common_test_all ## build and run static common_test
common_test_run: $(common_test_run_targets)
ifneq ($(common_test_objects),)
common_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(common_test_install_path_static)
endif

-include $(common_test_depends)
