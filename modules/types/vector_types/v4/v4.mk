v4_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
v4_path_curtestdir			:= $(v4_path_curdir)test/
v4_child_makefiles			:= $(wildcard $(v4_path_curdir)*/*mk)
v4_child_module_names		:= $(basename $(notdir $(v4_child_makefiles)))
v4_child_all_targets		:= $(foreach child_module,$(v4_child_module_names),$(child_module)_all)
v4_child_clean_targets		:= $(foreach child_module,$(v4_child_module_names),$(child_module)_clean)
v4_test_child_all_targets	:= $(foreach test_module,$(v4_child_module_names),$(test_module)_test_all)
v4_test_child_clean_targets	:= $(foreach test_module,$(v4_child_module_names),$(test_module)_test_clean)
v4_test_child_run_targets	:= $(foreach test_module,$(v4_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
v4_test_install_path_static := $(v4_path_curtestdir)v4_static$(EXT_EXE)
endif
v4_test_sources             := $(wildcard $(v4_path_curtestdir)*.c)
v4_sources					:= $(wildcard $(v4_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
v4_sources					+= $(wildcard $(v4_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
v4_sources					+= $(wildcard $(v4_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
v4_sources					+= $(wildcard $(v4_path_curdir)platform_specific/mac/*.c)
endif
v4_static_objects			:= $(patsubst %.c, %_static.o, $(v4_sources))
v4_test_objects				:= $(patsubst %.c, %.o, $(v4_test_sources))
v4_test_depends				:= $(patsubst %.c, %.d, $(v4_test_sources))
v4_depends					:= $(patsubst %.c, %.d, $(v4_sources))
v4_depends_modules			:= 
v4_test_depends_modules     = $(v4_depends_modules)
v4_test_depends_modules     += v4
v4_test_libdepend_static_objs   = $(foreach dep_module,$(v4_depends_modules),$($(dep_module)_static_objects))
v4_test_libdepend_static_objs   += $(v4_static_objects)
v4_clean_files				:=
v4_clean_files				+= $(v4_install_path_implib)
v4_clean_files				+= $(v4_static_objects)
v4_clean_files				+= $(v4_depends)

include $(v4_child_makefiles)

$(v4_path_curtestdir)%.o: $(v4_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(v4_path_curdir)%_static.o: $(v4_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(v4_test_install_path_static): $(v4_test_objects) $(v4_test_libdepend_static_objs)
	$(CC) -o $@ $(v4_test_objects) -Wl,--allow-multiple-definition $(v4_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: v4_all
v4_all: $(v4_child_all_targets) ## build all v4 object files
v4_all: $(v4_static_objects)

.PHONY: v4_test_all
v4_test_all: $(v4_test_child_all_targets) ## build all v4_test tests
ifneq ($(v4_test_objects),)
v4_test_all: $(v4_test_install_path_static)
endif

.PHONY: v4_clean
v4_clean: $(v4_child_clean_targets) ## remove all v4 object files
v4_clean:
	- $(RM) $(v4_clean_files)

.PHONY: v4_test_clean
v4_test_clean: $(v4_test_child_clean_targets) ## remove all v4_test tests
v4_test_clean:
	- $(RM) $(v4_test_install_path_static) $(v4_test_objects) $(v4_test_depends)

.PHONY: v4_re
v4_re: v4_clean
v4_re: v4_all

.PHONY: v4_test_re
v4_test_re: v4_test_clean
v4_test_re: v4_test_all

.PHONY: v4_test_run_all
v4_test_run_all: v4_test_all ## build and run v4_test
v4_test_run_all: $(v4_test_child_run_targets)
ifneq ($(v4_test_objects),)
v4_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(v4_test_install_path_static)
endif

.PHONY: v4_test_run
v4_test_run: v4_test_all
ifneq ($(v4_test_objects),)
v4_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(v4_test_install_path_static)
endif

-include $(v4_depends)
-include $(v4_test_depends)
