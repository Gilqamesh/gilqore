file_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
file_test_name_curdir          := $(notdir $(patsubst %/,%,$(file_test_path_curdir)))
file_test_child_makefiles      := $(wildcard $(file_test_path_curdir)*/*mk)
file_test_names                := $(basename $(notdir $(file_test_child_makefiles)))
file_test_all_targets          := $(foreach file_test,$(file_test_names),$(file_test)_all)
file_test_clean_targets        := $(foreach file_test,$(file_test_names),$(file_test)_clean)
file_test_run_targets          := $(foreach file_test,$(file_test_names),$(file_test)_run)
file_test_install_path_static  := $(file_test_path_curdir)$(file_test_name_curdir)_static$(EXT_EXE)
file_test_install_path_shared  := $(file_test_path_curdir)$(file_test_name_curdir)_shared$(EXT_EXE)
file_test_sources              := $(wildcard $(file_test_path_curdir)*.c)
file_test_objects              := $(patsubst %.c, %.o, $(file_test_sources))
file_test_depends              := $(patsubst %.c, %.d, $(file_test_sources))
file_test_depends_modules      := libc random
file_test_libdepend_target     := $(file_test_name_curdir)_all $(foreach module,$(file_test_depends_modules),$(module)_all) test_framework_all
file_test_libdepend_static     := $(PATH_INSTALL)/$(file_test_name_curdir)$(EXT_LIB_STATIC)
file_test_libdepend_static     += $(foreach module_base,$(file_test_depends_modules),$(PATH_INSTALL)/$(module_base)$(EXT_LIB_STATIC))
file_test_libdepend_shared     := $(PATH_INSTALL)/lib$(file_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a
file_test_libdepend_shared     += $(foreach module_base,$(file_test_depends_modules),$(PATH_INSTALL)/lib$(module_base)dll.a)

include $(file_test_child_makefiles)

$(file_test_path_curdir)%.o: $(file_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(file_test_install_path_static): | $(file_test_libdepend_target)
$(file_test_install_path_static): $(file_test_objects)
	$(CC) -o $@ $(file_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(file_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(file_test_install_path_shared): | $(file_test_libdepend_target)
$(file_test_install_path_shared): $(file_test_objects)
	$(CC) -o $@ $(file_test_objects) -Wl,--whole-archive $(file_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: file_test_all
file_test_all: $(file_test_all_targets) ## build all file_test tests
ifneq ($(file_test_objects),)
file_test_all: $(file_test_install_path_static)
file_test_all: $(file_test_install_path_shared)
endif

.PHONY: file_test_clean
file_test_clean: $(file_test_clean_targets) ## remove all file_test tests
file_test_clean:
	- $(RM) $(file_test_install_path_static) $(file_test_install_path_shared) $(file_test_objects) $(file_test_depends)

.PHONY: file_test_re
file_test_re: file_test_clean
file_test_re: file_test_all

.PHONY: file_test_run
file_test_run: file_test_all ## build and run static file_test
file_test_run: $(file_test_run_targets)
ifneq ($(file_test_objects),)
file_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(file_test_install_path_static)
endif

-include $(file_test_depends)
