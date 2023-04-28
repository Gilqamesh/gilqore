v4_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
v4_test_name_curdir          := $(notdir $(patsubst %/,%,$(v4_test_path_curdir)))
v4_test_child_makefiles      := $(wildcard $(v4_test_path_curdir)*/*mk)
v4_test_names                := $(basename $(notdir $(v4_test_child_makefiles)))
v4_test_all_targets          := $(foreach v4_test,$(v4_test_names),$(v4_test)_all)
v4_test_clean_targets        := $(foreach v4_test,$(v4_test_names),$(v4_test)_clean)
v4_test_run_targets          := $(foreach v4_test,$(v4_test_names),$(v4_test)_run)
v4_test_install_path_static  := $(v4_test_path_curdir)$(v4_test_name_curdir)_static$(EXT_EXE)
v4_test_install_path_shared  := $(v4_test_path_curdir)$(v4_test_name_curdir)_shared$(EXT_EXE)
v4_test_sources              := $(wildcard $(v4_test_path_curdir)*.c)
v4_test_objects              := $(patsubst %.c, %.o, $(v4_test_sources))
v4_test_depends              := $(patsubst %.c, %.d, $(v4_test_sources))
v4_test_libdepend_target     := $(v4_test_name_curdir)_all test_framework_all
v4_test_libdepend_static     := $(PATH_INSTALL)/$(v4_test_name_curdir)$(EXT_LIB_STATIC)
v4_test_libdepend_shared     := $(PATH_INSTALL)/lib$(v4_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a

include $(v4_test_child_makefiles)

$(v4_test_path_curdir)%.o: $(v4_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(v4_test_install_path_static): | $(v4_test_libdepend_target)
$(v4_test_install_path_static): $(v4_test_objects) $(v4_test_libdepend_static) $(PATH_INSTALL)/test_framework.lib
	$(CC) -o $@ $(v4_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(v4_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(v4_test_install_path_shared): | $(v4_test_libdepend_target)
$(v4_test_install_path_shared): $(v4_test_objects) $(v4_test_libdepend_shared)
	$(CC) -o $@ $(v4_test_objects) -Wl,--whole-archive $(v4_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: v4_test_all
v4_test_all: $(v4_test_all_targets) ## build all v4_test tests
ifneq ($(v4_test_objects),)
v4_test_all: $(v4_test_install_path_static)
v4_test_all: $(v4_test_install_path_shared)
endif

.PHONY: v4_test_clean
v4_test_clean: $(v4_test_clean_targets) ## remove all v4_test tests
v4_test_clean:
	- $(RM) $(v4_test_install_path_static) $(v4_test_install_path_shared) $(v4_test_objects) $(v4_test_depends)

.PHONY: v4_test_run
v4_test_run: v4_test_all ## build and run static v4_test
v4_test_run: $(v4_test_run_targets)
ifneq ($(v4_test_objects),)
v4_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(v4_test_install_path_static)
endif

-include $(v4_test_depends)
