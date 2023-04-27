vector_types_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
vector_types_test_name_curdir          := $(notdir $(patsubst %/,%,$(vector_types_test_path_curdir)))
vector_types_test_child_makefiles      := $(wildcard $(vector_types_test_path_curdir)*/*mk)
vector_types_test_names                := $(basename $(notdir $(vector_types_test_child_makefiles)))
vector_types_test_all_targets          := $(foreach vector_types_test,$(vector_types_test_names),$(vector_types_test)_all_tests)
vector_types_test_clean_targets        := $(foreach vector_types_test,$(vector_types_test_names),$(vector_types_test)_clean_tests)
vector_types_test_install_path         := $(vector_types_test_path_curdir)$(vector_types_test_name_curdir)$(EXT_EXE)
vector_types_test_sources              := $(wildcard $(vector_types_test_path_curdir)*.c)
vector_types_test_objects              := $(patsubst %.c, %.o, $(vector_types_test_sources))
vector_types_test_depends              := $(patsubst %.c, %.d, $(vector_types_test_sources))
vector_types_test_depends_modules      := vector_types
vector_types_test_depends_libs         := $(foreach module,$(vector_types_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
vector_types_test_depends_libs_rules   := $(foreach module,$(vector_types_test_depends_modules),$(module)_all)

include $(vector_types_test_child_makefiles)

ifneq ($(vector_types_test_objects),)

$(vector_types_test_path_curdir)%.o: $(vector_types_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(vector_types_test_install_path): | $(vector_types_test_depends_libs_rules)
$(vector_types_test_install_path): $(vector_types_test_objects)
	$(CC) -o $@ $^ $(vector_types_test_depends_libs)

.PHONY: vector_types_test_all
vector_types_test_all: $(vector_types_test_install_path) ## build all vector_types_test tests

.PHONY: vector_types_test_clean
vector_types_test_clean: ## remove all vector_types_test tests
	- $(RM) $(vector_types_test_install_path) $(vector_types_test_objects) $(vector_types_test_depends)

else

.PHONY: vector_types_test_all
vector_types_test_all: $(vector_types_test_all_targets) ## build all vector_types_test tests

.PHONY: vector_types_test_clean
vector_types_test_clean: $(vector_types_test_clean_targets) ## remove all vector_types_test tests

endif

-include $(vector_types_test_depends)
