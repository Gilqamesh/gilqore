color_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
color_test_name_curdir          := $(notdir $(patsubst %/,%,$(color_test_path_curdir)))
color_test_child_makefiles      := $(wildcard $(color_test_path_curdir)*/*mk)
color_test_names                := $(basename $(notdir $(color_test_child_makefiles)))
color_test_all_targets          := $(foreach color_test,$(color_test_names),$(color_test)_all)
color_test_clean_targets        := $(foreach color_test,$(color_test_names),$(color_test)_clean)
color_test_run_targets          := $(foreach color_test,$(color_test_names),$(color_test)_run)
color_test_install_path_static  := $(color_test_path_curdir)$(color_test_name_curdir)_static$(EXT_EXE)
color_test_install_path_shared  := $(color_test_path_curdir)$(color_test_name_curdir)_shared$(EXT_EXE)
color_test_sources              := $(wildcard $(color_test_path_curdir)*.c)
color_test_objects              := $(patsubst %.c, %.o, $(color_test_sources))
color_test_depends              := $(patsubst %.c, %.d, $(color_test_sources))
color_test_libdepend_target     := $(color_test_name_curdir)_all test_framework_all
color_test_libdepend_static     := $(PATH_INSTALL)/$(color_test_name_curdir)$(EXT_LIB_STATIC)
color_test_libdepend_shared     := $(PATH_INSTALL)/lib$(color_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a

include $(color_test_child_makefiles)

$(color_test_path_curdir)%.o: $(color_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(color_test_install_path_static): | $(color_test_libdepend_target)
$(color_test_install_path_static): $(color_test_objects) $(color_test_libdepend_static) $(PATH_INSTALL)/test_framework.lib
	$(CC) -o $@ $(color_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(color_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(color_test_install_path_shared): | $(color_test_libdepend_target)
$(color_test_install_path_shared): $(color_test_objects) $(color_test_libdepend_shared)
	$(CC) -o $@ $(color_test_objects) -Wl,--whole-archive $(color_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: color_test_all
color_test_all: $(color_test_all_targets) ## build all color_test tests
ifneq ($(color_test_objects),)
color_test_all: $(color_test_install_path_static)
color_test_all: $(color_test_install_path_shared)
endif

.PHONY: color_test_clean
color_test_clean: $(color_test_clean_targets) ## remove all color_test tests
color_test_clean:
	- $(RM) $(color_test_install_path_static) $(color_test_install_path_shared) $(color_test_objects) $(color_test_depends)

.PHONY: color_test_run
color_test_run: color_test_all ## build and run static color_test
color_test_run: $(color_test_run_targets)
ifneq ($(color_test_objects),)
color_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(color_test_install_path_static)
endif

-include $(color_test_depends)
