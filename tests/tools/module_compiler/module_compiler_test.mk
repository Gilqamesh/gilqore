module_compiler_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
module_compiler_test_child_makefiles			        := $(wildcard $(module_compiler_test_path_curdir)*/*mk)
module_compiler_test_child_module_names		        := $(basename $(notdir $(module_compiler_test_child_makefiles)))
module_compiler_test_child_all_targets		        := $(foreach test_module,$(module_compiler_test_child_module_names),$(test_module)_all)
module_compiler_test_child_clean_targets		        := $(foreach test_module,$(module_compiler_test_child_module_names),$(test_module)_clean)
module_compiler_test_child_run_targets		        := $(foreach test_module,$(module_compiler_test_child_module_names),$(test_module)_run)
module_compiler_test_install_path_static		        := $(module_compiler_test_path_curdir)module_compiler_static$(EXT_EXE)
module_compiler_test_sources					        := $(wildcard $(module_compiler_test_path_curdir)*.c)
module_compiler_test_objects					        := $(patsubst %.c, %.o, $(module_compiler_test_sources))
module_compiler_test_depends					        := $(patsubst %.c, %.d, $(module_compiler_test_sources))
module_compiler_test_depends_modules			        :=  module_compiler test_framework
module_compiler_test_libdepend_static_objs	        := $(foreach dep_module,$(module_compiler_depends_modules),$($(dep_module)_static_objects))
module_compiler_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(module_compiler_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
module_compiler_test_libdepend_static_objs	        += $(foreach dep_module,$(module_compiler_test_depends_modules),$($(dep_module)_static_objects))

include $(module_compiler_test_child_makefiles)

$(module_compiler_test_path_curdir)%.o: $(module_compiler_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(module_compiler_test_install_path_static): $(module_compiler_test_libdepend_static_objs)
$(module_compiler_test_install_path_static): $(module_compiler_test_objects)
	$(CC) -o $@ $(module_compiler_test_objects) -Wl,--allow-multiple-definition $(module_compiler_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: module_compiler_test_all
module_compiler_test_all: $(module_compiler_test_child_all_targets) ## build all module_compiler_test tests
ifneq ($(module_compiler_test_objects),)
module_compiler_test_all: $(module_compiler_test_install_path_static)
endif

.PHONY: module_compiler_test_clean
module_compiler_test_clean: $(module_compiler_test_child_clean_targets) ## remove all module_compiler_test tests
module_compiler_test_clean:
	- $(RM) $(module_compiler_test_install_path_static) $(module_compiler_test_objects) $(module_compiler_test_depends)

.PHONY: module_compiler_test_re
module_compiler_test_re: module_compiler_test_clean
module_compiler_test_re: module_compiler_test_all

.PHONY: module_compiler_test_run
module_compiler_test_run: module_compiler_test_all ## build and run static module_compiler_test
module_compiler_test_run: $(module_compiler_test_child_run_targets)
ifneq ($(module_compiler_test_objects),)
module_compiler_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(module_compiler_test_install_path_static)
endif

-include $(module_compiler_test_depends)
