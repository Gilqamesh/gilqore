libc_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
libc_test_child_makefiles			        := $(wildcard $(libc_test_path_curdir)*/*mk)
libc_test_child_module_names		        := $(basename $(notdir $(libc_test_child_makefiles)))
libc_test_child_all_targets		        := $(foreach test_module,$(libc_test_child_module_names),$(test_module)_all)
libc_test_child_clean_targets		        := $(foreach test_module,$(libc_test_child_module_names),$(test_module)_clean)
libc_test_child_run_targets		        := $(foreach test_module,$(libc_test_child_module_names),$(test_module)_run)
libc_test_install_path_static		        := $(libc_test_path_curdir)libc_static$(EXT_EXE)
libc_test_sources					        := $(wildcard $(libc_test_path_curdir)*.c)
libc_test_objects					        := $(patsubst %.c, %.o, $(libc_test_sources))
libc_test_depends					        := $(patsubst %.c, %.d, $(libc_test_sources))
libc_test_depends_modules			        := common 
libc_test_depends_modules			        += libc
libc_test_libdepend_static_objs	        := $(foreach dep_module,$(libc_depends_modules),$($(dep_module)_static_objects))
libc_test_libdepend_static_objs	        += $(foreach dep_module,$(libc_test_depends_modules),$($(dep_module)_static_objects))

include $(libc_test_child_makefiles)

$(libc_test_path_curdir)%.o: $(libc_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(libc_test_install_path_static): $(libc_test_objects) $(libc_test_libdepend_static_objs)
	$(CC) -o $@ $(libc_test_objects) -Wl,--allow-multiple-definition $(libc_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: libc_test_all
libc_test_all: $(libc_test_child_all_targets) ## build all libc_test tests
ifneq ($(libc_test_objects),)
libc_test_all: $(libc_test_install_path_static)
endif

.PHONY: libc_test_clean
libc_test_clean: $(libc_test_child_clean_targets) ## remove all libc_test tests
libc_test_clean:
	- $(RM) $(libc_test_install_path_static) $(libc_test_objects) $(libc_test_depends)

.PHONY: libc_test_re
libc_test_re: libc_test_clean
libc_test_re: libc_test_all

.PHONY: libc_test_run_all
libc_test_run_all: libc_test_all ## build and run static libc_test
libc_test_run_all: $(libc_test_child_run_targets)
ifneq ($(libc_test_objects),)
libc_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(libc_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(libc_test_install_path_static)
endif

.PHONY: libc_test_run
libc_test_run: libc_test_all
ifneq ($(libc_test_objects),)
libc_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(libc_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(libc_test_install_path_static)
endif

-include $(libc_test_depends)
