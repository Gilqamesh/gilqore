basic_types_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
basic_types_path_curtestdir			:= $(basic_types_path_curdir)test/
basic_types_child_makefiles			:= $(wildcard $(basic_types_path_curdir)*/*mk)
basic_types_child_module_names		:= $(basename $(notdir $(basic_types_child_makefiles)))
basic_types_child_all_targets		:= $(foreach child_module,$(basic_types_child_module_names),$(child_module)_all)
basic_types_child_clean_targets		:= $(foreach child_module,$(basic_types_child_module_names),$(child_module)_clean)
basic_types_test_child_all_targets	:= $(foreach test_module,$(basic_types_child_module_names),$(test_module)_test_all)
basic_types_test_child_clean_targets	:= $(foreach test_module,$(basic_types_child_module_names),$(test_module)_test_clean)
basic_types_test_child_run_targets	:= $(foreach test_module,$(basic_types_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
basic_types_test_install_path_static := $(basic_types_path_curtestdir)basic_types_static$(EXT_EXE)
endif
basic_types_test_sources             := $(wildcard $(basic_types_path_curtestdir)*.c)
basic_types_sources					:= $(wildcard $(basic_types_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
basic_types_sources					+= $(wildcard $(basic_types_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
basic_types_sources					+= $(wildcard $(basic_types_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
basic_types_sources					+= $(wildcard $(basic_types_path_curdir)platform_specific/mac/*.c)
endif
basic_types_static_objects			:= $(patsubst %.c, %_static.o, $(basic_types_sources))
basic_types_test_objects				:= $(patsubst %.c, %.o, $(basic_types_test_sources))
basic_types_test_depends				:= $(patsubst %.c, %.d, $(basic_types_test_sources))
basic_types_depends					:= $(patsubst %.c, %.d, $(basic_types_sources))
basic_types_depends_modules			:= math 
basic_types_test_depends_modules     = $(basic_types_depends_modules)
basic_types_test_depends_modules     += basic_types
basic_types_test_libdepend_static_objs   = $(foreach dep_module,$(basic_types_depends_modules),$($(dep_module)_static_objects))
basic_types_test_libdepend_static_objs   += $(basic_types_static_objects)
basic_types_clean_files				:=
basic_types_clean_files				+= $(basic_types_install_path_implib)
basic_types_clean_files				+= $(basic_types_static_objects)
basic_types_clean_files				+= $(basic_types_depends)

include $(basic_types_child_makefiles)

$(basic_types_path_curtestdir)%.o: $(basic_types_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(basic_types_path_curdir)%_static.o: $(basic_types_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(basic_types_test_install_path_static): $(basic_types_test_objects) $(basic_types_test_libdepend_static_objs)
	$(CC) -o $@ $(basic_types_test_objects) -Wl,--allow-multiple-definition $(basic_types_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: basic_types_all
basic_types_all: $(basic_types_child_all_targets) ## build all basic_types object files
basic_types_all: $(basic_types_static_objects)

.PHONY: basic_types_test_all
basic_types_test_all: $(basic_types_test_child_all_targets) ## build all basic_types_test tests
ifneq ($(basic_types_test_objects),)
basic_types_test_all: $(basic_types_test_install_path_static)
endif

.PHONY: basic_types_clean
basic_types_clean: $(basic_types_child_clean_targets) ## remove all basic_types object files
basic_types_clean:
	- $(RM) $(basic_types_clean_files)

.PHONY: basic_types_test_clean
basic_types_test_clean: $(basic_types_test_child_clean_targets) ## remove all basic_types_test tests
basic_types_test_clean:
	- $(RM) $(basic_types_test_install_path_static) $(basic_types_test_objects) $(basic_types_test_depends)

.PHONY: basic_types_re
basic_types_re: basic_types_clean
basic_types_re: basic_types_all

.PHONY: basic_types_test_re
basic_types_test_re: basic_types_test_clean
basic_types_test_re: basic_types_test_all

.PHONY: basic_types_test_run_all
basic_types_test_run_all: basic_types_test_all ## build and run basic_types_test
basic_types_test_run_all: $(basic_types_test_child_run_targets)
ifneq ($(basic_types_test_objects),)
basic_types_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(basic_types_test_install_path_static)
endif

.PHONY: basic_types_test_run
basic_types_test_run: basic_types_test_all
ifneq ($(basic_types_test_objects),)
basic_types_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(basic_types_test_install_path_static)
endif

-include $(basic_types_depends)
-include $(basic_types_test_depends)
