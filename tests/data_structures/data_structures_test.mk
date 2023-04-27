data_structures_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
data_structures_test_name_curdir          := $(notdir $(patsubst %/,%,$(data_structures_test_path_curdir)))
data_structures_test_child_makefiles      := $(wildcard $(data_structures_test_path_curdir)*/*mk)
data_structures_test_names                := $(basename $(notdir $(data_structures_test_child_makefiles)))
data_structures_test_all_targets          := $(foreach data_structures_test,$(data_structures_test_names),$(data_structures_test)_all_tests)
data_structures_test_clean_targets        := $(foreach data_structures_test,$(data_structures_test_names),$(data_structures_test)_clean_tests)
data_structures_test_install_path         := $(data_structures_test_path_curdir)$(data_structures_test_name_curdir)$(EXT_EXE)
data_structures_test_sources              := $(wildcard $(data_structures_test_path_curdir)*.c)
data_structures_test_objects              := $(patsubst %.c, %.o, $(data_structures_test_sources))
data_structures_test_depends              := $(patsubst %.c, %.d, $(data_structures_test_sources))
data_structures_test_depends_modules      := data_structures
data_structures_test_depends_libs_static  := $(foreach module,$(data_structures_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
data_structures_test_depends_libs_shared  := $(foreach module,$(data_structures_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
data_structures_test_depends_libs_rules   := $(foreach module,$(data_structures_test_depends_modules),$(module)_all)

include $(data_structures_test_child_makefiles)

$(data_structures_test_path_curdir)%.o: $(data_structures_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(data_structures_test_install_path): | $(data_structures_test_depends_libs_rules)
$(data_structures_test_install_path): $(data_structures_test_objects)
	$(CC) -o $@ $^ $(data_structures_test_depends_libs_static)

.PHONY: data_structures_test_all
data_structures_test_all: $(data_structures_test_all_targets) ## build all data_structures_test tests
ifneq ($(data_structures_test_objects),)
data_structures_test_all: $(data_structures_test_install_path)
endif

.PHONY: data_structures_test_clean
data_structures_test_clean: $(data_structures_test_clean_targets) ## remove all data_structures_test tests
data_structures_test_clean:
	- $(RM) $(data_structures_test_install_path) $(data_structures_test_objects) $(data_structures_test_depends)


-include $(data_structures_test_depends)
