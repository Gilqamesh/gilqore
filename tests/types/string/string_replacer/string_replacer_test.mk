string_replacer_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
string_replacer_test_child_makefiles			        := $(wildcard $(string_replacer_test_path_curdir)*/*mk)
string_replacer_test_child_module_names		        := $(basename $(notdir $(string_replacer_test_child_makefiles)))
string_replacer_test_child_all_targets		        := $(foreach test_module,$(string_replacer_test_child_module_names),$(test_module)_all)
string_replacer_test_child_clean_targets		        := $(foreach test_module,$(string_replacer_test_child_module_names),$(test_module)_clean)
string_replacer_test_child_run_targets		        := $(foreach test_module,$(string_replacer_test_child_module_names),$(test_module)_run)
string_replacer_test_install_path_static		        := $(string_replacer_test_path_curdir)string_replacer_static$(EXT_EXE)
string_replacer_test_sources					        := $(wildcard $(string_replacer_test_path_curdir)*.c)
string_replacer_test_objects					        := $(patsubst %.c, %.o, $(string_replacer_test_sources))
string_replacer_test_depends					        := $(patsubst %.c, %.d, $(string_replacer_test_sources))
string_replacer_test_depends_modules			        := libc clamp abs sqrt file
# string_replacer_test_depends_modules			        += test_framework
string_replacer_test_depends_modules			        += string_replacer
string_replacer_test_libdepend_static_objs	        := $(foreach dep_module,$(string_replacer_depends_modules),$($(dep_module)_static_objects))
string_replacer_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(string_replacer_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
string_replacer_test_libdepend_static_objs	        += $(foreach dep_module,$(string_replacer_test_depends_modules),$($(dep_module)_static_objects))

include $(string_replacer_test_child_makefiles)

$(string_replacer_test_path_curdir)%.o: $(string_replacer_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(string_replacer_test_install_path_static): $(string_replacer_test_libdepend_static_objs)
$(string_replacer_test_install_path_static): $(string_replacer_test_objects)
	$(CC) -o $@ $(string_replacer_test_objects) -Wl,--allow-multiple-definition $(string_replacer_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: string_replacer_test_all
string_replacer_test_all: $(string_replacer_test_child_all_targets) ## build all string_replacer_test tests
ifneq ($(string_replacer_test_objects),)
string_replacer_test_all: $(string_replacer_test_install_path_static)
endif

.PHONY: string_replacer_test_clean
string_replacer_test_clean: $(string_replacer_test_child_clean_targets) ## remove all string_replacer_test tests
string_replacer_test_clean:
	- $(RM) $(string_replacer_test_install_path_static) $(string_replacer_test_objects) $(string_replacer_test_depends)

.PHONY: string_replacer_test_re
string_replacer_test_re: string_replacer_test_clean
string_replacer_test_re: string_replacer_test_all

.PHONY: string_replacer_test_run_all
string_replacer_test_run_all: string_replacer_test_all ## build and run static string_replacer_test
string_replacer_test_run_all: $(string_replacer_test_child_run_targets)
ifneq ($(string_replacer_test_objects),)
string_replacer_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(string_replacer_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(string_replacer_test_install_path_static)
endif

.PHONY: string_replacer_test_run
string_replacer_test_run: string_replacer_test_all
ifneq ($(string_replacer_test_objects),)
string_replacer_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(string_replacer_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(string_replacer_test_install_path_static)
endif

-include $(string_replacer_test_depends)
