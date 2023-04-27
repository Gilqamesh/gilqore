common_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
common_test_name_curdir          := $(notdir $(patsubst %/,%,$(common_test_path_curdir)))
common_test_child_makefiles      := $(wildcard $(common_test_path_curdir)*/*mk)
common_test_names                := $(basename $(notdir $(common_test_child_makefiles)))
common_test_all_targets          := $(foreach common_test,$(common_test_names),$(common_test)_all)
common_test_clean_targets        := $(foreach common_test,$(common_test_names),$(common_test)_clean)
common_test_run_targets          := $(foreach common_test,$(common_test_names),$(common_test)_run)
common_test_install_path         := $(common_test_path_curdir)$(common_test_name_curdir)$(EXT_EXE)
common_test_sources              := $(wildcard $(common_test_path_curdir)*.c)
common_test_objects              := $(patsubst %.c, %.o, $(common_test_sources))
common_test_depends              := $(patsubst %.c, %.d, $(common_test_sources))
common_test_depends_modules      := common
common_test_depends_libs_static  := $(foreach module,$(common_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
common_test_depends_libs_shared  := $(foreach module,$(common_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
common_test_depends_libs_rules   := $(foreach module,$(common_test_depends_modules),$(module)_all)

include $(common_test_child_makefiles)

$(common_test_path_curdir)%.o: $(common_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(common_test_install_path): | $(common_test_depends_libs_rules)
$(common_test_install_path): $(common_test_objects)
	$(CC) -o $@ $^ $(common_test_depends_libs_static)

.PHONY: common_test_all
common_test_all: $(common_test_all_targets) ## build all common_test tests
ifneq ($(common_test_objects),)
common_test_all: $(common_test_install_path)
endif

.PHONY: common_test_clean
common_test_clean: $(common_test_clean_targets) ## remove all common_test tests
common_test_clean:
	- $(RM) $(common_test_install_path) $(common_test_objects) $(common_test_depends)

.PHONY: common_test_run
common_test_run: common_test_all ## build and run common_test
common_test_run: $(common_test_run_targets)
ifneq ($(common_test_objects),)
common_test_run:
	@python $(PATH_MK_FILES)/pytester.py $(common_test_install_path)
endif

-include $(common_test_depends)
