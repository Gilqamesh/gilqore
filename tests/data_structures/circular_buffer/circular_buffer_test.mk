circular_buffer_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
circular_buffer_test_name_curdir          := $(notdir $(patsubst %/,%,$(circular_buffer_test_path_curdir)))
circular_buffer_test_child_makefiles      := $(wildcard $(circular_buffer_test_path_curdir)*/*mk)
circular_buffer_test_names                := $(basename $(notdir $(circular_buffer_test_child_makefiles)))
circular_buffer_test_all_targets          := $(foreach circular_buffer_test,$(circular_buffer_test_names),$(circular_buffer_test)_all)
circular_buffer_test_clean_targets        := $(foreach circular_buffer_test,$(circular_buffer_test_names),$(circular_buffer_test)_clean)
circular_buffer_test_run_targets          := $(foreach circular_buffer_test,$(circular_buffer_test_names),$(circular_buffer_test)_run)
circular_buffer_test_install_path_static  := $(circular_buffer_test_path_curdir)$(circular_buffer_test_name_curdir)_static$(EXT_EXE)
circular_buffer_test_install_path_shared  := $(circular_buffer_test_path_curdir)$(circular_buffer_test_name_curdir)_shared$(EXT_EXE)
circular_buffer_test_sources              := $(wildcard $(circular_buffer_test_path_curdir)*.c)
circular_buffer_test_objects              := $(patsubst %.c, %.o, $(circular_buffer_test_sources))
circular_buffer_test_depends              := $(patsubst %.c, %.d, $(circular_buffer_test_sources))
circular_buffer_test_depends_modules      := libc random mod
circular_buffer_test_libdepend_target     := $(circular_buffer_test_name_curdir)_all $(foreach module,$(circular_buffer_test_depends_modules),$(module)_all) test_framework_all
circular_buffer_test_libdepend_static     := $(PATH_INSTALL)/$(circular_buffer_test_name_curdir)$(EXT_LIB_STATIC)
circular_buffer_test_libdepend_static     += $(foreach module_base,$(circular_buffer_test_depends_modules),$(PATH_INSTALL)/$(module_base)$(EXT_LIB_STATIC))
circular_buffer_test_libdepend_shared     := $(PATH_INSTALL)/lib$(circular_buffer_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a
circular_buffer_test_libdepend_shared     += $(foreach module_base,$(circular_buffer_test_depends_modules),$(PATH_INSTALL)/lib$(module_base)dll.a)

include $(circular_buffer_test_child_makefiles)

$(circular_buffer_test_path_curdir)%.o: $(circular_buffer_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(circular_buffer_test_install_path_static): | $(circular_buffer_test_libdepend_target)
$(circular_buffer_test_install_path_static): $(circular_buffer_test_objects)
	$(CC) -o $@ $(circular_buffer_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(circular_buffer_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(circular_buffer_test_install_path_shared): | $(circular_buffer_test_libdepend_target)
$(circular_buffer_test_install_path_shared): $(circular_buffer_test_objects)
	$(CC) -o $@ $(circular_buffer_test_objects) -Wl,--whole-archive $(circular_buffer_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: circular_buffer_test_all
circular_buffer_test_all: $(circular_buffer_test_all_targets) ## build all circular_buffer_test tests
ifneq ($(circular_buffer_test_objects),)
circular_buffer_test_all: $(circular_buffer_test_install_path_static)
circular_buffer_test_all: $(circular_buffer_test_install_path_shared)
endif

.PHONY: circular_buffer_test_clean
circular_buffer_test_clean: $(circular_buffer_test_clean_targets) ## remove all circular_buffer_test tests
circular_buffer_test_clean:
	- $(RM) $(circular_buffer_test_install_path_static) $(circular_buffer_test_install_path_shared) $(circular_buffer_test_objects) $(circular_buffer_test_depends)

.PHONY: circular_buffer_test_re
circular_buffer_test_re: circular_buffer_test_clean
circular_buffer_test_re: circular_buffer_test_all

.PHONY: circular_buffer_test_run
circular_buffer_test_run: circular_buffer_test_all ## build and run static circular_buffer_test
circular_buffer_test_run: $(circular_buffer_test_run_targets)
ifneq ($(circular_buffer_test_objects),)
circular_buffer_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(circular_buffer_test_install_path_static)
endif

-include $(circular_buffer_test_depends)
