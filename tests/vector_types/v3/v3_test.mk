v3_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
v3_test_name_curdir          := $(notdir $(patsubst %/,%,$(v3_test_path_curdir)))
v3_test_child_makefiles      := $(wildcard $(v3_test_path_curdir)*/*mk)
v3_test_names                := $(basename $(notdir $(v3_test_child_makefiles)))
v3_test_all_targets          := $(foreach v3_test,$(v3_test_names),$(v3_test)_all)
v3_test_clean_targets        := $(foreach v3_test,$(v3_test_names),$(v3_test)_clean)
v3_test_run_targets          := $(foreach v3_test,$(v3_test_names),$(v3_test)_run)
v3_test_install_path_static  := $(v3_test_path_curdir)$(v3_test_name_curdir)_static$(EXT_EXE)
v3_test_install_path_shared  := $(v3_test_path_curdir)$(v3_test_name_curdir)_shared$(EXT_EXE)
v3_test_sources              := $(wildcard $(v3_test_path_curdir)*.c)
v3_test_objects              := $(patsubst %.c, %.o, $(v3_test_sources))
v3_test_depends              := $(patsubst %.c, %.d, $(v3_test_sources))
v3_test_libdepend_target     := $(v3_test_name_curdir)_all test_framework_all
v3_test_libdepend_static     := $(PATH_INSTALL)/$(v3_test_name_curdir)$(EXT_LIB_STATIC)
v3_test_libdepend_shared     := $(PATH_INSTALL)/lib$(v3_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a

include $(v3_test_child_makefiles)

$(v3_test_path_curdir)%.o: $(v3_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(v3_test_install_path_static): | $(v3_test_libdepend_target)
$(v3_test_install_path_static): $(v3_test_objects) $(v3_test_libdepend_static) $(PATH_INSTALL)/test_framework.lib
	$(CC) -o $@ $(v3_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(v3_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(v3_test_install_path_shared): | $(v3_test_libdepend_target)
$(v3_test_install_path_shared): $(v3_test_objects) $(v3_test_libdepend_shared)
	$(CC) -o $@ $(v3_test_objects) -Wl,--whole-archive $(v3_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: v3_test_all
v3_test_all: $(v3_test_all_targets) ## build all v3_test tests
ifneq ($(v3_test_objects),)
v3_test_all: $(v3_test_install_path_static)
v3_test_all: $(v3_test_install_path_shared)
endif

.PHONY: v3_test_clean
v3_test_clean: $(v3_test_clean_targets) ## remove all v3_test tests
v3_test_clean:
	- $(RM) $(v3_test_install_path_static) $(v3_test_install_path_shared) $(v3_test_objects) $(v3_test_depends)

.PHONY: v3_test_run
v3_test_run: v3_test_all ## build and run static v3_test
v3_test_run: $(v3_test_run_targets)
ifneq ($(v3_test_objects),)
v3_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(v3_test_install_path_static)
endif

-include $(v3_test_depends)
