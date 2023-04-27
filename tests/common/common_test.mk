common_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
common_test_name_curdir          := $(notdir $(patsubst %/,%,$(common_test_path_curdir)))
common_test_child_makefiles      := $(wildcard $(common_test_path_curdir)*/*mk)
common_test_names                := $(basename $(notdir $(common_test_child_makefiles)))
common_test_all_targets          := $(foreach common_test,$(common_test_names),$(common_test)_all_tests)
common_test_clean_targets        := $(foreach common_test,$(common_test_names),$(common_test)_clean_tests)
common_test_install_path         := $(common_test_path_curdir)$(common_test_name_curdir)$(EXT_EXE)
common_test_sources              := $(wildcard $(common_test_path_curdir)*.c)
common_test_objects              := $(patsubst %.c, %.o, $(common_test_sources))
common_test_depends              := $(patsubst %.c, %.d, $(common_test_sources))
common_test_depends_modules      := common
common_test_depends_libs         := $(foreach module,$(common_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
common_test_depends_libs_rules   := $(foreach module,$(common_test_depends_modules),$(module)_all)

include $(common_test_child_makefiles)

ifneq ($(common_test_objects),)

$(common_test_path_curdir)%.o: $(common_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(common_test_install_path): | $(common_test_depends_libs_rules)
$(common_test_install_path): $(common_test_objects)
	$(CC) -o $@ $^ $(common_test_depends_libs)

.PHONY: common_test_all
common_test_all: $(common_test_install_path) ## build all common_test tests

.PHONY: common_test_clean
common_test_clean: ## remove all common_test tests
	- $(RM) $(common_test_install_path) $(common_test_objects) $(common_test_depends)

else

.PHONY: common_test_all
common_test_all: $(common_test_all_targets) ## build all common_test tests

.PHONY: common_test_clean
common_test_clean: $(common_test_clean_targets) ## remove all common_test tests

endif

-include $(common_test_depends)
