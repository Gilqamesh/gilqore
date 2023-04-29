sqrt_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
sqrt_test_name_curdir          := $(notdir $(patsubst %/,%,$(sqrt_test_path_curdir)))
sqrt_test_child_makefiles      := $(wildcard $(sqrt_test_path_curdir)*/*mk)
sqrt_test_names                := $(basename $(notdir $(sqrt_test_child_makefiles)))
sqrt_test_all_targets          := $(foreach sqrt_test,$(sqrt_test_names),$(sqrt_test)_all)
sqrt_test_clean_targets        := $(foreach sqrt_test,$(sqrt_test_names),$(sqrt_test)_clean)
sqrt_test_run_targets          := $(foreach sqrt_test,$(sqrt_test_names),$(sqrt_test)_run)
sqrt_test_install_path_static  := $(sqrt_test_path_curdir)$(sqrt_test_name_curdir)_static$(EXT_EXE)
sqrt_test_install_path_shared  := $(sqrt_test_path_curdir)$(sqrt_test_name_curdir)_shared$(EXT_EXE)
sqrt_test_sources              := $(wildcard $(sqrt_test_path_curdir)*.c)
sqrt_test_objects              := $(patsubst %.c, %.o, $(sqrt_test_sources))
sqrt_test_depends              := $(patsubst %.c, %.d, $(sqrt_test_sources))
sqrt_test_depends_modules      := 
sqrt_test_libdepend_target     := $(sqrt_test_name_curdir)_all $(foreach module,$(sqrt_test_depends_modules),$(module)_all) test_framework_all
sqrt_test_libdepend_static     := $(PATH_INSTALL)/$(sqrt_test_name_curdir)$(EXT_LIB_STATIC)
sqrt_test_libdepend_static     += $(foreach module_base,$(sqrt_test_depends_modules),$(PATH_INSTALL)/$(module_base)$(EXT_LIB_STATIC))
sqrt_test_libdepend_shared     := $(PATH_INSTALL)/lib$(sqrt_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a
sqrt_test_libdepend_shared     += $(foreach module_base,$(sqrt_test_depends_modules),$(PATH_INSTALL)/lib$(module_base)dll.a)

include $(sqrt_test_child_makefiles)

$(sqrt_test_path_curdir)%.o: $(sqrt_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(sqrt_test_install_path_static): | $(sqrt_test_libdepend_target)
$(sqrt_test_install_path_static): $(sqrt_test_objects)
	$(CC) -o $@ $(sqrt_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(sqrt_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(sqrt_test_install_path_shared): | $(sqrt_test_libdepend_target)
$(sqrt_test_install_path_shared): $(sqrt_test_objects)
	$(CC) -o $@ $(sqrt_test_objects) -Wl,--whole-archive $(sqrt_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: sqrt_test_all
sqrt_test_all: $(sqrt_test_all_targets) ## build all sqrt_test tests
ifneq ($(sqrt_test_objects),)
sqrt_test_all: $(sqrt_test_install_path_static)
sqrt_test_all: $(sqrt_test_install_path_shared)
endif

.PHONY: sqrt_test_clean
sqrt_test_clean: $(sqrt_test_clean_targets) ## remove all sqrt_test tests
sqrt_test_clean:
	- $(RM) $(sqrt_test_install_path_static) $(sqrt_test_install_path_shared) $(sqrt_test_objects) $(sqrt_test_depends)

.PHONY: sqrt_test_re
sqrt_test_re: sqrt_test_clean
sqrt_test_re: sqrt_test_all

.PHONY: sqrt_test_run
sqrt_test_run: sqrt_test_all ## build and run static sqrt_test
sqrt_test_run: $(sqrt_test_run_targets)
ifneq ($(sqrt_test_objects),)
sqrt_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(sqrt_test_install_path_static)
endif

-include $(sqrt_test_depends)
