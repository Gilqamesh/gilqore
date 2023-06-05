v3_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
v3_path_curtestdir			:= $(v3_path_curdir)test/
v3_child_makefiles			:= $(wildcard $(v3_path_curdir)*/*mk)
v3_child_module_names		:= $(basename $(notdir $(v3_child_makefiles)))
v3_child_all_targets		:= $(foreach child_module,$(v3_child_module_names),$(child_module)_all)
v3_child_clean_targets		:= $(foreach child_module,$(v3_child_module_names),$(child_module)_clean)
v3_test_child_all_targets	:= $(foreach test_module,$(v3_child_module_names),$(test_module)_test_all)
v3_test_child_clean_targets	:= $(foreach test_module,$(v3_child_module_names),$(test_module)_test_clean)
v3_test_child_run_targets	:= $(foreach test_module,$(v3_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
v3_test_install_path_static := $(v3_path_curtestdir)v3_static$(EXT_EXE)
endif
v3_test_sources             := $(wildcard $(v3_path_curtestdir)*.c)
v3_sources					:= $(wildcard $(v3_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
v3_sources					+= $(wildcard $(v3_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
v3_sources					+= $(wildcard $(v3_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
v3_sources					+= $(wildcard $(v3_path_curdir)platform_specific/mac/*.c)
endif
v3_static_objects			:= $(patsubst %.c, %_static.o, $(v3_sources))
v3_test_objects				:= $(patsubst %.c, %.o, $(v3_test_sources))
v3_test_depends				:= $(patsubst %.c, %.d, $(v3_test_sources))
v3_depends					:= $(patsubst %.c, %.d, $(v3_sources))
v3_depends_modules			:= 
v3_test_depends_modules     = $(v3_depends_modules)
v3_test_depends_modules     += v3
v3_test_libdepend_static_objs   = $(foreach dep_module,$(v3_depends_modules),$($(dep_module)_static_objects))
v3_test_libdepend_static_objs   += $(v3_static_objects)
v3_clean_files				:=
v3_clean_files				+= $(v3_install_path_implib)
v3_clean_files				+= $(v3_static_objects)
v3_clean_files				+= $(v3_depends)

include $(v3_child_makefiles)

$(v3_path_curtestdir)%.o: $(v3_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(v3_path_curdir)%_static.o: $(v3_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(v3_test_install_path_static): $(v3_test_objects) $(v3_test_libdepend_static_objs)
	$(CC) -o $@ $(v3_test_objects) -Wl,--allow-multiple-definition $(v3_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: v3_all
v3_all: $(v3_child_all_targets) ## build all v3 object files
v3_all: $(v3_static_objects)

.PHONY: v3_test_all
v3_test_all: $(v3_test_child_all_targets) ## build all v3_test tests
ifneq ($(v3_test_objects),)
v3_test_all: $(v3_test_install_path_static)
endif

.PHONY: v3_clean
v3_clean: $(v3_child_clean_targets) ## remove all v3 object files
v3_clean:
	- $(RM) $(v3_clean_files)

.PHONY: v3_test_clean
v3_test_clean: $(v3_test_child_clean_targets) ## remove all v3_test tests
v3_test_clean:
	- $(RM) $(v3_test_install_path_static) $(v3_test_objects) $(v3_test_depends)

.PHONY: v3_re
v3_re: v3_clean
v3_re: v3_all

.PHONY: v3_test_re
v3_test_re: v3_test_clean
v3_test_re: v3_test_all

.PHONY: v3_test_run_all
v3_test_run_all: v3_test_all ## build and run v3_test
v3_test_run_all: $(v3_test_child_run_targets)
ifneq ($(v3_test_objects),)
v3_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(v3_test_install_path_static)
endif

.PHONY: v3_test_run
v3_test_run: v3_test_all
ifneq ($(v3_test_objects),)
v3_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(v3_test_install_path_static)
endif

-include $(v3_depends)
-include $(v3_test_depends)
