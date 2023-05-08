file_reader_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
file_reader_test_child_makefiles			        := $(wildcard $(file_reader_test_path_curdir)*/*mk)
file_reader_test_child_module_names		        := $(basename $(notdir $(file_reader_test_child_makefiles)))
file_reader_test_child_all_targets		        := $(foreach test_module,$(file_reader_test_child_module_names),$(test_module)_all)
file_reader_test_child_clean_targets		        := $(foreach test_module,$(file_reader_test_child_module_names),$(test_module)_clean)
file_reader_test_child_run_targets		        := $(foreach test_module,$(file_reader_test_child_module_names),$(test_module)_run)
file_reader_test_install_path_static		        := $(file_reader_test_path_curdir)file_reader_static$(EXT_EXE)
file_reader_test_sources					        := $(wildcard $(file_reader_test_path_curdir)*.c)
file_reader_test_objects					        := $(patsubst %.c, %.o, $(file_reader_test_sources))
file_reader_test_depends					        := $(patsubst %.c, %.d, $(file_reader_test_sources))
file_reader_test_depends_modules			        := libc random common mod
# file_reader_test_depends_modules			        += test_framework
file_reader_test_depends_modules			        += file_reader
file_reader_test_libdepend_static_objs	        := $(foreach dep_module,$(file_reader_depends_modules),$($(dep_module)_static_objects))
file_reader_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(file_reader_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
file_reader_test_libdepend_static_objs	        += $(foreach dep_module,$(file_reader_test_depends_modules),$($(dep_module)_static_objects))

include $(file_reader_test_child_makefiles)

$(file_reader_test_path_curdir)%.o: $(file_reader_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(file_reader_test_install_path_static): $(file_reader_test_libdepend_static_objs)
$(file_reader_test_install_path_static): $(file_reader_test_objects)
	$(CC) -o $@ $(file_reader_test_objects) -Wl,--allow-multiple-definition $(file_reader_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: file_reader_test_all
file_reader_test_all: $(file_reader_test_child_all_targets) ## build all file_reader_test tests
ifneq ($(file_reader_test_objects),)
file_reader_test_all: $(file_reader_test_install_path_static)
endif

.PHONY: file_reader_test_clean
file_reader_test_clean: $(file_reader_test_child_clean_targets) ## remove all file_reader_test tests
file_reader_test_clean:
	- $(RM) $(file_reader_test_install_path_static) $(file_reader_test_objects) $(file_reader_test_depends)

.PHONY: file_reader_test_re
file_reader_test_re: file_reader_test_clean
file_reader_test_re: file_reader_test_all

.PHONY: file_reader_test_run_all
file_reader_test_run_all: file_reader_test_all ## build and run static file_reader_test
file_reader_test_run_all: $(file_reader_test_child_run_targets)
ifneq ($(file_reader_test_objects),)
file_reader_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(file_reader_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(file_reader_test_install_path_static)
endif

.PHONY: file_reader_test_run
file_reader_test_run: file_reader_test_all
ifneq ($(file_reader_test_objects),)
file_reader_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(file_reader_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(file_reader_test_install_path_static)
endif

-include $(file_reader_test_depends)
