hash_test_path_curdir				        := $(dir $(lastword $(MAKEFILE_LIST)))
hash_test_child_makefiles			        := $(wildcard $(hash_test_path_curdir)*/*mk)
hash_test_child_module_names		        := $(basename $(notdir $(hash_test_child_makefiles)))
hash_test_child_all_targets		        := $(foreach test_module,$(hash_test_child_module_names),$(test_module)_all)
hash_test_child_clean_targets		        := $(foreach test_module,$(hash_test_child_module_names),$(test_module)_clean)
hash_test_child_run_targets		        := $(foreach test_module,$(hash_test_child_module_names),$(test_module)_run)
hash_test_install_path_static		        := $(hash_test_path_curdir)hash_static$(EXT_EXE)
hash_test_sources					        := $(wildcard $(hash_test_path_curdir)*.c)
hash_test_objects					        := $(patsubst %.c, %.o, $(hash_test_sources))
hash_test_depends					        := $(patsubst %.c, %.d, $(hash_test_sources))
hash_test_depends_modules			        := 
hash_test_depends_modules			        += hash
hash_test_libdepend_static_objs	        := $(foreach dep_module,$(hash_depends_modules),$($(dep_module)_static_objects))
hash_test_libdepend_static_objs	        += $(foreach dep_module,$(hash_test_depends_modules),$($(dep_module)_static_objects))

include $(hash_test_child_makefiles)

$(hash_test_path_curdir)%.o: $(hash_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(hash_test_install_path_static): $(hash_test_objects) $(hash_test_libdepend_static_objs)
	$(CC) -o $@ $(hash_test_objects) -Wl,--allow-multiple-definition $(hash_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: hash_test_all
hash_test_all: $(hash_test_child_all_targets) ## build all hash_test tests
ifneq ($(hash_test_objects),)
hash_test_all: $(hash_test_install_path_static)
endif

.PHONY: hash_test_clean
hash_test_clean: $(hash_test_child_clean_targets) ## remove all hash_test tests
hash_test_clean:
	- $(RM) $(hash_test_install_path_static) $(hash_test_objects) $(hash_test_depends)

.PHONY: hash_test_re
hash_test_re: hash_test_clean
hash_test_re: hash_test_all

.PHONY: hash_test_run_all
hash_test_run_all: hash_test_all ## build and run static hash_test
hash_test_run_all: $(hash_test_child_run_targets)
ifneq ($(hash_test_objects),)
hash_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(hash_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(hash_test_install_path_static)
endif

.PHONY: hash_test_run
hash_test_run: hash_test_all
ifneq ($(hash_test_objects),)
hash_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(hash_test_install_path_static)
#	@$(PYTHON) $(PATH_MK_FILES)/pytester.py $(hash_test_install_path_static)
endif

-include $(hash_test_depends)
