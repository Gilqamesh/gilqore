mod_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
mod_path_curtestdir			:= $(mod_path_curdir)test/
mod_child_makefiles			:= $(wildcard $(mod_path_curdir)*/*mk)
mod_child_module_names		:= $(basename $(notdir $(mod_child_makefiles)))
mod_child_all_targets		:= $(foreach child_module,$(mod_child_module_names),$(child_module)_all)
mod_child_clean_targets		:= $(foreach child_module,$(mod_child_module_names),$(child_module)_clean)
mod_test_child_all_targets	:= $(foreach test_module,$(mod_child_module_names),$(test_module)_test_all)
mod_test_child_clean_targets	:= $(foreach test_module,$(mod_child_module_names),$(test_module)_test_clean)
mod_test_child_run_targets	:= $(foreach test_module,$(mod_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
mod_test_install_path_static := $(mod_path_curtestdir)mod_static$(EXT_EXE)
endif
mod_test_sources             := $(wildcard $(mod_path_curtestdir)*.c)
mod_sources					:= $(wildcard $(mod_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
mod_sources					+= $(wildcard $(mod_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
mod_sources					+= $(wildcard $(mod_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
mod_sources					+= $(wildcard $(mod_path_curdir)platform_specific/mac/*.c)
endif
mod_static_objects			:= $(patsubst %.c, %_static.o, $(mod_sources))
mod_test_objects				:= $(patsubst %.c, %.o, $(mod_test_sources))
mod_test_depends				:= $(patsubst %.c, %.d, $(mod_test_sources))
mod_depends					:= $(patsubst %.c, %.d, $(mod_sources))
mod_depends_modules			:= 
mod_test_depends_modules     = $(mod_depends_modules)
mod_test_depends_modules     += mod
mod_test_libdepend_static_objs   = $(foreach dep_module,$(mod_depends_modules),$($(dep_module)_static_objects))
mod_test_libdepend_static_objs   += $(mod_static_objects)
mod_clean_files				:=
mod_clean_files				+= $(mod_install_path_implib)
mod_clean_files				+= $(mod_static_objects)
mod_clean_files				+= $(mod_depends)

include $(mod_child_makefiles)

$(mod_path_curtestdir)%.o: $(mod_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(mod_path_curdir)%_static.o: $(mod_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(mod_test_install_path_static): $(mod_test_objects) $(mod_test_libdepend_static_objs)
	$(CC) -o $@ $(mod_test_objects) -Wl,--allow-multiple-definition $(mod_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: mod_all
mod_all: $(mod_child_all_targets) ## build all mod object files
mod_all: $(mod_static_objects)

.PHONY: mod_test_all
mod_test_all: $(mod_test_child_all_targets) ## build all mod_test tests
ifneq ($(mod_test_objects),)
mod_test_all: $(mod_test_install_path_static)
endif

.PHONY: mod_clean
mod_clean: $(mod_child_clean_targets) ## remove all mod object files
mod_clean:
	- $(RM) $(mod_clean_files)

.PHONY: mod_test_clean
mod_test_clean: $(mod_test_child_clean_targets) ## remove all mod_test tests
mod_test_clean:
	- $(RM) $(mod_test_install_path_static) $(mod_test_objects) $(mod_test_depends)

.PHONY: mod_re
mod_re: mod_clean
mod_re: mod_all

.PHONY: mod_test_re
mod_test_re: mod_test_clean
mod_test_re: mod_test_all

.PHONY: mod_test_run_all
mod_test_run_all: mod_test_all ## build and run mod_test
mod_test_run_all: $(mod_test_child_run_targets)
ifneq ($(mod_test_objects),)
mod_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(mod_test_install_path_static)
endif

.PHONY: mod_test_run
mod_test_run: mod_test_all
ifneq ($(mod_test_objects),)
mod_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(mod_test_install_path_static)
endif

-include $(mod_depends)
-include $(mod_test_depends)
