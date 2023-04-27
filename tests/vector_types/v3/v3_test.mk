v3_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
v3_test_name_curdir          := $(notdir $(patsubst %/,%,$(v3_test_path_curdir)))
v3_test_child_makefiles      := $(wildcard $(v3_test_path_curdir)*/*mk)
v3_test_names                := $(basename $(notdir $(v3_test_child_makefiles)))
v3_test_all_targets          := $(foreach v3_test,$(v3_test_names),$(v3_test)_all_tests)
v3_test_clean_targets        := $(foreach v3_test,$(v3_test_names),$(v3_test)_clean_tests)
v3_test_install_path         := $(v3_test_path_curdir)$(v3_test_name_curdir)$(EXT_EXE)
v3_test_sources              := $(wildcard $(v3_test_path_curdir)*.c)
v3_test_objects              := $(patsubst %.c, %.o, $(v3_test_sources))
v3_test_depends              := $(patsubst %.c, %.d, $(v3_test_sources))
v3_test_depends_modules      := v3
v3_test_depends_libs         := $(foreach module,$(v3_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
v3_test_depends_libs_rules   := $(foreach module,$(v3_test_depends_modules),$(module)_all)

include $(v3_test_child_makefiles)

ifneq ($(v3_test_objects),)

$(v3_test_path_curdir)%.o: $(v3_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(v3_test_install_path): | $(v3_test_depends_libs_rules)
$(v3_test_install_path): $(v3_test_objects)
	$(CC) -o $@ $^ $(v3_test_depends_libs)

.PHONY: v3_test_all
v3_test_all: $(v3_test_install_path) ## build all v3_test tests

.PHONY: v3_test_clean
v3_test_clean: ## remove all v3_test tests
	- $(RM) $(v3_test_install_path) $(v3_test_objects) $(v3_test_depends)

else

.PHONY: v3_test_all
v3_test_all: $(v3_test_all_targets) ## build all v3_test tests

.PHONY: v3_test_clean
v3_test_clean: $(v3_test_clean_targets) ## remove all v3_test tests

endif

-include $(v3_test_depends)
