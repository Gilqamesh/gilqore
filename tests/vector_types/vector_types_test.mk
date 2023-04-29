vector_types_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
vector_types_test_name_curdir          := $(notdir $(patsubst %/,%,$(vector_types_test_path_curdir)))
vector_types_test_child_makefiles      := $(wildcard $(vector_types_test_path_curdir)*/*mk)
vector_types_test_names                := $(basename $(notdir $(vector_types_test_child_makefiles)))
vector_types_test_all_targets          := $(foreach vector_types_test,$(vector_types_test_names),$(vector_types_test)_all)
vector_types_test_clean_targets        := $(foreach vector_types_test,$(vector_types_test_names),$(vector_types_test)_clean)
vector_types_test_run_targets          := $(foreach vector_types_test,$(vector_types_test_names),$(vector_types_test)_run)
vector_types_test_install_path_static  := $(vector_types_test_path_curdir)$(vector_types_test_name_curdir)_static$(EXT_EXE)
vector_types_test_install_path_shared  := $(vector_types_test_path_curdir)$(vector_types_test_name_curdir)_shared$(EXT_EXE)
vector_types_test_sources              := $(wildcard $(vector_types_test_path_curdir)*.c)
vector_types_test_objects              := $(patsubst %.c, %.o, $(vector_types_test_sources))
vector_types_test_depends              := $(patsubst %.c, %.d, $(vector_types_test_sources))
vector_types_test_depends_modules      := 
vector_types_test_libdepend_target     := $(vector_types_test_name_curdir)_all $(foreach module,$(vector_types_test_depends_modules),$(module)_all) test_framework_all
vector_types_test_libdepend_static     := $(PATH_INSTALL)/$(vector_types_test_name_curdir)$(EXT_LIB_STATIC)
vector_types_test_libdepend_static     += $(foreach module_base,$(vector_types_test_depends_modules),$(PATH_INSTALL)/$(module_base)$(EXT_LIB_STATIC))
vector_types_test_libdepend_shared     := $(PATH_INSTALL)/lib$(vector_types_test_name_curdir)dll.a $(PATH_INSTALL)/libtest_frameworkdll.a
vector_types_test_libdepend_shared     += $(foreach module_base,$(vector_types_test_depends_modules),$(PATH_INSTALL)/lib$(module_base)dll.a)

include $(vector_types_test_child_makefiles)

$(vector_types_test_path_curdir)%.o: $(vector_types_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(vector_types_test_install_path_static): | $(vector_types_test_libdepend_target)
$(vector_types_test_install_path_static): $(vector_types_test_objects)
	$(CC) -o $@ $(vector_types_test_objects) -Wl,--whole-archive $(PATH_INSTALL)/test_framework.lib -Wl,--no-whole-archive $(vector_types_test_libdepend_static) $(LFLAGS_COMMON) -mconsole

$(vector_types_test_install_path_shared): | $(vector_types_test_libdepend_target)
$(vector_types_test_install_path_shared): $(vector_types_test_objects)
	$(CC) -o $@ $(vector_types_test_objects) -Wl,--whole-archive $(vector_types_test_libdepend_shared) -Wl,--no-whole-archive $(LFLAGS_COMMON) -mconsole

.PHONY: vector_types_test_all
vector_types_test_all: $(vector_types_test_all_targets) ## build all vector_types_test tests
ifneq ($(vector_types_test_objects),)
vector_types_test_all: $(vector_types_test_install_path_static)
vector_types_test_all: $(vector_types_test_install_path_shared)
endif

.PHONY: vector_types_test_clean
vector_types_test_clean: $(vector_types_test_clean_targets) ## remove all vector_types_test tests
vector_types_test_clean:
	- $(RM) $(vector_types_test_install_path_static) $(vector_types_test_install_path_shared) $(vector_types_test_objects) $(vector_types_test_depends)

.PHONY: vector_types_test_re
vector_types_test_re: vector_types_test_clean
vector_types_test_re: vector_types_test_all

.PHONY: vector_types_test_run
vector_types_test_run: vector_types_test_all ## build and run static vector_types_test
vector_types_test_run: $(vector_types_test_run_targets)
ifneq ($(vector_types_test_objects),)
vector_types_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(vector_types_test_install_path_static)
endif

-include $(vector_types_test_depends)
