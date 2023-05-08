clamp_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
clamp_test_child_makefiles			        := $(wildcard $(clamp_test_path_curdir)*/*mk)
clamp_test_child_module_names		        := $(basename $(notdir $(clamp_test_child_makefiles)))
clamp_test_child_all_targets		        := $(foreach test_module,$(clamp_test_child_module_names),$(test_module)_all)
clamp_test_child_clean_targets		        := $(foreach test_module,$(clamp_test_child_module_names),$(test_module)_clean)
clamp_test_child_run_targets		        := $(foreach test_module,$(clamp_test_child_module_names),$(test_module)_run)
clamp_test_install_path_static		        := $(clamp_test_path_curdir)clamp_static$(EXT_EXE)
clamp_test_sources					        := $(wildcard $(clamp_test_path_curdir)*.c)
clamp_test_objects					        := $(patsubst %.c, %.o, $(clamp_test_sources))
clamp_test_depends					        := $(patsubst %.c, %.d, $(clamp_test_sources))
clamp_test_depends_modules			        := 
# clamp_test_depends_modules			        += test_framework
clamp_test_depends_modules			        += clamp
clamp_test_libdepend_static_objs	        := $(foreach dep_module,$(clamp_depends_modules),$($(dep_module)_static_objects))
clamp_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(clamp_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
clamp_test_libdepend_static_objs	        += $(foreach dep_module,$(clamp_test_depends_modules),$($(dep_module)_static_objects))

include $(clamp_test_child_makefiles)

$(clamp_test_path_curdir)%.o: $(clamp_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(clamp_test_install_path_static): $(clamp_test_libdepend_static_objs)
$(clamp_test_install_path_static): $(clamp_test_objects)
	$(CC) -o $@ $(clamp_test_objects) -Wl,--allow-multiple-definition $(clamp_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: clamp_test_all
clamp_test_all: $(clamp_test_child_all_targets) ## build all clamp_test tests
ifneq ($(clamp_test_objects),)
clamp_test_all: $(clamp_test_install_path_static)
endif

.PHONY: clamp_test_clean
clamp_test_clean: $(clamp_test_child_clean_targets) ## remove all clamp_test tests
clamp_test_clean:
	- $(RM) $(clamp_test_install_path_static) $(clamp_test_objects) $(clamp_test_depends)

.PHONY: clamp_test_re
clamp_test_re: clamp_test_clean
clamp_test_re: clamp_test_all

.PHONY: clamp_test_run_all
clamp_test_run_all: clamp_test_all ## build and run static clamp_test
clamp_test_run_all: $(clamp_test_child_run_targets)
ifneq ($(clamp_test_objects),)
clamp_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(clamp_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(clamp_test_install_path_static)
endif

.PHONY: clamp_test_run
clamp_test_run: clamp_test_all
ifneq ($(clamp_test_objects),)
clamp_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(clamp_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(clamp_test_install_path_static)
endif

-include $(clamp_test_depends)
