clamp_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
clamp_test_name_curdir          := $(notdir $(patsubst %/,%,$(clamp_test_path_curdir)))
clamp_test_child_makefiles      := $(wildcard $(clamp_test_path_curdir)*/*mk)
clamp_test_names                := $(basename $(notdir $(clamp_test_child_makefiles)))
clamp_test_all_targets          := $(foreach clamp_test,$(clamp_test_names),$(clamp_test)_all)
clamp_test_clean_targets        := $(foreach clamp_test,$(clamp_test_names),$(clamp_test)_clean)
clamp_test_run_targets          := $(foreach clamp_test,$(clamp_test_names),$(clamp_test)_run)
clamp_test_install_path         := $(clamp_test_path_curdir)$(clamp_test_name_curdir)$(EXT_EXE)
clamp_test_sources              := $(wildcard $(clamp_test_path_curdir)*.c)
clamp_test_objects              := $(patsubst %.c, %.o, $(clamp_test_sources))
clamp_test_depends              := $(patsubst %.c, %.d, $(clamp_test_sources))
clamp_test_depends_modules      := clamp
clamp_test_depends_libs_static  := $(foreach module,$(clamp_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
clamp_test_depends_libs_shared  := $(foreach module,$(clamp_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
clamp_test_depends_libs_rules   := $(foreach module,$(clamp_test_depends_modules),$(module)_all)

include $(clamp_test_child_makefiles)

$(clamp_test_path_curdir)%.o: $(clamp_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(clamp_test_install_path): | $(clamp_test_depends_libs_rules)
$(clamp_test_install_path): $(clamp_test_objects)
	$(CC) -o $@ $^ $(clamp_test_depends_libs_static)

.PHONY: clamp_test_all
clamp_test_all: $(clamp_test_all_targets) ## build all clamp_test tests
ifneq ($(clamp_test_objects),)
clamp_test_all: $(clamp_test_install_path)
endif

.PHONY: clamp_test_clean
clamp_test_clean: $(clamp_test_clean_targets) ## remove all clamp_test tests
clamp_test_clean:
	- $(RM) $(clamp_test_install_path) $(clamp_test_objects) $(clamp_test_depends)

.PHONY: clamp_test_run
clamp_test_run: clamp_test_all ## build and run clamp_test
clamp_test_run: $(clamp_test_run_targets)
ifneq ($(clamp_test_objects),)
clamp_test_run:
	@python $(PATH_MK_FILES)/pytester.py $(clamp_test_install_path)
endif

-include $(clamp_test_depends)
