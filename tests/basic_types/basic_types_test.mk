basic_types_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
basic_types_test_name_curdir          := $(notdir $(patsubst %/,%,$(basic_types_test_path_curdir)))
basic_types_test_child_makefiles      := $(wildcard $(basic_types_test_path_curdir)*/*mk)
basic_types_test_names                := $(basename $(notdir $(basic_types_test_child_makefiles)))
basic_types_test_all_targets          := $(foreach basic_types_test,$(basic_types_test_names),$(basic_types_test)_all)
basic_types_test_clean_targets        := $(foreach basic_types_test,$(basic_types_test_names),$(basic_types_test)_clean)
basic_types_test_run_targets          := $(foreach basic_types_test,$(basic_types_test_names),$(basic_types_test)_run)
basic_types_test_install_path_static  := $(basic_types_test_path_curdir)$(basic_types_test_name_curdir)_static$(EXT_EXE)
basic_types_test_install_path_shared  := $(basic_types_test_path_curdir)$(basic_types_test_name_curdir)_shared$(EXT_EXE)
basic_types_test_sources              := $(wildcard $(basic_types_test_path_curdir)*.c)
basic_types_test_objects              := $(patsubst %.c, %.o, $(basic_types_test_sources))
basic_types_test_depends              := $(patsubst %.c, %.d, $(basic_types_test_sources))
basic_types_test_depends_modules      := 
basic_types_test_libdepend_target     := $(basic_types_test_name_curdir)_all $(foreach module,$(basic_types_test_depends_modules),$(module)_all) test_framework_all
basic_types_test_libdepend_static     := $(PATH_INSTALL)/$(basic_types_test_name_curdir)$(EXT_LIB_STATIC)
basic_types_test_libdepend_static     += $(foreach module_base,$(basic_types_test_depends_modules),$(PATH_INSTALL)/$(module_base)$(EXT_LIB_STATIC))
basic_types_test_libdepend_shared     := $(PATH_INSTALL)/lib$(basic_types_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a
basic_types_test_libdepend_shared     += $(foreach module_base,$(basic_types_test_depends_modules),$(PATH_INSTALL)/lib$(module_base)dll.a)

include $(basic_types_test_child_makefiles)

$(basic_types_test_path_curdir)%.o: $(basic_types_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(basic_types_test_install_path_static): | $(basic_types_test_libdepend_target)
$(basic_types_test_install_path_static): $(basic_types_test_objects)
	$(CC) -o $@ $(basic_types_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(basic_types_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(basic_types_test_install_path_shared): | $(basic_types_test_libdepend_target)
$(basic_types_test_install_path_shared): $(basic_types_test_objects)
	$(CC) -o $@ $(basic_types_test_objects) -Wl,--whole-archive $(basic_types_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: basic_types_test_all
basic_types_test_all: $(basic_types_test_all_targets) ## build all basic_types_test tests
ifneq ($(basic_types_test_objects),)
basic_types_test_all: $(basic_types_test_install_path_static)
basic_types_test_all: $(basic_types_test_install_path_shared)
endif

.PHONY: basic_types_test_clean
basic_types_test_clean: $(basic_types_test_clean_targets) ## remove all basic_types_test tests
basic_types_test_clean:
	- $(RM) $(basic_types_test_install_path_static) $(basic_types_test_install_path_shared) $(basic_types_test_objects) $(basic_types_test_depends)

.PHONY: basic_types_test_re
basic_types_test_re: basic_types_test_clean
basic_types_test_re: basic_types_test_all

.PHONY: basic_types_test_run
basic_types_test_run: basic_types_test_all ## build and run static basic_types_test
basic_types_test_run: $(basic_types_test_run_targets)
ifneq ($(basic_types_test_objects),)
basic_types_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(basic_types_test_install_path_static)
endif

-include $(basic_types_test_depends)
