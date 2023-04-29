random_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
random_test_name_curdir          := $(notdir $(patsubst %/,%,$(random_test_path_curdir)))
random_test_child_makefiles      := $(wildcard $(random_test_path_curdir)*/*mk)
random_test_names                := $(basename $(notdir $(random_test_child_makefiles)))
random_test_all_targets          := $(foreach random_test,$(random_test_names),$(random_test)_all)
random_test_clean_targets        := $(foreach random_test,$(random_test_names),$(random_test)_clean)
random_test_run_targets          := $(foreach random_test,$(random_test_names),$(random_test)_run)
random_test_install_path_static  := $(random_test_path_curdir)$(random_test_name_curdir)_static$(EXT_EXE)
random_test_install_path_shared  := $(random_test_path_curdir)$(random_test_name_curdir)_shared$(EXT_EXE)
random_test_sources              := $(wildcard $(random_test_path_curdir)*.c)
random_test_objects              := $(patsubst %.c, %.o, $(random_test_sources))
random_test_depends              := $(patsubst %.c, %.d, $(random_test_sources))
random_test_depends_modules      := 
random_test_libdepend_target     := $(random_test_name_curdir)_all $(foreach module,$(random_test_depends_modules),$(module)_all) test_framework_all
random_test_libdepend_static     := $(PATH_INSTALL)/$(random_test_name_curdir)$(EXT_LIB_STATIC)
random_test_libdepend_static     += $(foreach module_base,$(random_test_depends_modules),$(PATH_INSTALL)/$(module_base)$(EXT_LIB_STATIC))
random_test_libdepend_shared     := $(PATH_INSTALL)/lib$(random_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a
random_test_libdepend_shared     += $(foreach module_base,$(random_test_depends_modules),$(PATH_INSTALL)/lib$(module_base)dll.a)

include $(random_test_child_makefiles)

$(random_test_path_curdir)%.o: $(random_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(random_test_install_path_static): | $(random_test_libdepend_target)
$(random_test_install_path_static): $(random_test_objects)
	$(CC) -o $@ $(random_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(random_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(random_test_install_path_shared): | $(random_test_libdepend_target)
$(random_test_install_path_shared): $(random_test_objects)
	$(CC) -o $@ $(random_test_objects) -Wl,--whole-archive $(random_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: random_test_all
random_test_all: $(random_test_all_targets) ## build all random_test tests
ifneq ($(random_test_objects),)
random_test_all: $(random_test_install_path_static)
random_test_all: $(random_test_install_path_shared)
endif

.PHONY: random_test_clean
random_test_clean: $(random_test_clean_targets) ## remove all random_test tests
random_test_clean:
	- $(RM) $(random_test_install_path_static) $(random_test_install_path_shared) $(random_test_objects) $(random_test_depends)

.PHONY: random_test_re
random_test_re: random_test_clean
random_test_re: random_test_all

.PHONY: random_test_run
random_test_run: random_test_all ## build and run static random_test
random_test_run: $(random_test_run_targets)
ifneq ($(random_test_objects),)
random_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(random_test_install_path_static)
endif

-include $(random_test_depends)
