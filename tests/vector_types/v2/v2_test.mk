v2_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
v2_test_name_curdir          := $(notdir $(patsubst %/,%,$(v2_test_path_curdir)))
v2_test_child_makefiles      := $(wildcard $(v2_test_path_curdir)*/*mk)
v2_test_names                := $(basename $(notdir $(v2_test_child_makefiles)))
v2_test_all_targets          := $(foreach v2_test,$(v2_test_names),$(v2_test)_all_tests)
v2_test_clean_targets        := $(foreach v2_test,$(v2_test_names),$(v2_test)_clean_tests)
v2_test_install_path         := $(v2_test_path_curdir)$(v2_test_name_curdir)$(EXT_EXE)
v2_test_sources              := $(wildcard $(v2_test_path_curdir)*.c)
v2_test_objects              := $(patsubst %.c, %.o, $(v2_test_sources))
v2_test_depends              := $(patsubst %.c, %.d, $(v2_test_sources))
v2_test_depends_modules      := v2
v2_test_depends_libs         := $(foreach module,$(v2_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
v2_test_depends_libs_rules   := $(foreach module,$(v2_test_depends_modules),$(module)_all)

include $(v2_test_child_makefiles)

ifneq ($(v2_test_objects),)

$(v2_test_path_curdir)%.o: $(v2_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(v2_test_install_path): | $(v2_test_depends_libs_rules)
$(v2_test_install_path): $(v2_test_objects)
	$(CC) -o $@ $^ $(v2_test_depends_libs)

.PHONY: v2_test_all
v2_test_all: $(v2_test_install_path) ## build all v2_test tests

.PHONY: v2_test_clean
v2_test_clean: ## remove all v2_test tests
	- $(RM) $(v2_test_install_path) $(v2_test_objects) $(v2_test_depends)

else

.PHONY: v2_test_all
v2_test_all: $(v2_test_all_targets) ## build all v2_test tests

.PHONY: v2_test_clean
v2_test_clean: $(v2_test_clean_targets) ## remove all v2_test tests

endif

-include $(v2_test_depends)
