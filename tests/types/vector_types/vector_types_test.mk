vector_types_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
vector_types_test_child_makefiles			        := $(wildcard $(vector_types_test_path_curdir)*/*mk)
vector_types_test_child_module_names		        := $(basename $(notdir $(vector_types_test_child_makefiles)))
vector_types_test_child_all_targets		        := $(foreach test_module,$(vector_types_test_child_module_names),$(test_module)_all)
vector_types_test_child_clean_targets		        := $(foreach test_module,$(vector_types_test_child_module_names),$(test_module)_clean)
vector_types_test_child_run_targets		        := $(foreach test_module,$(vector_types_test_child_module_names),$(test_module)_run)
vector_types_test_install_path_static		        := $(vector_types_test_path_curdir)vector_types_static$(EXT_EXE)
vector_types_test_sources					        := $(wildcard $(vector_types_test_path_curdir)*.c)
vector_types_test_objects					        := $(patsubst %.c, %.o, $(vector_types_test_sources))
vector_types_test_depends					        := $(patsubst %.c, %.d, $(vector_types_test_sources))
vector_types_test_depends_modules			        :=  vector_types test_framework
vector_types_test_libdepend_static_objs	        := $(foreach dep_module,$(vector_types_depends_modules),$($(dep_module)_static_objects))
vector_types_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(vector_types_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
vector_types_test_libdepend_static_objs	        += $(foreach dep_module,$(vector_types_test_depends_modules),$($(dep_module)_static_objects))

include $(vector_types_test_child_makefiles)

$(vector_types_test_path_curdir)%.o: $(vector_types_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(vector_types_test_install_path_static): $(vector_types_test_libdepend_static_objs)
$(vector_types_test_install_path_static): $(vector_types_test_objects)
	$(CC) -o $@ $(vector_types_test_objects) -Wl,--allow-multiple-definition $(vector_types_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: vector_types_test_all
vector_types_test_all: $(vector_types_test_child_all_targets) ## build all vector_types_test tests
ifneq ($(vector_types_test_objects),)
vector_types_test_all: $(vector_types_test_install_path_static)
endif

.PHONY: vector_types_test_clean
vector_types_test_clean: $(vector_types_test_child_clean_targets) ## remove all vector_types_test tests
vector_types_test_clean:
	- $(RM) $(vector_types_test_install_path_static) $(vector_types_test_objects) $(vector_types_test_depends)

.PHONY: vector_types_test_re
vector_types_test_re: vector_types_test_clean
vector_types_test_re: vector_types_test_all

.PHONY: vector_types_test_run
vector_types_test_run: vector_types_test_all ## build and run static vector_types_test
vector_types_test_run: $(vector_types_test_child_run_targets)
ifneq ($(vector_types_test_objects),)
vector_types_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(vector_types_test_install_path_static)
endif

-include $(vector_types_test_depends)
