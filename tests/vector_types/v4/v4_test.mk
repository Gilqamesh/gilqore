v4_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
v4_test_name_curdir          := $(notdir $(patsubst %/,%,$(v4_test_path_curdir)))
v4_test_child_makefiles      := $(wildcard $(v4_test_path_curdir)*/*mk)
v4_test_names                := $(basename $(notdir $(v4_test_child_makefiles)))
v4_test_all_targets          := $(foreach v4_test,$(v4_test_names),$(v4_test)_all)
v4_test_clean_targets        := $(foreach v4_test,$(v4_test_names),$(v4_test)_clean)
v4_test_run_targets          := $(foreach v4_test,$(v4_test_names),$(v4_test)_run)
v4_test_install_path         := $(v4_test_path_curdir)$(v4_test_name_curdir)$(EXT_EXE)
v4_test_sources              := $(wildcard $(v4_test_path_curdir)*.c)
v4_test_objects              := $(patsubst %.c, %.o, $(v4_test_sources))
v4_test_depends              := $(patsubst %.c, %.d, $(v4_test_sources))
v4_test_depends_modules      := v4
v4_test_depends_libs_static  := $(foreach module,$(v4_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
v4_test_depends_libs_shared  := $(foreach module,$(v4_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
v4_test_depends_libs_rules   := $(foreach module,$(v4_test_depends_modules),$(module)_all)

include $(v4_test_child_makefiles)

$(v4_test_path_curdir)%.o: $(v4_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(v4_test_install_path): | $(v4_test_depends_libs_rules)
$(v4_test_install_path): $(v4_test_objects)
	$(CC) -o $@ $^ $(v4_test_depends_libs_static)

.PHONY: v4_test_all
v4_test_all: $(v4_test_all_targets) ## build all v4_test tests
ifneq ($(v4_test_objects),)
v4_test_all: $(v4_test_install_path)
endif

.PHONY: v4_test_clean
v4_test_clean: $(v4_test_clean_targets) ## remove all v4_test tests
v4_test_clean:
	- $(RM) $(v4_test_install_path) $(v4_test_objects) $(v4_test_depends)

.PHONY: v4_test_run
v4_test_run: v4_test_all ## build and run v4_test
v4_test_run: $(v4_test_run_targets)
ifneq ($(v4_test_objects),)
v4_test_run:
	@python $(PATH_MK_FILES)/pytester.py $(v4_test_install_path)
endif

-include $(v4_test_depends)
