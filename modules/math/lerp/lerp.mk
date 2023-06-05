lerp_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
lerp_path_curtestdir			:= $(lerp_path_curdir)test/
lerp_child_makefiles			:= $(wildcard $(lerp_path_curdir)*/*mk)
lerp_child_module_names		:= $(basename $(notdir $(lerp_child_makefiles)))
lerp_child_all_targets		:= $(foreach child_module,$(lerp_child_module_names),$(child_module)_all)
lerp_child_clean_targets		:= $(foreach child_module,$(lerp_child_module_names),$(child_module)_clean)
lerp_test_child_all_targets	:= $(foreach test_module,$(lerp_child_module_names),$(test_module)_test_all)
lerp_test_child_clean_targets	:= $(foreach test_module,$(lerp_child_module_names),$(test_module)_test_clean)
lerp_test_child_run_targets	:= $(foreach test_module,$(lerp_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
lerp_test_install_path_static := $(lerp_path_curtestdir)lerp_static$(EXT_EXE)
endif
lerp_test_sources             := $(wildcard $(lerp_path_curtestdir)*.c)
lerp_sources					:= $(wildcard $(lerp_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
lerp_sources					+= $(wildcard $(lerp_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
lerp_sources					+= $(wildcard $(lerp_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
lerp_sources					+= $(wildcard $(lerp_path_curdir)platform_specific/mac/*.c)
endif
lerp_static_objects			:= $(patsubst %.c, %_static.o, $(lerp_sources))
lerp_test_objects				:= $(patsubst %.c, %.o, $(lerp_test_sources))
lerp_test_depends				:= $(patsubst %.c, %.d, $(lerp_test_sources))
lerp_depends					:= $(patsubst %.c, %.d, $(lerp_sources))
lerp_depends_modules			:= 
lerp_test_depends_modules     = $(lerp_depends_modules)
lerp_test_depends_modules     += lerp
lerp_test_libdepend_static_objs   = $(foreach dep_module,$(lerp_depends_modules),$($(dep_module)_static_objects))
lerp_test_libdepend_static_objs   += $(lerp_static_objects)
lerp_clean_files				:=
lerp_clean_files				+= $(lerp_install_path_implib)
lerp_clean_files				+= $(lerp_static_objects)
lerp_clean_files				+= $(lerp_depends)

include $(lerp_child_makefiles)

$(lerp_path_curtestdir)%.o: $(lerp_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(lerp_path_curdir)%_static.o: $(lerp_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(lerp_test_install_path_static): $(lerp_test_objects) $(lerp_test_libdepend_static_objs)
	$(CC) -o $@ $(lerp_test_objects) -Wl,--allow-multiple-definition $(lerp_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: lerp_all
lerp_all: $(lerp_child_all_targets) ## build all lerp object files
lerp_all: $(lerp_static_objects)

.PHONY: lerp_test_all
lerp_test_all: $(lerp_test_child_all_targets) ## build all lerp_test tests
ifneq ($(lerp_test_objects),)
lerp_test_all: $(lerp_test_install_path_static)
endif

.PHONY: lerp_clean
lerp_clean: $(lerp_child_clean_targets) ## remove all lerp object files
lerp_clean:
	- $(RM) $(lerp_clean_files)

.PHONY: lerp_test_clean
lerp_test_clean: $(lerp_test_child_clean_targets) ## remove all lerp_test tests
lerp_test_clean:
	- $(RM) $(lerp_test_install_path_static) $(lerp_test_objects) $(lerp_test_depends)

.PHONY: lerp_re
lerp_re: lerp_clean
lerp_re: lerp_all

.PHONY: lerp_test_re
lerp_test_re: lerp_test_clean
lerp_test_re: lerp_test_all

.PHONY: lerp_test_run_all
lerp_test_run_all: lerp_test_all ## build and run lerp_test
lerp_test_run_all: $(lerp_test_child_run_targets)
ifneq ($(lerp_test_objects),)
lerp_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(lerp_test_install_path_static)
endif

.PHONY: lerp_test_run
lerp_test_run: lerp_test_all
ifneq ($(lerp_test_objects),)
lerp_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(lerp_test_install_path_static)
endif

-include $(lerp_depends)
-include $(lerp_test_depends)
