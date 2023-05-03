directory_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
directory_test_child_makefiles			        := $(wildcard $(directory_test_path_curdir)*/*mk)
directory_test_child_module_names		        := $(basename $(notdir $(directory_test_child_makefiles)))
directory_test_child_all_targets		        := $(foreach test_module,$(directory_test_child_module_names),$(test_module)_all)
directory_test_child_clean_targets		        := $(foreach test_module,$(directory_test_child_module_names),$(test_module)_clean)
directory_test_child_run_targets		        := $(foreach test_module,$(directory_test_child_module_names),$(test_module)_run)
directory_test_install_path_static		        := $(directory_test_path_curdir)directory_static$(EXT_EXE)
directory_test_sources					        := $(wildcard $(directory_test_path_curdir)*.c)
directory_test_objects					        := $(patsubst %.c, %.o, $(directory_test_sources))
directory_test_depends					        := $(patsubst %.c, %.d, $(directory_test_sources))
directory_test_depends_modules			        := file directory test_framework
directory_test_libdepend_static_objs	        := $(foreach dep_module,$(directory_depends_modules),$($(dep_module)_static_objects))
directory_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(directory_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
directory_test_libdepend_static_objs	        += $(foreach dep_module,$(directory_test_depends_modules),$($(dep_module)_static_objects))

include $(directory_test_child_makefiles)

$(directory_test_path_curdir)%.o: $(directory_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(directory_test_install_path_static): $(directory_test_libdepend_static_objs)
$(directory_test_install_path_static): $(directory_test_objects)
	$(CC) -o $@ $(directory_test_objects) -Wl,--allow-multiple-definition $(directory_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: directory_test_all
directory_test_all: $(directory_test_child_all_targets) ## build all directory_test tests
ifneq ($(directory_test_objects),)
directory_test_all: $(directory_test_install_path_static)
endif

.PHONY: directory_test_clean
directory_test_clean: $(directory_test_child_clean_targets) ## remove all directory_test tests
directory_test_clean:
	- $(RM) $(directory_test_install_path_static) $(directory_test_objects) $(directory_test_depends)

.PHONY: directory_test_re
directory_test_re: directory_test_clean
directory_test_re: directory_test_all

.PHONY: directory_test_run
directory_test_run: directory_test_all ## build and run static directory_test
directory_test_run: $(directory_test_child_run_targets)
ifneq ($(directory_test_objects),)
directory_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(directory_test_install_path_static)
endif

-include $(directory_test_depends)
