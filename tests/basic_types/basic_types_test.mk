basic_types_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
basic_types_test_name_curdir          := $(notdir $(patsubst %/,%,$(basic_types_test_path_curdir)))
basic_types_test_child_makefiles      := $(wildcard $(basic_types_test_path_curdir)*/*mk)
basic_types_test_names                := $(basename $(notdir $(basic_types_test_child_makefiles)))
basic_types_test_all_targets          := $(foreach basic_types_test,$(basic_types_test_names),$(basic_types_test)_all_tests)
basic_types_test_clean_targets        := $(foreach basic_types_test,$(basic_types_test_names),$(basic_types_test)_clean_tests)
basic_types_test_install_path         := $(basic_types_test_path_curdir)$(basic_types_test_name_curdir)$(EXT_EXE)
basic_types_test_sources              := $(wildcard $(basic_types_test_path_curdir)*.c)
basic_types_test_objects              := $(patsubst %.c, %.o, $(basic_types_test_sources))
basic_types_test_depends              := $(patsubst %.c, %.d, $(basic_types_test_sources))
basic_types_test_depends_modules      := basic_types
basic_types_test_depends_libs         := $(foreach module,$(basic_types_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
basic_types_test_depends_libs_rules   := $(foreach module,$(basic_types_test_depends_modules),$(module)_all)

include $(basic_types_test_child_makefiles)

ifneq ($(basic_types_test_objects),)

$(basic_types_test_path_curdir)%.o: $(basic_types_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(basic_types_test_install_path): | $(basic_types_test_depends_libs_rules)
$(basic_types_test_install_path): $(basic_types_test_objects)
	$(CC) -o $@ $^ $(basic_types_test_depends_libs)

.PHONY: basic_types_test_all
basic_types_test_all: $(basic_types_test_install_path) ## build all basic_types_test tests

.PHONY: basic_types_test_clean
basic_types_test_clean: ## remove all basic_types_test tests
	- $(RM) $(basic_types_test_install_path) $(basic_types_test_objects) $(basic_types_test_depends)

else

.PHONY: basic_types_test_all
basic_types_test_all: $(basic_types_test_all_targets) ## build all basic_types_test tests

.PHONY: basic_types_test_clean
basic_types_test_clean: $(basic_types_test_clean_targets) ## remove all basic_types_test tests

endif

-include $(basic_types_test_depends)
