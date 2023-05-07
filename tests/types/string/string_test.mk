string_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
string_test_child_makefiles			        := $(wildcard $(string_test_path_curdir)*/*mk)
string_test_child_module_names		        := $(basename $(notdir $(string_test_child_makefiles)))
string_test_child_all_targets		        := $(foreach test_module,$(string_test_child_module_names),$(test_module)_all)
string_test_child_clean_targets		        := $(foreach test_module,$(string_test_child_module_names),$(test_module)_clean)
string_test_child_run_targets		        := $(foreach test_module,$(string_test_child_module_names),$(test_module)_run)
string_test_install_path_static		        := $(string_test_path_curdir)string_static$(EXT_EXE)
string_test_sources					        := $(wildcard $(string_test_path_curdir)*.c)
string_test_objects					        := $(patsubst %.c, %.o, $(string_test_sources))
string_test_depends					        := $(patsubst %.c, %.d, $(string_test_sources))
string_test_depends_modules			        :=  string test_framework
string_test_libdepend_static_objs	        := $(foreach dep_module,$(string_depends_modules),$($(dep_module)_static_objects))
string_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(string_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
string_test_libdepend_static_objs	        += $(foreach dep_module,$(string_test_depends_modules),$($(dep_module)_static_objects))

include $(string_test_child_makefiles)

$(string_test_path_curdir)%.o: $(string_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(string_test_install_path_static): $(string_test_libdepend_static_objs)
$(string_test_install_path_static): $(string_test_objects)
	$(CC) -o $@ $(string_test_objects) -Wl,--allow-multiple-definition $(string_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: string_test_all
string_test_all: $(string_test_child_all_targets) ## build all string_test tests
ifneq ($(string_test_objects),)
string_test_all: $(string_test_install_path_static)
endif

.PHONY: string_test_clean
string_test_clean: $(string_test_child_clean_targets) ## remove all string_test tests
string_test_clean:
	- $(RM) $(string_test_install_path_static) $(string_test_objects) $(string_test_depends)

.PHONY: string_test_re
string_test_re: string_test_clean
string_test_re: string_test_all

.PHONY: string_test_run
string_test_run: string_test_all ## build and run static string_test
string_test_run: $(string_test_child_run_targets)
ifneq ($(string_test_objects),)
string_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(string_test_install_path_static)
endif

-include $(string_test_depends)
