riff_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
riff_test_child_makefiles			        := $(wildcard $(riff_test_path_curdir)*/*mk)
riff_test_child_module_names		        := $(basename $(notdir $(riff_test_child_makefiles)))
riff_test_child_all_targets		        := $(foreach test_module,$(riff_test_child_module_names),$(test_module)_all)
riff_test_child_clean_targets		        := $(foreach test_module,$(riff_test_child_module_names),$(test_module)_clean)
riff_test_child_run_targets		        := $(foreach test_module,$(riff_test_child_module_names),$(test_module)_run)
riff_test_install_path_static		        := $(riff_test_path_curdir)riff_static$(EXT_EXE)
riff_test_sources					        := $(wildcard $(riff_test_path_curdir)*.c)
riff_test_objects					        := $(patsubst %.c, %.o, $(riff_test_sources))
riff_test_depends					        := $(patsubst %.c, %.d, $(riff_test_sources))
riff_test_depends_modules			        := 
riff_test_depends_modules			        += riff
riff_test_libdepend_static_objs	        := $(foreach dep_module,$(riff_depends_modules),$($(dep_module)_static_objects))
riff_test_libdepend_static_objs	        += $(foreach dep_module,$(riff_test_depends_modules),$($(dep_module)_static_objects))

include $(riff_test_child_makefiles)

$(riff_test_path_curdir)%.o: $(riff_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(riff_test_install_path_static): $(riff_test_objects) $(riff_test_libdepend_static_objs)
	$(CC) -o $@ $(riff_test_objects) -Wl,--allow-multiple-definition $(riff_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: riff_test_all
riff_test_all: $(riff_test_child_all_targets) ## build all riff_test tests
ifneq ($(riff_test_objects),)
riff_test_all: $(riff_test_install_path_static)
endif

.PHONY: riff_test_clean
riff_test_clean: $(riff_test_child_clean_targets) ## remove all riff_test tests
riff_test_clean:
	- $(RM) $(riff_test_install_path_static) $(riff_test_objects) $(riff_test_depends)

.PHONY: riff_test_re
riff_test_re: riff_test_clean
riff_test_re: riff_test_all

.PHONY: riff_test_run_all
riff_test_run_all: riff_test_all ## build and run static riff_test
riff_test_run_all: $(riff_test_child_run_targets)
ifneq ($(riff_test_objects),)
riff_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(riff_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(riff_test_install_path_static)
endif

.PHONY: riff_test_run
riff_test_run: riff_test_all
ifneq ($(riff_test_objects),)
riff_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(riff_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(riff_test_install_path_static)
endif

-include $(riff_test_depends)
