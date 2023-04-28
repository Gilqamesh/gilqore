clamp_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
clamp_test_name_curdir          := $(notdir $(patsubst %/,%,$(clamp_test_path_curdir)))
clamp_test_child_makefiles      := $(wildcard $(clamp_test_path_curdir)*/*mk)
clamp_test_names                := $(basename $(notdir $(clamp_test_child_makefiles)))
clamp_test_all_targets          := $(foreach clamp_test,$(clamp_test_names),$(clamp_test)_all)
clamp_test_clean_targets        := $(foreach clamp_test,$(clamp_test_names),$(clamp_test)_clean)
clamp_test_run_targets          := $(foreach clamp_test,$(clamp_test_names),$(clamp_test)_run)
clamp_test_install_path_static  := $(clamp_test_path_curdir)$(clamp_test_name_curdir)_static$(EXT_EXE)
clamp_test_install_path_shared  := $(clamp_test_path_curdir)$(clamp_test_name_curdir)_shared$(EXT_EXE)
clamp_test_sources              := $(wildcard $(clamp_test_path_curdir)*.c)
clamp_test_objects              := $(patsubst %.c, %.o, $(clamp_test_sources))
clamp_test_depends              := $(patsubst %.c, %.d, $(clamp_test_sources))
clamp_test_libdepend_target     := $(clamp_test_name_curdir)_all test_framework_all
clamp_test_libdepend_static     := $(PATH_INSTALL)/$(clamp_test_name_curdir)$(EXT_LIB_STATIC)
clamp_test_libdepend_shared     := $(PATH_INSTALL)/lib$(clamp_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a

include $(clamp_test_child_makefiles)

$(clamp_test_path_curdir)%.o: $(clamp_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(clamp_test_install_path_static): | $(clamp_test_libdepend_target)
$(clamp_test_install_path_static): $(clamp_test_objects) $(clamp_test_libdepend_static) $(PATH_INSTALL)/test_framework.lib
	$(CC) -o $@ $(clamp_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(clamp_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(clamp_test_install_path_shared): | $(clamp_test_libdepend_target)
$(clamp_test_install_path_shared): $(clamp_test_objects) $(clamp_test_libdepend_shared)
	$(CC) -o $@ $(clamp_test_objects) -Wl,--whole-archive $(clamp_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: clamp_test_all
clamp_test_all: $(clamp_test_all_targets) ## build all clamp_test tests
ifneq ($(clamp_test_objects),)
clamp_test_all: $(clamp_test_install_path_static)
clamp_test_all: $(clamp_test_install_path_shared)
endif

.PHONY: clamp_test_clean
clamp_test_clean: $(clamp_test_clean_targets) ## remove all clamp_test tests
clamp_test_clean:
	- $(RM) $(clamp_test_install_path_static) $(clamp_test_install_path_shared) $(clamp_test_objects) $(clamp_test_depends)

.PHONY: clamp_test_run
clamp_test_run: clamp_test_all ## build and run static clamp_test
clamp_test_run: $(clamp_test_run_targets)
ifneq ($(clamp_test_objects),)
clamp_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(clamp_test_install_path_static)
endif

-include $(clamp_test_depends)
