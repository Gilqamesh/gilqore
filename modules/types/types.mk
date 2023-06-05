types_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
types_path_curtestdir			:= $(types_path_curdir)test/
types_child_makefiles			:= $(wildcard $(types_path_curdir)*/*mk)
types_child_module_names		:= $(basename $(notdir $(types_child_makefiles)))
types_child_all_targets		:= $(foreach child_module,$(types_child_module_names),$(child_module)_all)
types_child_clean_targets		:= $(foreach child_module,$(types_child_module_names),$(child_module)_clean)
types_test_child_all_targets	:= $(foreach test_module,$(types_child_module_names),$(test_module)_test_all)
types_test_child_clean_targets	:= $(foreach test_module,$(types_child_module_names),$(test_module)_test_clean)
types_test_child_run_targets	:= $(foreach test_module,$(types_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
types_test_install_path_static := $(types_path_curtestdir)types_static$(EXT_EXE)
endif
types_test_sources             := $(wildcard $(types_path_curtestdir)*.c)
types_sources					:= $(wildcard $(types_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
types_sources					+= $(wildcard $(types_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
types_sources					+= $(wildcard $(types_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
types_sources					+= $(wildcard $(types_path_curdir)platform_specific/mac/*.c)
endif
types_static_objects			:= $(patsubst %.c, %_static.o, $(types_sources))
types_test_objects				:= $(patsubst %.c, %.o, $(types_test_sources))
types_test_depends				:= $(patsubst %.c, %.d, $(types_test_sources))
types_depends					:= $(patsubst %.c, %.d, $(types_sources))
types_depends_modules			:= 
types_test_depends_modules     = $(types_depends_modules)
types_test_depends_modules     += types
types_test_libdepend_static_objs   = $(foreach dep_module,$(types_depends_modules),$($(dep_module)_static_objects))
types_test_libdepend_static_objs   += $(types_static_objects)
types_clean_files				:=
types_clean_files				+= $(types_install_path_implib)
types_clean_files				+= $(types_static_objects)
types_clean_files				+= $(types_depends)

include $(types_child_makefiles)

$(types_path_curtestdir)%.o: $(types_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(types_path_curdir)%_static.o: $(types_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(types_test_install_path_static): $(types_test_objects) $(types_test_libdepend_static_objs)
	$(CC) -o $@ $(types_test_objects) -Wl,--allow-multiple-definition $(types_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: types_all
types_all: $(types_child_all_targets) ## build all types object files
types_all: $(types_static_objects)

.PHONY: types_test_all
types_test_all: $(types_test_child_all_targets) ## build all types_test tests
ifneq ($(types_test_objects),)
types_test_all: $(types_test_install_path_static)
endif

.PHONY: types_clean
types_clean: $(types_child_clean_targets) ## remove all types object files
types_clean:
	- $(RM) $(types_clean_files)

.PHONY: types_test_clean
types_test_clean: $(types_test_child_clean_targets) ## remove all types_test tests
types_test_clean:
	- $(RM) $(types_test_install_path_static) $(types_test_objects) $(types_test_depends)

.PHONY: types_re
types_re: types_clean
types_re: types_all

.PHONY: types_test_re
types_test_re: types_test_clean
types_test_re: types_test_all

.PHONY: types_test_run_all
types_test_run_all: types_test_all ## build and run types_test
types_test_run_all: $(types_test_child_run_targets)
ifneq ($(types_test_objects),)
types_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(types_test_install_path_static)
endif

.PHONY: types_test_run
types_test_run: types_test_all
ifneq ($(types_test_objects),)
types_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(types_test_install_path_static)
endif

-include $(types_depends)
-include $(types_test_depends)
