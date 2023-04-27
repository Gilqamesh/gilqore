color_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
color_test_name_curdir          := $(notdir $(patsubst %/,%,$(color_test_path_curdir)))
color_test_child_makefiles      := $(wildcard $(color_test_path_curdir)*/*mk)
color_test_names                := $(basename $(notdir $(color_test_child_makefiles)))
color_test_all_targets          := $(foreach color_test,$(color_test_names),$(color_test)_all_tests)
color_test_clean_targets        := $(foreach color_test,$(color_test_names),$(color_test)_clean_tests)
color_test_install_path         := $(color_test_path_curdir)$(color_test_name_curdir)$(EXT_EXE)
color_test_sources              := $(wildcard $(color_test_path_curdir)*.c)
color_test_objects              := $(patsubst %.c, %.o, $(color_test_sources))
color_test_depends              := $(patsubst %.c, %.d, $(color_test_sources))
color_test_depends_modules      := color
color_test_depends_libs         := $(foreach module,$(color_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
color_test_depends_libs_rules   := $(foreach module,$(color_test_depends_modules),$(module)_all)

include $(color_test_child_makefiles)

ifneq ($(color_test_objects),)

$(color_test_path_curdir)%.o: $(color_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(color_test_install_path): | $(color_test_depends_libs_rules)
$(color_test_install_path): $(color_test_objects)
	$(CC) -o $@ $^ $(color_test_depends_libs)

.PHONY: color_test_all
color_test_all: $(color_test_install_path) ## build all color_test tests

.PHONY: color_test_clean
color_test_clean: ## remove all color_test tests
	- $(RM) $(color_test_install_path) $(color_test_objects) $(color_test_depends)

else

.PHONY: color_test_all
color_test_all: $(color_test_all_targets) ## build all color_test tests

.PHONY: color_test_clean
color_test_clean: $(color_test_clean_targets) ## remove all color_test tests

endif

-include $(color_test_depends)
