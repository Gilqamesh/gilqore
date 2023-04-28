compare_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
compare_test_name_curdir          := $(notdir $(patsubst %/,%,$(compare_test_path_curdir)))
compare_test_child_makefiles      := $(wildcard $(compare_test_path_curdir)*/*mk)
compare_test_names                := $(basename $(notdir $(compare_test_child_makefiles)))
compare_test_all_targets          := $(foreach compare_test,$(compare_test_names),$(compare_test)_all)
compare_test_clean_targets        := $(foreach compare_test,$(compare_test_names),$(compare_test)_clean)
compare_test_run_targets          := $(foreach compare_test,$(compare_test_names),$(compare_test)_run)
compare_test_install_path_static  := $(compare_test_path_curdir)$(compare_test_name_curdir)_static$(EXT_EXE)
compare_test_install_path_shared  := $(compare_test_path_curdir)$(compare_test_name_curdir)_shared$(EXT_EXE)
compare_test_sources              := $(wildcard $(compare_test_path_curdir)*.c)
compare_test_objects              := $(patsubst %.c, %.o, $(compare_test_sources))
compare_test_depends              := $(patsubst %.c, %.d, $(compare_test_sources))
compare_test_libdepend_target     := $(compare_test_name_curdir)_all test_framework_all
compare_test_libdepend_static     := $(PATH_INSTALL)/$(compare_test_name_curdir)$(EXT_LIB_STATIC)
compare_test_libdepend_shared     := $(PATH_INSTALL)/lib$(compare_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a

include $(compare_test_child_makefiles)

$(compare_test_path_curdir)%.o: $(compare_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(compare_test_install_path_static): | $(compare_test_libdepend_target)
$(compare_test_install_path_static): $(compare_test_objects) $(compare_test_libdepend_static) $(PATH_INSTALL)/test_framework.lib
	$(CC) -o $@ $(compare_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(compare_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(compare_test_install_path_shared): | $(compare_test_libdepend_target)
$(compare_test_install_path_shared): $(compare_test_objects) $(compare_test_libdepend_shared)
	$(CC) -o $@ $(compare_test_objects) -Wl,--whole-archive $(compare_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: compare_test_all
compare_test_all: $(compare_test_all_targets) ## build all compare_test tests
ifneq ($(compare_test_objects),)
compare_test_all: $(compare_test_install_path_static)
compare_test_all: $(compare_test_install_path_shared)
endif

.PHONY: compare_test_clean
compare_test_clean: $(compare_test_clean_targets) ## remove all compare_test tests
compare_test_clean:
	- $(RM) $(compare_test_install_path_static) $(compare_test_install_path_shared) $(compare_test_objects) $(compare_test_depends)

.PHONY: compare_test_run
compare_test_run: compare_test_all ## build and run static compare_test
compare_test_run: $(compare_test_run_targets)
ifneq ($(compare_test_objects),)
compare_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(compare_test_install_path_static)
endif

-include $(compare_test_depends)
