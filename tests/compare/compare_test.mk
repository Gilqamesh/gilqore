compare_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
compare_test_name_curdir          := $(notdir $(patsubst %/,%,$(compare_test_path_curdir)))
compare_test_child_makefiles      := $(wildcard $(compare_test_path_curdir)*/*mk)
compare_test_names                := $(basename $(notdir $(compare_test_child_makefiles)))
compare_test_all_targets          := $(foreach compare_test,$(compare_test_names),$(compare_test)_all)
compare_test_clean_targets        := $(foreach compare_test,$(compare_test_names),$(compare_test)_clean)
compare_test_run_targets          := $(foreach compare_test,$(compare_test_names),$(compare_test)_run)
compare_test_install_path         := $(compare_test_path_curdir)$(compare_test_name_curdir)$(EXT_EXE)
compare_test_sources              := $(wildcard $(compare_test_path_curdir)*.c)
compare_test_objects              := $(patsubst %.c, %.o, $(compare_test_sources))
compare_test_depends              := $(patsubst %.c, %.d, $(compare_test_sources))
compare_test_depends_modules      := compare
compare_test_depends_libs_static  := $(foreach module,$(compare_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
compare_test_depends_libs_shared  := $(foreach module,$(compare_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
compare_test_depends_libs_rules   := $(foreach module,$(compare_test_depends_modules),$(module)_all)

include $(compare_test_child_makefiles)

$(compare_test_path_curdir)%.o: $(compare_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(compare_test_install_path): | $(compare_test_depends_libs_rules)
$(compare_test_install_path): $(compare_test_objects)
	$(CC) -o $@ $^ $(compare_test_depends_libs_static)

.PHONY: compare_test_all
compare_test_all: $(compare_test_all_targets) ## build all compare_test tests
ifneq ($(compare_test_objects),)
compare_test_all: $(compare_test_install_path)
endif

.PHONY: compare_test_clean
compare_test_clean: $(compare_test_clean_targets) ## remove all compare_test tests
compare_test_clean:
	- $(RM) $(compare_test_install_path) $(compare_test_objects) $(compare_test_depends)

.PHONY: compare_test_run
compare_test_run: compare_test_all ## build and run compare_test
compare_test_run: $(compare_test_run_targets)
ifneq ($(compare_test_objects),)
compare_test_run:
	@python $(PATH_MK_FILES)/pytester.py $(compare_test_install_path)
endif

-include $(compare_test_depends)
