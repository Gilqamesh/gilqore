tests_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
tests_test_name_curdir          := $(notdir $(patsubst %/,%,$(tests_test_path_curdir)))
tests_test_child_makefiles      := $(wildcard $(tests_test_path_curdir)*/*mk)
tests_test_names                := $(basename $(notdir $(tests_test_child_makefiles)))
tests_test_all_targets          := $(foreach tests_test,$(tests_test_names),$(tests_test)_all_tests)
tests_test_clean_targets        := $(foreach tests_test,$(tests_test_names),$(tests_test)_clean_tests)
tests_test_install_path         := $(tests_test_path_curdir)$(tests_test_name_curdir)$(EXT_EXE)
tests_test_sources              := $(wildcard $(tests_test_path_curdir)*.c)
tests_test_objects              := $(patsubst %.c, %.o, $(tests_test_sources))
tests_test_depends              := $(patsubst %.c, %.d, $(tests_test_sources))
tests_test_depends_modules      := tests
tests_test_depends_libs_static  := $(foreach module,$(tests_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
tests_test_depends_libs_shared  := $(foreach module,$(tests_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
tests_test_depends_libs_rules   := $(foreach module,$(tests_test_depends_modules),$(module)_all)

include $(tests_test_child_makefiles)

$(tests_test_path_curdir)%.o: $(tests_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(tests_test_install_path): | $(tests_test_depends_libs_rules)
$(tests_test_install_path): $(tests_test_objects)
	$(CC) -o $@ $^ $(tests_test_depends_libs_static)

.PHONY: tests_test_all
tests_test_all: $(tests_test_all_targets) ## build all tests_test tests
ifneq ($(tests_test_objects),)
tests_test_all: $(tests_test_install_path)
endif

.PHONY: tests_test_clean
tests_test_clean: $(tests_test_clean_targets) ## remove all tests_test tests
tests_test_clean:
	- $(RM) $(tests_test_install_path) $(tests_test_objects) $(tests_test_depends)


-include $(tests_test_depends)
