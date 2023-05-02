thread_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
thread_test_child_makefiles			        := $(wildcard $(thread_test_path_curdir)*/*mk)
thread_test_child_module_names		        := $(basename $(notdir $(thread_test_child_makefiles)))
thread_test_child_all_targets		        := $(foreach test_module,$(thread_test_child_module_names),$(test_module)_all)
thread_test_child_clean_targets		        := $(foreach test_module,$(thread_test_child_module_names),$(test_module)_clean)
thread_test_child_run_targets		        := $(foreach test_module,$(thread_test_child_module_names),$(test_module)_run)
thread_test_install_path_static		        := $(thread_test_path_curdir)thread_static$(EXT_EXE)
thread_test_sources					        := $(wildcard $(thread_test_path_curdir)*.c)
thread_test_objects					        := $(patsubst %.c, %.o, $(thread_test_sources))
thread_test_depends					        := $(patsubst %.c, %.d, $(thread_test_sources))
thread_test_depends_modules			        :=  thread test_framework
thread_test_libdepend_static_objs	        := $(foreach dep_module,$(thread_depends_modules),$($(dep_module)_static_objects))
thread_test_libdepend_static_objs	        += $(foreach dep_module,$(foreach m,$(thread_test_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
thread_test_libdepend_static_objs	        += $(foreach dep_module,$(thread_test_depends_modules),$($(dep_module)_static_objects))

include $(thread_test_child_makefiles)

$(thread_test_path_curdir)%.o: $(thread_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(thread_test_install_path_static): $(thread_test_libdepend_static_objs)
$(thread_test_install_path_static): $(thread_test_objects)
	$(CC) -o $@ $(thread_test_objects) -Wl,--allow-multiple-definition $(thread_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: thread_test_all
thread_test_all: $(thread_test_child_all_targets) ## build all thread_test tests
ifneq ($(thread_test_objects),)
thread_test_all: $(thread_test_install_path_static)
endif

.PHONY: thread_test_clean
thread_test_clean: $(thread_test_child_clean_targets) ## remove all thread_test tests
thread_test_clean:
	- $(RM) $(thread_test_install_path_static) $(thread_test_objects) $(thread_test_depends)

.PHONY: thread_test_re
thread_test_re: thread_test_clean
thread_test_re: thread_test_all

.PHONY: thread_test_run
thread_test_run: thread_test_all ## build and run static thread_test
thread_test_run: $(thread_test_child_run_targets)
ifneq ($(thread_test_objects),)
thread_test_run:
	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(thread_test_install_path_static)
endif

-include $(thread_test_depends)
