file_writer_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
file_writer_test_child_makefiles			        := $(wildcard $(file_writer_test_path_curdir)*/*mk)
file_writer_test_child_module_names		        := $(basename $(notdir $(file_writer_test_child_makefiles)))
file_writer_test_child_all_targets		        := $(foreach test_module,$(file_writer_test_child_module_names),$(test_module)_all)
file_writer_test_child_clean_targets		        := $(foreach test_module,$(file_writer_test_child_module_names),$(test_module)_clean)
file_writer_test_child_run_targets		        := $(foreach test_module,$(file_writer_test_child_module_names),$(test_module)_run)
file_writer_test_install_path_static		        := $(file_writer_test_path_curdir)file_writer_static$(EXT_EXE)
file_writer_test_sources					        := $(wildcard $(file_writer_test_path_curdir)*.c)
file_writer_test_objects					        := $(patsubst %.c, %.o, $(file_writer_test_sources))
file_writer_test_depends					        := $(patsubst %.c, %.d, $(file_writer_test_sources))
file_writer_test_depends_modules			        := 
# file_writer_test_depends_modules			        += test_framework
file_writer_test_depends_modules			        += file_writer
file_writer_test_libdepend_static_objs	        := $(foreach dep_module,$(file_writer_depends_modules),$($(dep_module)_static_objects))
file_writer_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(file_writer_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
file_writer_test_libdepend_static_objs	        += $(foreach dep_module,$(file_writer_test_depends_modules),$($(dep_module)_static_objects))

include $(file_writer_test_child_makefiles)

$(file_writer_test_path_curdir)%.o: $(file_writer_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(file_writer_test_install_path_static): $(file_writer_test_libdepend_static_objs)
$(file_writer_test_install_path_static): $(file_writer_test_objects)
	$(CC) -o $@ $(file_writer_test_objects) -Wl,--allow-multiple-definition $(file_writer_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: file_writer_test_all
file_writer_test_all: $(file_writer_test_child_all_targets) ## build all file_writer_test tests
ifneq ($(file_writer_test_objects),)
file_writer_test_all: $(file_writer_test_install_path_static)
endif

.PHONY: file_writer_test_clean
file_writer_test_clean: $(file_writer_test_child_clean_targets) ## remove all file_writer_test tests
file_writer_test_clean:
	- $(RM) $(file_writer_test_install_path_static) $(file_writer_test_objects) $(file_writer_test_depends)

.PHONY: file_writer_test_re
file_writer_test_re: file_writer_test_clean
file_writer_test_re: file_writer_test_all

.PHONY: file_writer_test_run_all
file_writer_test_run_all: file_writer_test_all ## build and run static file_writer_test
file_writer_test_run_all: $(file_writer_test_child_run_targets)
ifneq ($(file_writer_test_objects),)
file_writer_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(file_writer_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(file_writer_test_install_path_static)
endif

.PHONY: file_writer_test_run
file_writer_test_run: file_writer_test_all
ifneq ($(file_writer_test_objects),)
file_writer_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(file_writer_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(file_writer_test_install_path_static)
endif

-include $(file_writer_test_depends)
