io_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
io_test_child_makefiles			        := $(wildcard $(io_test_path_curdir)*/*mk)
io_test_child_module_names		        := $(basename $(notdir $(io_test_child_makefiles)))
io_test_child_all_targets		        := $(foreach test_module,$(io_test_child_module_names),$(test_module)_all)
io_test_child_clean_targets		        := $(foreach test_module,$(io_test_child_module_names),$(test_module)_clean)
io_test_child_run_targets		        := $(foreach test_module,$(io_test_child_module_names),$(test_module)_run)
io_test_install_path_static		        := $(io_test_path_curdir)io_static$(EXT_EXE)
io_test_sources					        := $(wildcard $(io_test_path_curdir)*.c)
io_test_objects					        := $(patsubst %.c, %.o, $(io_test_sources))
io_test_depends					        := $(patsubst %.c, %.d, $(io_test_sources))
io_test_depends_modules			        := 
io_test_depends_modules			        += io
io_test_libdepend_static_objs	        := $(foreach dep_module,$(io_depends_modules),$($(dep_module)_static_objects))
io_test_libdepend_static_objs	        += $(foreach dep_module,$(io_test_depends_modules),$($(dep_module)_static_objects))

include $(io_test_child_makefiles)

$(io_test_path_curdir)%.o: $(io_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(io_test_install_path_static): $(io_test_objects) $(io_test_libdepend_static_objs)
	$(CC) -o $@ $(io_test_objects) -Wl,--allow-multiple-definition $(io_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: io_test_all
io_test_all: $(io_test_child_all_targets) ## build all io_test tests
ifneq ($(io_test_objects),)
io_test_all: $(io_test_install_path_static)
endif

.PHONY: io_test_clean
io_test_clean: $(io_test_child_clean_targets) ## remove all io_test tests
io_test_clean:
	- $(RM) $(io_test_install_path_static) $(io_test_objects) $(io_test_depends)

.PHONY: io_test_re
io_test_re: io_test_clean
io_test_re: io_test_all

.PHONY: io_test_run_all
io_test_run_all: io_test_all ## build and run static io_test
io_test_run_all: $(io_test_child_run_targets)
ifneq ($(io_test_objects),)
io_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(io_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(io_test_install_path_static)
endif

.PHONY: io_test_run
io_test_run: io_test_all
ifneq ($(io_test_objects),)
io_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(io_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(io_test_install_path_static)
endif

-include $(io_test_depends)
