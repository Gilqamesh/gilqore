libc_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
libc_test_name_curdir          := $(notdir $(patsubst %/,%,$(libc_test_path_curdir)))
libc_test_child_makefiles      := $(wildcard $(libc_test_path_curdir)*/*mk)
libc_test_names                := $(basename $(notdir $(libc_test_child_makefiles)))
libc_test_all_targets          := $(foreach libc_test,$(libc_test_names),$(libc_test)_all)
libc_test_clean_targets        := $(foreach libc_test,$(libc_test_names),$(libc_test)_clean)
libc_test_run_targets          := $(foreach libc_test,$(libc_test_names),$(libc_test)_run)
libc_test_install_path_static  := $(libc_test_path_curdir)$(libc_test_name_curdir)_static$(EXT_EXE)
libc_test_install_path_shared  := $(libc_test_path_curdir)$(libc_test_name_curdir)_shared$(EXT_EXE)
libc_test_sources              := $(wildcard $(libc_test_path_curdir)*.c)
libc_test_objects              := $(patsubst %.c, %.o, $(libc_test_sources))
libc_test_depends              := $(patsubst %.c, %.d, $(libc_test_sources))
libc_test_depends_modules      := 
libc_test_libdepend_target     := $(libc_test_name_curdir)_all $(foreach module,$(libc_test_depends_modules),$(module)_all) test_framework_all
libc_test_libdepend_static     := $(PATH_INSTALL)/$(libc_test_name_curdir)$(EXT_LIB_STATIC)
libc_test_libdepend_static     += $(foreach module_base,$(libc_test_depends_modules),$(PATH_INSTALL)/$(module_base)$(EXT_LIB_STATIC))
libc_test_libdepend_shared     := $(PATH_INSTALL)/lib$(libc_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a
libc_test_libdepend_shared     += $(foreach module_base,$(libc_test_depends_modules),$(PATH_INSTALL)/lib$(module_base)dll.a)

include $(libc_test_child_makefiles)

$(libc_test_path_curdir)%.o: $(libc_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(libc_test_install_path_static): | $(libc_test_libdepend_target)
$(libc_test_install_path_static): $(libc_test_objects)
	$(CC) -o $@ $(libc_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(libc_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(libc_test_install_path_shared): | $(libc_test_libdepend_target)
$(libc_test_install_path_shared): $(libc_test_objects)
	$(CC) -o $@ $(libc_test_objects) -Wl,--whole-archive $(libc_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: libc_test_all
libc_test_all: $(libc_test_all_targets) ## build all libc_test tests
ifneq ($(libc_test_objects),)
libc_test_all: $(libc_test_install_path_static)
libc_test_all: $(libc_test_install_path_shared)
endif

.PHONY: libc_test_clean
libc_test_clean: $(libc_test_clean_targets) ## remove all libc_test tests
libc_test_clean:
	- $(RM) $(libc_test_install_path_static) $(libc_test_install_path_shared) $(libc_test_objects) $(libc_test_depends)

.PHONY: libc_test_re
libc_test_re: libc_test_clean
libc_test_re: libc_test_all

.PHONY: libc_test_run
libc_test_run: libc_test_all ## build and run static libc_test
libc_test_run: $(libc_test_run_targets)
ifneq ($(libc_test_objects),)
libc_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(libc_test_install_path_static)
endif

-include $(libc_test_depends)
