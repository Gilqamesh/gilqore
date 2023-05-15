circular_buffer_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
circular_buffer_test_child_makefiles			        := $(wildcard $(circular_buffer_test_path_curdir)*/*mk)
circular_buffer_test_child_module_names		        := $(basename $(notdir $(circular_buffer_test_child_makefiles)))
circular_buffer_test_child_all_targets		        := $(foreach test_module,$(circular_buffer_test_child_module_names),$(test_module)_all)
circular_buffer_test_child_clean_targets		        := $(foreach test_module,$(circular_buffer_test_child_module_names),$(test_module)_clean)
circular_buffer_test_child_run_targets		        := $(foreach test_module,$(circular_buffer_test_child_module_names),$(test_module)_run)
circular_buffer_test_install_path_static		        := $(circular_buffer_test_path_curdir)circular_buffer_static$(EXT_EXE)
circular_buffer_test_sources					        := $(wildcard $(circular_buffer_test_path_curdir)*.c)
circular_buffer_test_objects					        := $(patsubst %.c, %.o, $(circular_buffer_test_sources))
circular_buffer_test_depends					        := $(patsubst %.c, %.d, $(circular_buffer_test_sources))
circular_buffer_test_depends_modules			        := libc common compare mod 
circular_buffer_test_depends_modules			        += circular_buffer
circular_buffer_test_libdepend_static_objs	        := $(foreach dep_module,$(circular_buffer_depends_modules),$($(dep_module)_static_objects))
circular_buffer_test_libdepend_static_objs	        += $(foreach dep_module,$(circular_buffer_test_depends_modules),$($(dep_module)_static_objects))

include $(circular_buffer_test_child_makefiles)

$(circular_buffer_test_path_curdir)%.o: $(circular_buffer_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(circular_buffer_test_install_path_static): $(circular_buffer_test_objects) $(circular_buffer_test_libdepend_static_objs)
	$(CC) -o $@ $(circular_buffer_test_objects) -Wl,--allow-multiple-definition $(circular_buffer_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: circular_buffer_test_all
circular_buffer_test_all: $(circular_buffer_test_child_all_targets) ## build all circular_buffer_test tests
ifneq ($(circular_buffer_test_objects),)
circular_buffer_test_all: $(circular_buffer_test_install_path_static)
endif

.PHONY: circular_buffer_test_clean
circular_buffer_test_clean: $(circular_buffer_test_child_clean_targets) ## remove all circular_buffer_test tests
circular_buffer_test_clean:
	- $(RM) $(circular_buffer_test_install_path_static) $(circular_buffer_test_objects) $(circular_buffer_test_depends)

.PHONY: circular_buffer_test_re
circular_buffer_test_re: circular_buffer_test_clean
circular_buffer_test_re: circular_buffer_test_all

.PHONY: circular_buffer_test_run_all
circular_buffer_test_run_all: circular_buffer_test_all ## build and run static circular_buffer_test
circular_buffer_test_run_all: $(circular_buffer_test_child_run_targets)
ifneq ($(circular_buffer_test_objects),)
circular_buffer_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(circular_buffer_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(circular_buffer_test_install_path_static)
endif

.PHONY: circular_buffer_test_run
circular_buffer_test_run: circular_buffer_test_all
ifneq ($(circular_buffer_test_objects),)
circular_buffer_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(circular_buffer_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(circular_buffer_test_install_path_static)
endif

-include $(circular_buffer_test_depends)
