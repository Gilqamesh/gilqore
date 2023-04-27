compare_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
compare_test_name_curdir          := $(notdir $(patsubst %/,%,$(compare_test_path_curdir)))
compare_test_child_makefiles      := $(wildcard $(compare_test_path_curdir)*/*mk)
compare_test_names                := $(basename $(notdir $(compare_test_child_makefiles)))
compare_test_all_targets          := $(foreach compare_test,$(compare_test_names),$(compare_test)_all_tests)
compare_test_clean_targets        := $(foreach compare_test,$(compare_test_names),$(compare_test)_clean_tests)
compare_test_install_path         := $(compare_test_path_curdir)$(compare_test_name_curdir)$(EXT_EXE)
compare_test_sources              := $(wildcard $(compare_test_path_curdir)*.c)
compare_test_objects              := $(patsubst %.c, %.o, $(compare_test_sources))
compare_test_depends              := $(patsubst %.c, %.d, $(compare_test_sources))
compare_test_depends_modules      := compare
compare_test_depends_libs         := $(foreach module,$(compare_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
compare_test_depends_libs_rules   := $(foreach module,$(compare_test_depends_modules),$(module)_all)

include $(compare_test_child_makefiles)

ifneq ($(compare_test_objects),)

$(compare_test_path_curdir)%.o: $(compare_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(compare_test_install_path): | $(compare_test_depends_libs_rules)
$(compare_test_install_path): $(compare_test_objects)
	$(CC) -o $@ $^ $(compare_test_depends_libs)

.PHONY: compare_test_all
compare_test_all: $(compare_test_install_path) ## build all compare_test tests

.PHONY: compare_test_clean
compare_test_clean: ## remove all compare_test tests
	- $(RM) $(compare_test_install_path) $(compare_test_objects) $(compare_test_depends)

else

.PHONY: compare_test_all
compare_test_all: $(compare_test_all_targets) ## build all compare_test tests

.PHONY: compare_test_clean
compare_test_clean: $(compare_test_clean_targets) ## remove all compare_test tests

endif

-include $(compare_test_depends)
