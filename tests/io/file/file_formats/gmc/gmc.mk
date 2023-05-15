gmc_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
gmc_test_child_makefiles			        := $(wildcard $(gmc_test_path_curdir)*/*mk)
gmc_test_child_module_names		        := $(basename $(notdir $(gmc_test_child_makefiles)))
gmc_test_child_all_targets		        := $(foreach test_module,$(gmc_test_child_module_names),$(test_module)_all)
gmc_test_child_clean_targets		        := $(foreach test_module,$(gmc_test_child_module_names),$(test_module)_clean)
gmc_test_child_run_targets		        := $(foreach test_module,$(gmc_test_child_module_names),$(test_module)_run)
gmc_test_install_path_static		        := $(gmc_test_path_curdir)gmc_static$(EXT_EXE)
gmc_test_sources					        := $(wildcard $(gmc_test_path_curdir)*.c)
gmc_test_objects					        := $(patsubst %.c, %.o, $(gmc_test_sources))
gmc_test_depends					        := $(patsubst %.c, %.d, $(gmc_test_sources))
gmc_test_depends_modules			        := 
gmc_test_depends_modules			        += gmc
gmc_test_libdepend_static_objs	        := $(foreach dep_module,$(gmc_depends_modules),$($(dep_module)_static_objects))
gmc_test_libdepend_static_objs	        += $(foreach dep_module,$(gmc_test_depends_modules),$($(dep_module)_static_objects))

include $(gmc_test_child_makefiles)

$(gmc_test_path_curdir)%.o: $(gmc_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(gmc_test_install_path_static): $(gmc_test_objects) $(gmc_test_libdepend_static_objs)
	$(CC) -o $@ $(gmc_test_objects) -Wl,--allow-multiple-definition $(gmc_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: gmc_test_all
gmc_test_all: $(gmc_test_child_all_targets) ## build all gmc_test tests
ifneq ($(gmc_test_objects),)
gmc_test_all: $(gmc_test_install_path_static)
endif

.PHONY: gmc_test_clean
gmc_test_clean: $(gmc_test_child_clean_targets) ## remove all gmc_test tests
gmc_test_clean:
	- $(RM) $(gmc_test_install_path_static) $(gmc_test_objects) $(gmc_test_depends)

.PHONY: gmc_test_re
gmc_test_re: gmc_test_clean
gmc_test_re: gmc_test_all

.PHONY: gmc_test_run_all
gmc_test_run_all: gmc_test_all ## build and run static gmc_test
gmc_test_run_all: $(gmc_test_child_run_targets)
ifneq ($(gmc_test_objects),)
gmc_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(gmc_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(gmc_test_install_path_static)
endif

.PHONY: gmc_test_run
gmc_test_run: gmc_test_all
ifneq ($(gmc_test_objects),)
gmc_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(gmc_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(gmc_test_install_path_static)
endif

-include $(gmc_test_depends)
