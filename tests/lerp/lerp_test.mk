lerp_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
lerp_test_name_curdir          := $(notdir $(patsubst %/,%,$(lerp_test_path_curdir)))
lerp_test_child_makefiles      := $(wildcard $(lerp_test_path_curdir)*/*mk)
lerp_test_names                := $(basename $(notdir $(lerp_test_child_makefiles)))
lerp_test_all_targets          := $(foreach lerp_test,$(lerp_test_names),$(lerp_test)_all)
lerp_test_clean_targets        := $(foreach lerp_test,$(lerp_test_names),$(lerp_test)_clean)
lerp_test_run_targets          := $(foreach lerp_test,$(lerp_test_names),$(lerp_test)_run)
lerp_test_install_path         := $(lerp_test_path_curdir)$(lerp_test_name_curdir)$(EXT_EXE)
lerp_test_sources              := $(wildcard $(lerp_test_path_curdir)*.c)
lerp_test_objects              := $(patsubst %.c, %.o, $(lerp_test_sources))
lerp_test_depends              := $(patsubst %.c, %.d, $(lerp_test_sources))
lerp_test_depends_modules      := lerp
lerp_test_depends_libs_static  := $(foreach module,$(lerp_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
lerp_test_depends_libs_shared  := $(foreach module,$(lerp_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
lerp_test_depends_libs_rules   := $(foreach module,$(lerp_test_depends_modules),$(module)_all)

include $(lerp_test_child_makefiles)

$(lerp_test_path_curdir)%.o: $(lerp_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(lerp_test_install_path): | $(lerp_test_depends_libs_rules)
$(lerp_test_install_path): $(lerp_test_objects)
	$(CC) -o $@ $^ $(lerp_test_depends_libs_static)

.PHONY: lerp_test_all
lerp_test_all: $(lerp_test_all_targets) ## build all lerp_test tests
ifneq ($(lerp_test_objects),)
lerp_test_all: $(lerp_test_install_path)
endif

.PHONY: lerp_test_clean
lerp_test_clean: $(lerp_test_clean_targets) ## remove all lerp_test tests
lerp_test_clean:
	- $(RM) $(lerp_test_install_path) $(lerp_test_objects) $(lerp_test_depends)

.PHONY: lerp_test_run
lerp_test_run: lerp_test_all ## build and run lerp_test
lerp_test_run: $(lerp_test_run_targets)
ifneq ($(lerp_test_objects),)
lerp_test_run:
	@python $(PATH_MK_FILES)/pytester.py $(lerp_test_install_path)
endif

-include $(lerp_test_depends)
