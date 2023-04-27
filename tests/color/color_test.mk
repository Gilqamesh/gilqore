color_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
color_test_name_curdir          := $(notdir $(patsubst %/,%,$(color_test_path_curdir)))
color_test_child_makefiles      := $(wildcard $(color_test_path_curdir)*/*mk)
color_test_names                := $(basename $(notdir $(color_test_child_makefiles)))
color_test_all_targets          := $(foreach color_test,$(color_test_names),$(color_test)_all)
color_test_clean_targets        := $(foreach color_test,$(color_test_names),$(color_test)_clean)
color_test_run_targets          := $(foreach color_test,$(color_test_names),$(color_test)_run)
color_test_install_path         := $(color_test_path_curdir)$(color_test_name_curdir)$(EXT_EXE)
color_test_sources              := $(wildcard $(color_test_path_curdir)*.c)
color_test_objects              := $(patsubst %.c, %.o, $(color_test_sources))
color_test_depends              := $(patsubst %.c, %.d, $(color_test_sources))
color_test_depends_modules      := color
color_test_depends_libs_static  := $(foreach module,$(color_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
color_test_depends_libs_shared  := $(foreach module,$(color_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
color_test_depends_libs_rules   := $(foreach module,$(color_test_depends_modules),$(module)_all)

include $(color_test_child_makefiles)

$(color_test_path_curdir)%.o: $(color_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(color_test_install_path): | $(color_test_depends_libs_rules)
$(color_test_install_path): $(color_test_objects)
	$(CC) -o $@ $^ $(color_test_depends_libs_static)

.PHONY: color_test_all
color_test_all: $(color_test_all_targets) ## build all color_test tests
ifneq ($(color_test_objects),)
color_test_all: $(color_test_install_path)
endif

.PHONY: color_test_clean
color_test_clean: $(color_test_clean_targets) ## remove all color_test tests
color_test_clean:
	- $(RM) $(color_test_install_path) $(color_test_objects) $(color_test_depends)

.PHONY: color_test_run
color_test_run: color_test_all ## build and run color_test
color_test_run: $(color_test_run_targets)
ifneq ($(color_test_objects),)
color_test_run:
	@python $(PATH_MK_FILES)/pytester.py $(color_test_install_path)
endif

-include $(color_test_depends)
