random_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
random_test_name_curdir          := $(notdir $(patsubst %/,%,$(random_test_path_curdir)))
random_test_child_makefiles      := $(wildcard $(random_test_path_curdir)*/*mk)
random_test_names                := $(basename $(notdir $(random_test_child_makefiles)))
random_test_all_targets          := $(foreach random_test,$(random_test_names),$(random_test)_all_tests)
random_test_clean_targets        := $(foreach random_test,$(random_test_names),$(random_test)_clean_tests)
random_test_install_path         := $(random_test_path_curdir)$(random_test_name_curdir)$(EXT_EXE)
random_test_sources              := $(wildcard $(random_test_path_curdir)*.c)
random_test_objects              := $(patsubst %.c, %.o, $(random_test_sources))
random_test_depends              := $(patsubst %.c, %.d, $(random_test_sources))
random_test_depends_modules      := random
random_test_depends_libs_static  := $(foreach module,$(random_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
random_test_depends_libs_shared  := $(foreach module,$(random_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
random_test_depends_libs_rules   := $(foreach module,$(random_test_depends_modules),$(module)_all)

include $(random_test_child_makefiles)

$(random_test_path_curdir)%.o: $(random_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(random_test_install_path): | $(random_test_depends_libs_rules)
$(random_test_install_path): $(random_test_objects)
	$(CC) -o $@ $^ $(random_test_depends_libs_static)

.PHONY: random_test_all
random_test_all: $(random_test_all_targets) ## build all random_test tests
ifneq ($(random_test_objects),)
random_test_all: $(random_test_install_path)
endif

.PHONY: random_test_clean
random_test_clean: $(random_test_clean_targets) ## remove all random_test tests
random_test_clean:
	- $(RM) $(random_test_install_path) $(random_test_objects) $(random_test_depends)


-include $(random_test_depends)
