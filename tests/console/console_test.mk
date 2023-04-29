console_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
console_test_name_curdir          := $(notdir $(patsubst %/,%,$(console_test_path_curdir)))
console_test_child_makefiles      := $(wildcard $(console_test_path_curdir)*/*mk)
console_test_names                := $(basename $(notdir $(console_test_child_makefiles)))
console_test_all_targets          := $(foreach console_test,$(console_test_names),$(console_test)_all)
console_test_clean_targets        := $(foreach console_test,$(console_test_names),$(console_test)_clean)
console_test_run_targets          := $(foreach console_test,$(console_test_names),$(console_test)_run)
console_test_install_path_static  := $(console_test_path_curdir)$(console_test_name_curdir)_static$(EXT_EXE)
console_test_install_path_shared  := $(console_test_path_curdir)$(console_test_name_curdir)_shared$(EXT_EXE)
console_test_sources              := $(wildcard $(console_test_path_curdir)*.c)
console_test_objects              := $(patsubst %.c, %.o, $(console_test_sources))
console_test_depends              := $(patsubst %.c, %.d, $(console_test_sources))
console_test_depends_modules      := 
console_test_libdepend_target     := $(console_test_name_curdir)_all $(foreach module,$(console_test_depends_modules),$(module)_all) test_framework_all
console_test_libdepend_static     := $(PATH_INSTALL)/$(console_test_name_curdir)$(EXT_LIB_STATIC)
console_test_libdepend_static     += $(foreach module_base,$(console_test_depends_modules),$(PATH_INSTALL)/$(module_base)$(EXT_LIB_STATIC))
console_test_libdepend_shared     := $(PATH_INSTALL)/lib$(console_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a
console_test_libdepend_shared     += $(foreach module_base,$(console_test_depends_modules),$(PATH_INSTALL)/lib$(module_base)dll.a)

include $(console_test_child_makefiles)

$(console_test_path_curdir)%.o: $(console_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(console_test_install_path_static): | $(console_test_libdepend_target)
$(console_test_install_path_static): $(console_test_objects)
	$(CC) -o $@ $(console_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(console_test_libdepend_static) $(LFLAGS_COMMON) -mwindows

$(console_test_install_path_shared): | $(console_test_libdepend_target)
$(console_test_install_path_shared): $(console_test_objects)
	$(CC) -o $@ $(console_test_objects) -Wl,--whole-archive $(console_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mwindows

.PHONY: console_test_all
console_test_all: $(console_test_all_targets) ## build all console_test tests
ifneq ($(console_test_objects),)
console_test_all: $(console_test_install_path_static)
console_test_all: $(console_test_install_path_shared)
endif

.PHONY: console_test_clean
console_test_clean: $(console_test_clean_targets) ## remove all console_test tests
console_test_clean:
	- $(RM) $(console_test_install_path_static) $(console_test_install_path_shared) $(console_test_objects) $(console_test_depends)

.PHONY: console_test_re
console_test_re: console_test_clean
console_test_re: console_test_all

.PHONY: console_test_run
console_test_run: console_test_all ## build and run static console_test
console_test_run: $(console_test_run_targets)
ifneq ($(console_test_objects),)
console_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(console_test_install_path_static)
endif

-include $(console_test_depends)
