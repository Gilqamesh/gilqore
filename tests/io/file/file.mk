file_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
file_test_child_makefiles			        := $(wildcard $(file_test_path_curdir)*/*mk)
file_test_child_module_names		        := $(basename $(notdir $(file_test_child_makefiles)))
file_test_child_all_targets		        := $(foreach test_module,$(file_test_child_module_names),$(test_module)_all)
file_test_child_clean_targets		        := $(foreach test_module,$(file_test_child_module_names),$(test_module)_clean)
file_test_child_run_targets		        := $(foreach test_module,$(file_test_child_module_names),$(test_module)_run)
file_test_install_path_static		        := $(file_test_path_curdir)file_static$(EXT_EXE)
file_test_sources					        := $(wildcard $(file_test_path_curdir)*.c)
file_test_objects					        := $(patsubst %.c, %.o, $(file_test_sources))
file_test_depends					        := $(patsubst %.c, %.d, $(file_test_sources))
file_test_depends_modules			        := common time 
file_test_depends_modules			        += file
file_test_libdepend_static_objs	        := $(foreach dep_module,$(file_depends_modules),$($(dep_module)_static_objects))
file_test_libdepend_static_objs	        += $(foreach dep_module,$(file_test_depends_modules),$($(dep_module)_static_objects))

include $(file_test_child_makefiles)

$(file_test_path_curdir)%.o: $(file_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(file_test_install_path_static): $(file_test_objects) $(file_test_libdepend_static_objs)
	$(CC) -o $@ $(file_test_objects) -Wl,--allow-multiple-definition $(file_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: file_test_all
file_test_all: $(file_test_child_all_targets) ## build all file_test tests
ifneq ($(file_test_objects),)
file_test_all: $(file_test_install_path_static)
endif

.PHONY: file_test_clean
file_test_clean: $(file_test_child_clean_targets) ## remove all file_test tests
file_test_clean:
	- $(RM) $(file_test_install_path_static) $(file_test_objects) $(file_test_depends)

.PHONY: file_test_re
file_test_re: file_test_clean
file_test_re: file_test_all

.PHONY: file_test_run_all
file_test_run_all: file_test_all ## build and run static file_test
file_test_run_all: $(file_test_child_run_targets)
ifneq ($(file_test_objects),)
file_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(file_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(file_test_install_path_static)
endif

.PHONY: file_test_run
file_test_run: file_test_all
ifneq ($(file_test_objects),)
file_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(file_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(file_test_install_path_static)
endif

-include $(file_test_depends)
