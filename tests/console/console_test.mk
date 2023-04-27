console_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
console_test_name_curdir          := $(notdir $(patsubst %/,%,$(console_test_path_curdir)))
console_test_child_makefiles      := $(wildcard $(console_test_path_curdir)*/*mk)
console_test_names                := $(basename $(notdir $(console_test_child_makefiles)))
console_test_all_targets          := $(foreach console_test,$(console_test_names),$(console_test)_all_tests)
console_test_clean_targets        := $(foreach console_test,$(console_test_names),$(console_test)_clean_tests)
console_test_install_path         := $(console_test_path_curdir)$(console_test_name_curdir)$(EXT_EXE)
console_test_sources              := $(wildcard $(console_test_path_curdir)*.c)
console_test_objects              := $(patsubst %.c, %.o, $(console_test_sources))
console_test_depends              := $(patsubst %.c, %.d, $(console_test_sources))
console_test_depends_modules      := console
console_test_depends_libs         := $(foreach module,$(console_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
console_test_depends_libs_rules   := $(foreach module,$(console_test_depends_modules),$(module)_all)

include $(console_test_child_makefiles)

ifneq ($(console_test_objects),)

$(console_test_path_curdir)%.o: $(console_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(console_test_install_path): | $(console_test_depends_libs_rules)
$(console_test_install_path): $(console_test_objects)
	$(CC) -o $@ $^ $(console_test_depends_libs)

.PHONY: console_test_all
console_test_all: $(console_test_install_path) ## build all console_test tests

.PHONY: console_test_clean
console_test_clean: ## remove all console_test tests
	- $(RM) $(console_test_install_path) $(console_test_objects) $(console_test_depends)

else

.PHONY: console_test_all
console_test_all: $(console_test_all_targets) ## build all console_test tests

.PHONY: console_test_clean
console_test_clean: $(console_test_clean_targets) ## remove all console_test tests

endif

-include $(console_test_depends)
