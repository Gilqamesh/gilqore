lerp_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
lerp_test_name_curdir          := $(notdir $(patsubst %/,%,$(lerp_test_path_curdir)))
lerp_test_child_makefiles      := $(wildcard $(lerp_test_path_curdir)*/*mk)
lerp_test_names                := $(basename $(notdir $(lerp_test_child_makefiles)))
lerp_test_all_targets          := $(foreach lerp_test,$(lerp_test_names),$(lerp_test)_all)
lerp_test_clean_targets        := $(foreach lerp_test,$(lerp_test_names),$(lerp_test)_clean)
lerp_test_run_targets          := $(foreach lerp_test,$(lerp_test_names),$(lerp_test)_run)
lerp_test_install_path_static  := $(lerp_test_path_curdir)$(lerp_test_name_curdir)_static$(EXT_EXE)
lerp_test_install_path_shared  := $(lerp_test_path_curdir)$(lerp_test_name_curdir)_shared$(EXT_EXE)
lerp_test_sources              := $(wildcard $(lerp_test_path_curdir)*.c)
lerp_test_objects              := $(patsubst %.c, %.o, $(lerp_test_sources))
lerp_test_depends              := $(patsubst %.c, %.d, $(lerp_test_sources))
lerp_test_depends_modules      := 
lerp_test_libdepend_target     := $(lerp_test_name_curdir)_all $(foreach module,$(lerp_test_depends_modules),$(module)_all) test_framework_all
lerp_test_libdepend_static     := $(PATH_INSTALL)/$(lerp_test_name_curdir)$(EXT_LIB_STATIC)
lerp_test_libdepend_static     += $(foreach module_base,$(lerp_test_depends_modules),$(PATH_INSTALL)/$(module_base)$(EXT_LIB_STATIC))
lerp_test_libdepend_shared     := $(PATH_INSTALL)/lib$(lerp_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a
lerp_test_libdepend_shared     += $(foreach module_base,$(lerp_test_depends_modules),$(PATH_INSTALL)/lib$(module_base)dll.a)

include $(lerp_test_child_makefiles)

$(lerp_test_path_curdir)%.o: $(lerp_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(lerp_test_install_path_static): | $(lerp_test_libdepend_target)
$(lerp_test_install_path_static): $(lerp_test_objects)
	$(CC) -o $@ $(lerp_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(lerp_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(lerp_test_install_path_shared): | $(lerp_test_libdepend_target)
$(lerp_test_install_path_shared): $(lerp_test_objects)
	$(CC) -o $@ $(lerp_test_objects) -Wl,--whole-archive $(lerp_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: lerp_test_all
lerp_test_all: $(lerp_test_all_targets) ## build all lerp_test tests
ifneq ($(lerp_test_objects),)
lerp_test_all: $(lerp_test_install_path_static)
lerp_test_all: $(lerp_test_install_path_shared)
endif

.PHONY: lerp_test_clean
lerp_test_clean: $(lerp_test_clean_targets) ## remove all lerp_test tests
lerp_test_clean:
	- $(RM) $(lerp_test_install_path_static) $(lerp_test_install_path_shared) $(lerp_test_objects) $(lerp_test_depends)

.PHONY: lerp_test_re
lerp_test_re: lerp_test_clean
lerp_test_re: lerp_test_all

.PHONY: lerp_test_run
lerp_test_run: lerp_test_all ## build and run static lerp_test
lerp_test_run: $(lerp_test_run_targets)
ifneq ($(lerp_test_objects),)
lerp_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(lerp_test_install_path_static)
endif

-include $(lerp_test_depends)
