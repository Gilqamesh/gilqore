clamp_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
clamp_test_name_curdir          := $(notdir $(patsubst %/,%,$(clamp_test_path_curdir)))
clamp_test_child_makefiles      := $(wildcard $(clamp_test_path_curdir)*/*mk)
clamp_test_names                := $(basename $(notdir $(clamp_test_child_makefiles)))
clamp_test_all_targets          := $(foreach clamp_test,$(clamp_test_names),$(clamp_test)_all_tests)
clamp_test_clean_targets        := $(foreach clamp_test,$(clamp_test_names),$(clamp_test)_clean_tests)
clamp_test_install_path         := $(clamp_test_path_curdir)$(clamp_test_name_curdir)$(EXT_EXE)
clamp_test_sources              := $(wildcard $(clamp_test_path_curdir)*.c)
clamp_test_objects              := $(patsubst %.c, %.o, $(clamp_test_sources))
clamp_test_depends              := $(patsubst %.c, %.d, $(clamp_test_sources))
clamp_test_depends_modules      := clamp
clamp_test_depends_libs         := $(foreach module,$(clamp_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
clamp_test_depends_libs_rules   := $(foreach module,$(clamp_test_depends_modules),$(module)_all)

include $(clamp_test_child_makefiles)

ifneq ($(clamp_test_objects),)

$(clamp_test_path_curdir)%.o: $(clamp_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(clamp_test_install_path): | $(clamp_test_depends_libs_rules)
$(clamp_test_install_path): $(clamp_test_objects)
	$(CC) -o $@ $^ $(clamp_test_depends_libs)

.PHONY: clamp_test_all
clamp_test_all: $(clamp_test_install_path) ## build all clamp_test tests

.PHONY: clamp_test_clean
clamp_test_clean: ## remove all clamp_test tests
	- $(RM) $(clamp_test_install_path) $(clamp_test_objects) $(clamp_test_depends)

else

.PHONY: clamp_test_all
clamp_test_all: $(clamp_test_all_targets) ## build all clamp_test tests

.PHONY: clamp_test_clean
clamp_test_clean: $(clamp_test_clean_targets) ## remove all clamp_test tests

endif

-include $(clamp_test_depends)
