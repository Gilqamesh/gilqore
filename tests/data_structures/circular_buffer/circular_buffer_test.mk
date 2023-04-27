circular_buffer_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
circular_buffer_test_name_curdir          := $(notdir $(patsubst %/,%,$(circular_buffer_test_path_curdir)))
circular_buffer_test_child_makefiles      := $(wildcard $(circular_buffer_test_path_curdir)*/*mk)
circular_buffer_test_names                := $(basename $(notdir $(circular_buffer_test_child_makefiles)))
circular_buffer_test_all_targets          := $(foreach circular_buffer_test,$(circular_buffer_test_names),$(circular_buffer_test)_all_tests)
circular_buffer_test_clean_targets        := $(foreach circular_buffer_test,$(circular_buffer_test_names),$(circular_buffer_test)_clean_tests)
circular_buffer_test_install_path         := $(circular_buffer_test_path_curdir)$(circular_buffer_test_name_curdir)$(EXT_EXE)
circular_buffer_test_sources              := $(wildcard $(circular_buffer_test_path_curdir)*.c)
circular_buffer_test_objects              := $(patsubst %.c, %.o, $(circular_buffer_test_sources))
circular_buffer_test_depends              := $(patsubst %.c, %.d, $(circular_buffer_test_sources))
circular_buffer_test_depends_modules      := circular_buffer
circular_buffer_test_depends_libs         := $(foreach module,$(circular_buffer_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
circular_buffer_test_depends_libs_rules   := $(foreach module,$(circular_buffer_test_depends_modules),$(module)_all)

include $(circular_buffer_test_child_makefiles)

ifneq ($(circular_buffer_test_objects),)

$(circular_buffer_test_path_curdir)%.o: $(circular_buffer_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(circular_buffer_test_install_path): | $(circular_buffer_test_depends_libs_rules)
$(circular_buffer_test_install_path): $(circular_buffer_test_objects)
	$(CC) -o $@ $^ $(circular_buffer_test_depends_libs)

.PHONY: circular_buffer_test_all
circular_buffer_test_all: $(circular_buffer_test_install_path) ## build all circular_buffer_test tests

.PHONY: circular_buffer_test_clean
circular_buffer_test_clean: ## remove all circular_buffer_test tests
	- $(RM) $(circular_buffer_test_install_path) $(circular_buffer_test_objects) $(circular_buffer_test_depends)

else

.PHONY: circular_buffer_test_all
circular_buffer_test_all: $(circular_buffer_test_all_targets) ## build all circular_buffer_test tests

.PHONY: circular_buffer_test_clean
circular_buffer_test_clean: $(circular_buffer_test_clean_targets) ## remove all circular_buffer_test tests

endif

-include $(circular_buffer_test_depends)
