data_structures_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
data_structures_test_name_curdir          := $(notdir $(patsubst %/,%,$(data_structures_test_path_curdir)))
data_structures_test_child_makefiles      := $(wildcard $(data_structures_test_path_curdir)*/*mk)
data_structures_test_names                := $(basename $(notdir $(data_structures_test_child_makefiles)))
data_structures_test_all_targets          := $(foreach data_structures_test,$(data_structures_test_names),$(data_structures_test)_all)
data_structures_test_clean_targets        := $(foreach data_structures_test,$(data_structures_test_names),$(data_structures_test)_clean)
data_structures_test_run_targets          := $(foreach data_structures_test,$(data_structures_test_names),$(data_structures_test)_run)
data_structures_test_install_path_static  := $(data_structures_test_path_curdir)$(data_structures_test_name_curdir)_static$(EXT_EXE)
data_structures_test_install_path_shared  := $(data_structures_test_path_curdir)$(data_structures_test_name_curdir)_shared$(EXT_EXE)
data_structures_test_sources              := $(wildcard $(data_structures_test_path_curdir)*.c)
data_structures_test_objects              := $(patsubst %.c, %.o, $(data_structures_test_sources))
data_structures_test_depends              := $(patsubst %.c, %.d, $(data_structures_test_sources))
data_structures_test_libdepend_target     := $(data_structures_test_name_curdir)_all test_framework_all
data_structures_test_libdepend_static     := $(PATH_INSTALL)/$(data_structures_test_name_curdir)$(EXT_LIB_STATIC)
data_structures_test_libdepend_shared     := $(PATH_INSTALL)/lib$(data_structures_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a

include $(data_structures_test_child_makefiles)

$(data_structures_test_path_curdir)%.o: $(data_structures_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(data_structures_test_install_path_static): | $(data_structures_test_libdepend_target)
$(data_structures_test_install_path_static): $(data_structures_test_objects) $(data_structures_test_libdepend_static) $(PATH_INSTALL)/test_framework.lib
	$(CC) -o $@ $(data_structures_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(data_structures_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(data_structures_test_install_path_shared): | $(data_structures_test_libdepend_target)
$(data_structures_test_install_path_shared): $(data_structures_test_objects) $(data_structures_test_libdepend_shared)
	$(CC) -o $@ $(data_structures_test_objects) -Wl,--whole-archive $(data_structures_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: data_structures_test_all
data_structures_test_all: $(data_structures_test_all_targets) ## build all data_structures_test tests
ifneq ($(data_structures_test_objects),)
data_structures_test_all: $(data_structures_test_install_path_static)
data_structures_test_all: $(data_structures_test_install_path_shared)
endif

.PHONY: data_structures_test_clean
data_structures_test_clean: $(data_structures_test_clean_targets) ## remove all data_structures_test tests
data_structures_test_clean:
	- $(RM) $(data_structures_test_install_path_static) $(data_structures_test_install_path_shared) $(data_structures_test_objects) $(data_structures_test_depends)

.PHONY: data_structures_test_run
data_structures_test_run: data_structures_test_all ## build and run static data_structures_test
data_structures_test_run: $(data_structures_test_run_targets)
ifneq ($(data_structures_test_objects),)
data_structures_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(data_structures_test_install_path_static)
endif

-include $(data_structures_test_depends)
