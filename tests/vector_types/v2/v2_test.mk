v2_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
v2_test_name_curdir          := $(notdir $(patsubst %/,%,$(v2_test_path_curdir)))
v2_test_child_makefiles      := $(wildcard $(v2_test_path_curdir)*/*mk)
v2_test_names                := $(basename $(notdir $(v2_test_child_makefiles)))
v2_test_all_targets          := $(foreach v2_test,$(v2_test_names),$(v2_test)_all)
v2_test_clean_targets        := $(foreach v2_test,$(v2_test_names),$(v2_test)_clean)
v2_test_run_targets          := $(foreach v2_test,$(v2_test_names),$(v2_test)_run)
v2_test_install_path_static  := $(v2_test_path_curdir)$(v2_test_name_curdir)_static$(EXT_EXE)
v2_test_install_path_shared  := $(v2_test_path_curdir)$(v2_test_name_curdir)_shared$(EXT_EXE)
v2_test_sources              := $(wildcard $(v2_test_path_curdir)*.c)
v2_test_objects              := $(patsubst %.c, %.o, $(v2_test_sources))
v2_test_depends              := $(patsubst %.c, %.d, $(v2_test_sources))
v2_test_depends_modules      := 
v2_test_libdepend_target     := $(v2_test_name_curdir)_all $(foreach module,$(v2_test_depends_modules),$(module)_all) test_framework_all
v2_test_libdepend_static     := $(PATH_INSTALL)/$(v2_test_name_curdir)$(EXT_LIB_STATIC)
v2_test_libdepend_static     += $(foreach module_base,$(v2_test_depends_modules),$(PATH_INSTALL)/$(module_base)$(EXT_LIB_STATIC))
v2_test_libdepend_shared     := $(PATH_INSTALL)/lib$(v2_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a
v2_test_libdepend_shared     += $(foreach module_base,$(v2_test_depends_modules),$(PATH_INSTALL)/lib$(module_base)dll.a)

include $(v2_test_child_makefiles)

$(v2_test_path_curdir)%.o: $(v2_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(v2_test_install_path_static): | $(v2_test_libdepend_target)
$(v2_test_install_path_static): $(v2_test_objects)
	$(CC) -o $@ $(v2_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(v2_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(v2_test_install_path_shared): | $(v2_test_libdepend_target)
$(v2_test_install_path_shared): $(v2_test_objects)
	$(CC) -o $@ $(v2_test_objects) -Wl,--whole-archive $(v2_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: v2_test_all
v2_test_all: $(v2_test_all_targets) ## build all v2_test tests
ifneq ($(v2_test_objects),)
v2_test_all: $(v2_test_install_path_static)
v2_test_all: $(v2_test_install_path_shared)
endif

.PHONY: v2_test_clean
v2_test_clean: $(v2_test_clean_targets) ## remove all v2_test tests
v2_test_clean:
	- $(RM) $(v2_test_install_path_static) $(v2_test_install_path_shared) $(v2_test_objects) $(v2_test_depends)

.PHONY: v2_test_re
v2_test_re: v2_test_clean
v2_test_re: v2_test_all

.PHONY: v2_test_run
v2_test_run: v2_test_all ## build and run static v2_test
v2_test_run: $(v2_test_run_targets)
ifneq ($(v2_test_objects),)
v2_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(v2_test_install_path_static)
endif

-include $(v2_test_depends)
