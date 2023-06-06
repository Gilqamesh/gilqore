console_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
console_path_curtestdir			:= $(console_path_curdir)test/
console_child_makefiles			:= $(wildcard $(console_path_curdir)*/*mk)
console_child_module_names		:= $(basename $(notdir $(console_child_makefiles)))
console_child_all_targets		:= $(foreach child_module,$(console_child_module_names),$(child_module)_all)
console_child_clean_targets		:= $(foreach child_module,$(console_child_module_names),$(child_module)_clean)
console_test_child_all_targets	:= $(foreach test_module,$(console_child_module_names),$(test_module)_test_all)
console_test_child_clean_targets	:= $(foreach test_module,$(console_child_module_names),$(test_module)_test_clean)
console_test_child_run_targets	:= $(foreach test_module,$(console_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
console_test_install_path_static := $(console_path_curtestdir)console_static$(EXT_EXE)
endif
console_test_sources             := $(wildcard $(console_path_curtestdir)*.c)
console_sources					:= $(wildcard $(console_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
console_sources					+= $(wildcard $(console_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
console_sources					+= $(wildcard $(console_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
console_sources					+= $(wildcard $(console_path_curdir)platform_specific/mac/*.c)
endif
console_static_objects			:= $(patsubst %.c, %_static.o, $(console_sources))
console_test_objects				:= $(patsubst %.c, %.o, $(console_test_sources))
console_test_depends				:= $(patsubst %.c, %.d, $(console_test_sources))
console_depends					:= $(patsubst %.c, %.d, $(console_sources))
console_depends_modules			:= libc common 
console_test_depends_modules     = $(console_depends_modules)
console_test_depends_modules     += console
console_test_libdepend_static_objs   = $(foreach dep_module,$(console_depends_modules),$($(dep_module)_static_objects))
console_test_libdepend_static_objs   += $(console_static_objects)
console_clean_files				:=
console_clean_files				+= $(console_install_path_implib)
console_clean_files				+= $(console_static_objects)
console_clean_files				+= $(console_depends)

include $(console_child_makefiles)

$(console_path_curtestdir)%.o: $(console_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(console_path_curdir)%_static.o: $(console_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(console_test_install_path_static): $(console_test_objects) $(console_test_libdepend_static_objs)
	$(CC) -o $@ $(console_test_objects) -Wl,--allow-multiple-definition $(console_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: console_all
console_all: $(console_child_all_targets) ## build all console object files
console_all: $(console_static_objects)

.PHONY: console_test_all
console_test_all: $(console_test_child_all_targets) ## build all console_test tests
ifneq ($(console_test_objects),)
console_test_all: $(console_test_install_path_static)
endif

.PHONY: console_clean
console_clean: $(console_child_clean_targets) ## remove all console object files
console_clean:
	- $(RM) $(console_clean_files)

.PHONY: console_test_clean
console_test_clean: $(console_test_child_clean_targets) ## remove all console_test tests
console_test_clean:
	- $(RM) $(console_test_install_path_static) $(console_test_objects) $(console_test_depends)

.PHONY: console_re
console_re: console_clean
console_re: console_all

.PHONY: console_test_re
console_test_re: console_test_clean
console_test_re: console_test_all

.PHONY: console_test_run_all
console_test_run_all: console_test_all ## build and run console_test
console_test_run_all: $(console_test_child_run_targets)
ifneq ($(console_test_objects),)
console_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(console_test_install_path_static)
endif

.PHONY: console_test_run
console_test_run: console_test_all
ifneq ($(console_test_objects),)
console_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(console_test_install_path_static)
endif

-include $(console_depends)
-include $(console_test_depends)
