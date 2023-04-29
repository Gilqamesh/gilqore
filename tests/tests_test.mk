tests_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
tests_test_name_curdir          := $(notdir $(patsubst %/,%,$(tests_test_path_curdir)))
tests_test_child_makefiles      := $(wildcard $(tests_test_path_curdir)*/*mk)
tests_test_names                := $(basename $(notdir $(tests_test_child_makefiles)))
tests_test_all_targets          := $(foreach tests_test,$(tests_test_names),$(tests_test)_all)
tests_test_clean_targets        := $(foreach tests_test,$(tests_test_names),$(tests_test)_clean)
tests_test_run_targets          := $(foreach tests_test,$(tests_test_names),$(tests_test)_run)
tests_test_install_path_static  := $(tests_test_path_curdir)$(tests_test_name_curdir)_static$(EXT_EXE)
tests_test_install_path_shared  := $(tests_test_path_curdir)$(tests_test_name_curdir)_shared$(EXT_EXE)
tests_test_sources              := $(wildcard $(tests_test_path_curdir)*.c)
tests_test_objects              := $(patsubst %.c, %.o, $(tests_test_sources))
tests_test_depends              := $(patsubst %.c, %.d, $(tests_test_sources))
tests_test_depends_modules      := 
tests_test_libdepend_target     := $(tests_test_name_curdir)_all $(foreach module,$(tests_test_depends_modules),$(module)_all) test_framework_all
tests_test_libdepend_static     := $(PATH_INSTALL)/$(tests_test_name_curdir)$(EXT_LIB_STATIC)
tests_test_libdepend_static     += $(foreach module_base,$(tests_test_depends_modules),$(PATH_INSTALL)/$(module_base)$(EXT_LIB_STATIC))
tests_test_libdepend_shared     := $(PATH_INSTALL)/lib$(tests_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a
tests_test_libdepend_shared     += $(foreach module_base,$(tests_test_depends_modules),$(PATH_INSTALL)/lib$(module_base)dll.a)

include $(tests_test_child_makefiles)

$(tests_test_path_curdir)%.o: $(tests_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(tests_test_install_path_static): | $(tests_test_libdepend_target)
$(tests_test_install_path_static): $(tests_test_objects)
	$(CC) -o $@ $(tests_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(tests_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(tests_test_install_path_shared): | $(tests_test_libdepend_target)
$(tests_test_install_path_shared): $(tests_test_objects)
	$(CC) -o $@ $(tests_test_objects) -Wl,--whole-archive $(tests_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: tests_test_all
tests_test_all: $(tests_test_all_targets) ## build all tests_test tests
ifneq ($(tests_test_objects),)
tests_test_all: $(tests_test_install_path_static)
tests_test_all: $(tests_test_install_path_shared)
endif

.PHONY: tests_test_clean
tests_test_clean: $(tests_test_clean_targets) ## remove all tests_test tests
tests_test_clean:
	- $(RM) $(tests_test_install_path_static) $(tests_test_install_path_shared) $(tests_test_objects) $(tests_test_depends)

.PHONY: tests_test_re
tests_test_re: tests_test_clean
tests_test_re: tests_test_all

.PHONY: tests_test_run
tests_test_run: tests_test_all ## build and run static tests_test
tests_test_run: $(tests_test_run_targets)
ifneq ($(tests_test_objects),)
tests_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(tests_test_install_path_static)
endif

-include $(tests_test_depends)
