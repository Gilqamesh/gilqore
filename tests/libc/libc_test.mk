libc_test_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
libc_test_name_curdir          := $(notdir $(patsubst %/,%,$(libc_test_path_curdir)))
libc_test_child_makefiles      := $(wildcard $(libc_test_path_curdir)*/*mk)
libc_test_names                := $(basename $(notdir $(libc_test_child_makefiles)))
libc_test_all_targets          := $(foreach libc_test,$(libc_test_names),$(libc_test)_all_tests)
libc_test_clean_targets        := $(foreach libc_test,$(libc_test_names),$(libc_test)_clean_tests)
libc_test_install_path         := $(libc_test_path_curdir)$(libc_test_name_curdir)$(EXT_EXE)
libc_test_sources              := $(wildcard $(libc_test_path_curdir)*.c)
libc_test_objects              := $(patsubst %.c, %.o, $(libc_test_sources))
libc_test_depends              := $(patsubst %.c, %.d, $(libc_test_sources))
libc_test_depends_modules      := libc
libc_test_depends_libs_static  := $(foreach module,$(libc_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
libc_test_depends_libs_shared  := $(foreach module,$(libc_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
libc_test_depends_libs_rules   := $(foreach module,$(libc_test_depends_modules),$(module)_all)

include $(libc_test_child_makefiles)

$(libc_test_path_curdir)%.o: $(libc_test_path_curdir)%.c
	$(CC) -c $< -o $@ -I$(PATH_MODULES)

$(libc_test_install_path): | $(libc_test_depends_libs_rules)
$(libc_test_install_path): $(libc_test_objects)
	$(CC) -o $@ $^ $(libc_test_depends_libs_static)

.PHONY: libc_test_all
libc_test_all: $(libc_test_all_targets) ## build all libc_test tests
ifneq ($(libc_test_objects),)
libc_test_all: $(libc_test_install_path)
endif

.PHONY: libc_test_clean
libc_test_clean: $(libc_test_clean_targets) ## remove all libc_test tests
libc_test_clean:
	- $(RM) $(libc_test_install_path) $(libc_test_objects) $(libc_test_depends)


-include $(libc_test_depends)
