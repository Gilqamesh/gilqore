lerp_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
lerp_test_name_curdir          := $(notdir $(patsubst %/,%,$(lerp_test_path_curdir)))
lerp_test_child_makefiles      := $(wildcard $(lerp_test_path_curdir)*/*mk)
lerp_test_names                := $(basename $(notdir $(lerp_test_child_makefiles)))
lerp_test_all_targets          := $(foreach lerp_test,$(lerp_test_names),$(lerp_test)_all_tests)
lerp_test_clean_targets        := $(foreach lerp_test,$(lerp_test_names),$(lerp_test)_clean_tests)
lerp_test_install_path         := $(lerp_test_path_curdir)$(lerp_test_name_curdir)$(EXT_EXE)
lerp_test_sources              := $(wildcard $(lerp_test_path_curdir)*.c)
lerp_test_objects              := $(patsubst %.c, %.o, $(lerp_test_sources))
lerp_test_depends              := $(patsubst %.c, %.d, $(lerp_test_sources))
lerp_test_depends_modules      := lerp
lerp_test_depends_libs         := $(foreach module,$(lerp_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
lerp_test_depends_libs_rules   := $(foreach module,$(lerp_test_depends_modules),$(module)_all)

include $(lerp_test_child_makefiles)

ifneq ($(lerp_test_objects),)

$(lerp_test_path_curdir)%.o: $(lerp_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(lerp_test_install_path): | $(lerp_test_depends_libs_rules)
$(lerp_test_install_path): $(lerp_test_objects)
	$(CC) -o $@ $^ $(lerp_test_depends_libs)

.PHONY: lerp_test_all
lerp_test_all: $(lerp_test_install_path) ## build all lerp_test tests

.PHONY: lerp_test_clean
lerp_test_clean: ## remove all lerp_test tests
	- $(RM) $(lerp_test_install_path) $(lerp_test_objects) $(lerp_test_depends)

else

.PHONY: lerp_test_all
lerp_test_all: $(lerp_test_all_targets) ## build all lerp_test tests

.PHONY: lerp_test_clean
lerp_test_clean: $(lerp_test_clean_targets) ## remove all lerp_test tests

endif

-include $(lerp_test_depends)
