wav_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
wav_test_child_makefiles			        := $(wildcard $(wav_test_path_curdir)*/*mk)
wav_test_child_module_names		        := $(basename $(notdir $(wav_test_child_makefiles)))
wav_test_child_all_targets		        := $(foreach test_module,$(wav_test_child_module_names),$(test_module)_all)
wav_test_child_clean_targets		        := $(foreach test_module,$(wav_test_child_module_names),$(test_module)_clean)
wav_test_child_run_targets		        := $(foreach test_module,$(wav_test_child_module_names),$(test_module)_run)
wav_test_install_path_static		        := $(wav_test_path_curdir)wav_static$(EXT_EXE)
wav_test_sources					        := $(wildcard $(wav_test_path_curdir)*.c)
wav_test_objects					        := $(patsubst %.c, %.o, $(wav_test_sources))
wav_test_depends					        := $(patsubst %.c, %.d, $(wav_test_sources))
wav_test_depends_modules			        := $(MODULE_LIBDEP_MODULES)
wav_test_depends_modules			        += wav
wav_test_libdepend_static_objs	        := $(foreach dep_module,$(wav_depends_modules),$($(dep_module)_static_objects))
wav_test_libdepend_static_objs	        += $(foreach dep_module,$(wav_test_depends_modules),$($(dep_module)_static_objects))

include $(wav_test_child_makefiles)

$(wav_test_path_curdir)%.o: $(wav_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(wav_test_install_path_static): $(wav_test_objects) $(wav_test_libdepend_static_objs)
	$(CC) -o $@ $(wav_test_objects) -Wl,--allow-multiple-definition $(wav_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: wav_test_all
wav_test_all: $(wav_test_child_all_targets) ## build all wav_test tests
ifneq ($(wav_test_objects),)
wav_test_all: $(wav_test_install_path_static)
endif

.PHONY: wav_test_clean
wav_test_clean: $(wav_test_child_clean_targets) ## remove all wav_test tests
wav_test_clean:
	- $(RM) $(wav_test_install_path_static) $(wav_test_objects) $(wav_test_depends)

.PHONY: wav_test_re
wav_test_re: wav_test_clean
wav_test_re: wav_test_all

.PHONY: wav_test_run_all
wav_test_run_all: wav_test_all ## build and run static wav_test
wav_test_run_all: $(wav_test_child_run_targets)
ifneq ($(wav_test_objects),)
wav_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(wav_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(wav_test_install_path_static)
endif

.PHONY: wav_test_run
wav_test_run: wav_test_all
ifneq ($(wav_test_objects),)
wav_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(wav_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(wav_test_install_path_static)
endif

-include $(wav_test_depends)
