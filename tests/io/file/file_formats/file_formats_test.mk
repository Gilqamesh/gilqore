file_formats_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
file_formats_test_child_makefiles			        := $(wildcard $(file_formats_test_path_curdir)*/*mk)
file_formats_test_child_module_names		        := $(basename $(notdir $(file_formats_test_child_makefiles)))
file_formats_test_child_all_targets		        := $(foreach test_module,$(file_formats_test_child_module_names),$(test_module)_all)
file_formats_test_child_clean_targets		        := $(foreach test_module,$(file_formats_test_child_module_names),$(test_module)_clean)
file_formats_test_child_run_targets		        := $(foreach test_module,$(file_formats_test_child_module_names),$(test_module)_run)
file_formats_test_install_path_static		        := $(file_formats_test_path_curdir)file_formats_static$(EXT_EXE)
file_formats_test_sources					        := $(wildcard $(file_formats_test_path_curdir)*.c)
file_formats_test_objects					        := $(patsubst %.c, %.o, $(file_formats_test_sources))
file_formats_test_depends					        := $(patsubst %.c, %.d, $(file_formats_test_sources))
file_formats_test_depends_modules			        :=  file_formats test_framework
file_formats_test_libdepend_static_objs	        := $(foreach dep_module,$(file_formats_depends_modules),$($(dep_module)_static_objects))
file_formats_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(file_formats_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
file_formats_test_libdepend_static_objs	        += $(foreach dep_module,$(file_formats_test_depends_modules),$($(dep_module)_static_objects))

include $(file_formats_test_child_makefiles)

$(file_formats_test_path_curdir)%.o: $(file_formats_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(file_formats_test_install_path_static): $(file_formats_test_libdepend_static_objs)
$(file_formats_test_install_path_static): $(file_formats_test_objects)
	$(CC) -o $@ $(file_formats_test_objects) -Wl,--allow-multiple-definition $(file_formats_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: file_formats_test_all
file_formats_test_all: $(file_formats_test_child_all_targets) ## build all file_formats_test tests
ifneq ($(file_formats_test_objects),)
file_formats_test_all: $(file_formats_test_install_path_static)
endif

.PHONY: file_formats_test_clean
file_formats_test_clean: $(file_formats_test_child_clean_targets) ## remove all file_formats_test tests
file_formats_test_clean:
	- $(RM) $(file_formats_test_install_path_static) $(file_formats_test_objects) $(file_formats_test_depends)

.PHONY: file_formats_test_re
file_formats_test_re: file_formats_test_clean
file_formats_test_re: file_formats_test_all

.PHONY: file_formats_test_run
file_formats_test_run: file_formats_test_all ## build and run static file_formats_test
file_formats_test_run: $(file_formats_test_child_run_targets)
ifneq ($(file_formats_test_objects),)
file_formats_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(file_formats_test_install_path_static)
endif

-include $(file_formats_test_depends)
