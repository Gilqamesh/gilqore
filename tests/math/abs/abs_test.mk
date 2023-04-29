abs_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
abs_test_name_curdir          := $(notdir $(patsubst %/,%,$(abs_test_path_curdir)))
abs_test_child_makefiles      := $(wildcard $(abs_test_path_curdir)*/*mk)
abs_test_names                := $(basename $(notdir $(abs_test_child_makefiles)))
abs_test_all_targets          := $(foreach abs_test,$(abs_test_names),$(abs_test)_all)
abs_test_clean_targets        := $(foreach abs_test,$(abs_test_names),$(abs_test)_clean)
abs_test_run_targets          := $(foreach abs_test,$(abs_test_names),$(abs_test)_run)
abs_test_install_path_static  := $(abs_test_path_curdir)$(abs_test_name_curdir)_static$(EXT_EXE)
abs_test_install_path_shared  := $(abs_test_path_curdir)$(abs_test_name_curdir)_shared$(EXT_EXE)
abs_test_sources              := $(wildcard $(abs_test_path_curdir)*.c)
abs_test_objects              := $(patsubst %.c, %.o, $(abs_test_sources))
abs_test_depends              := $(patsubst %.c, %.d, $(abs_test_sources))
abs_test_depends_modules      := 
abs_test_libdepend_target     := $(abs_test_name_curdir)_all $(foreach module,$(abs_test_depends_modules),$(module)_all) test_framework_all
abs_test_libdepend_static     := $(PATH_INSTALL)/$(abs_test_name_curdir)$(EXT_LIB_STATIC)
abs_test_libdepend_static     += $(foreach module_base,$(abs_test_depends_modules),$(PATH_INSTALL)/$(module_base)$(EXT_LIB_STATIC))
abs_test_libdepend_shared     := $(PATH_INSTALL)/lib$(abs_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a
abs_test_libdepend_shared     += $(foreach module_base,$(abs_test_depends_modules),$(PATH_INSTALL)/lib$(module_base)dll.a)

include $(abs_test_child_makefiles)

$(abs_test_path_curdir)%.o: $(abs_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(abs_test_install_path_static): | $(abs_test_libdepend_target)
$(abs_test_install_path_static): $(abs_test_objects)
	$(CC) -o $@ $(abs_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(abs_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(abs_test_install_path_shared): | $(abs_test_libdepend_target)
$(abs_test_install_path_shared): $(abs_test_objects)
	$(CC) -o $@ $(abs_test_objects) -Wl,--whole-archive $(abs_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: abs_test_all
abs_test_all: $(abs_test_all_targets) ## build all abs_test tests
ifneq ($(abs_test_objects),)
abs_test_all: $(abs_test_install_path_static)
abs_test_all: $(abs_test_install_path_shared)
endif

.PHONY: abs_test_clean
abs_test_clean: $(abs_test_clean_targets) ## remove all abs_test tests
abs_test_clean:
	- $(RM) $(abs_test_install_path_static) $(abs_test_install_path_shared) $(abs_test_objects) $(abs_test_depends)

.PHONY: abs_test_re
abs_test_re: abs_test_clean
abs_test_re: abs_test_all

.PHONY: abs_test_run
abs_test_run: abs_test_all ## build and run static abs_test
abs_test_run: $(abs_test_run_targets)
ifneq ($(abs_test_objects),)
abs_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(abs_test_install_path_static)
endif

-include $(abs_test_depends)
