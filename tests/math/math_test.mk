math_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
math_test_name_curdir          := $(notdir $(patsubst %/,%,$(math_test_path_curdir)))
math_test_child_makefiles      := $(wildcard $(math_test_path_curdir)*/*mk)
math_test_names                := $(basename $(notdir $(math_test_child_makefiles)))
math_test_all_targets          := $(foreach math_test,$(math_test_names),$(math_test)_all)
math_test_clean_targets        := $(foreach math_test,$(math_test_names),$(math_test)_clean)
math_test_run_targets          := $(foreach math_test,$(math_test_names),$(math_test)_run)
math_test_install_path_static  := $(math_test_path_curdir)$(math_test_name_curdir)_static$(EXT_EXE)
math_test_install_path_shared  := $(math_test_path_curdir)$(math_test_name_curdir)_shared$(EXT_EXE)
math_test_sources              := $(wildcard $(math_test_path_curdir)*.c)
math_test_objects              := $(patsubst %.c, %.o, $(math_test_sources))
math_test_depends              := $(patsubst %.c, %.d, $(math_test_sources))
math_test_depends_modules      := 
math_test_libdepend_target     := $(math_test_name_curdir)_all $(foreach module,$(math_test_depends_modules),$(module)_all) test_framework_all
math_test_libdepend_static     := $(PATH_INSTALL)/$(math_test_name_curdir)$(EXT_LIB_STATIC)
math_test_libdepend_static     += $(foreach module_base,$(math_test_depends_modules),$(PATH_INSTALL)/$(module_base)$(EXT_LIB_STATIC))
math_test_libdepend_shared     := $(PATH_INSTALL)/lib$(math_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a
math_test_libdepend_shared     += $(foreach module_base,$(math_test_depends_modules),$(PATH_INSTALL)/lib$(module_base)dll.a)

include $(math_test_child_makefiles)

$(math_test_path_curdir)%.o: $(math_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(math_test_install_path_static): | $(math_test_libdepend_target)
$(math_test_install_path_static): $(math_test_objects)
	$(CC) -o $@ $(math_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(math_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(math_test_install_path_shared): | $(math_test_libdepend_target)
$(math_test_install_path_shared): $(math_test_objects)
	$(CC) -o $@ $(math_test_objects) -Wl,--whole-archive $(math_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: math_test_all
math_test_all: $(math_test_all_targets) ## build all math_test tests
ifneq ($(math_test_objects),)
math_test_all: $(math_test_install_path_static)
math_test_all: $(math_test_install_path_shared)
endif

.PHONY: math_test_clean
math_test_clean: $(math_test_clean_targets) ## remove all math_test tests
math_test_clean:
	- $(RM) $(math_test_install_path_static) $(math_test_install_path_shared) $(math_test_objects) $(math_test_depends)

.PHONY: math_test_re
math_test_re: math_test_clean
math_test_re: math_test_all

.PHONY: math_test_run
math_test_run: math_test_all ## build and run static math_test
math_test_run: $(math_test_run_targets)
ifneq ($(math_test_objects),)
math_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(math_test_install_path_static)
endif

-include $(math_test_depends)
