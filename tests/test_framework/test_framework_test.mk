test_framework_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
test_framework_test_name_curdir          := $(notdir $(patsubst %/,%,$(test_framework_test_path_curdir)))
test_framework_test_child_makefiles      := $(wildcard $(test_framework_test_path_curdir)*/*mk)
test_framework_test_names                := $(basename $(notdir $(test_framework_test_child_makefiles)))
test_framework_test_all_targets          := $(foreach test_framework_test,$(test_framework_test_names),$(test_framework_test)_all)
test_framework_test_clean_targets        := $(foreach test_framework_test,$(test_framework_test_names),$(test_framework_test)_clean)
test_framework_test_run_targets          := $(foreach test_framework_test,$(test_framework_test_names),$(test_framework_test)_run)
test_framework_test_install_path_static  := $(test_framework_test_path_curdir)$(test_framework_test_name_curdir)_static$(EXT_EXE)
test_framework_test_install_path_shared  := $(test_framework_test_path_curdir)$(test_framework_test_name_curdir)_shared$(EXT_EXE)
test_framework_test_sources              := $(wildcard $(test_framework_test_path_curdir)*.c)
test_framework_test_objects              := $(patsubst %.c, %.o, $(test_framework_test_sources))
test_framework_test_depends              := $(patsubst %.c, %.d, $(test_framework_test_sources))
test_framework_test_depends_modules      := 
test_framework_test_libdepend_target     := $(test_framework_test_name_curdir)_all $(foreach module,$(test_framework_test_depends_modules),$(module)_all) test_framework_all
test_framework_test_libdepend_static     := $(PATH_INSTALL)/$(test_framework_test_name_curdir)$(EXT_LIB_STATIC)
test_framework_test_libdepend_static     += $(foreach module_base,$(test_framework_test_depends_modules),$(PATH_INSTALL)/$(module_base)$(EXT_LIB_STATIC))
test_framework_test_libdepend_shared     := $(PATH_INSTALL)/lib$(test_framework_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a
test_framework_test_libdepend_shared     += $(foreach module_base,$(test_framework_test_depends_modules),$(PATH_INSTALL)/lib$(module_base)dll.a)

include $(test_framework_test_child_makefiles)

$(test_framework_test_path_curdir)%.o: $(test_framework_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(test_framework_test_install_path_static): | $(test_framework_test_libdepend_target)
$(test_framework_test_install_path_static): $(test_framework_test_objects)
	$(CC) -o $@ $(test_framework_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(test_framework_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(test_framework_test_install_path_shared): | $(test_framework_test_libdepend_target)
$(test_framework_test_install_path_shared): $(test_framework_test_objects)
	$(CC) -o $@ $(test_framework_test_objects) -Wl,--whole-archive $(test_framework_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: test_framework_test_all
test_framework_test_all: $(test_framework_test_all_targets) ## build all test_framework_test tests
ifneq ($(test_framework_test_objects),)
test_framework_test_all: $(test_framework_test_install_path_static)
test_framework_test_all: $(test_framework_test_install_path_shared)
endif

.PHONY: test_framework_test_clean
test_framework_test_clean: $(test_framework_test_clean_targets) ## remove all test_framework_test tests
test_framework_test_clean:
	- $(RM) $(test_framework_test_install_path_static) $(test_framework_test_install_path_shared) $(test_framework_test_objects) $(test_framework_test_depends)

.PHONY: test_framework_test_re
test_framework_test_re: test_framework_test_clean
test_framework_test_re: test_framework_test_all

.PHONY: test_framework_test_run
test_framework_test_run: test_framework_test_all ## build and run static test_framework_test
test_framework_test_run: $(test_framework_test_run_targets)
ifneq ($(test_framework_test_objects),)
test_framework_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(test_framework_test_install_path_static)
endif

-include $(test_framework_test_depends)
