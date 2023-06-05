libc_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
libc_path_curtestdir			:= $(libc_path_curdir)test/
libc_child_makefiles			:= $(wildcard $(libc_path_curdir)*/*mk)
libc_child_module_names		:= $(basename $(notdir $(libc_child_makefiles)))
libc_child_all_targets		:= $(foreach child_module,$(libc_child_module_names),$(child_module)_all)
libc_child_clean_targets		:= $(foreach child_module,$(libc_child_module_names),$(child_module)_clean)
libc_test_child_all_targets	:= $(foreach test_module,$(libc_child_module_names),$(test_module)_test_all)
libc_test_child_clean_targets	:= $(foreach test_module,$(libc_child_module_names),$(test_module)_test_clean)
libc_test_child_run_targets	:= $(foreach test_module,$(libc_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
libc_test_install_path_static := $(libc_path_curtestdir)libc_static$(EXT_EXE)
endif
libc_test_sources             := $(wildcard $(libc_path_curtestdir)*.c)
libc_sources					:= $(wildcard $(libc_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
libc_sources					+= $(wildcard $(libc_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
libc_sources					+= $(wildcard $(libc_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
libc_sources					+= $(wildcard $(libc_path_curdir)platform_specific/mac/*.c)
endif
libc_static_objects			:= $(patsubst %.c, %_static.o, $(libc_sources))
libc_test_objects				:= $(patsubst %.c, %.o, $(libc_test_sources))
libc_test_depends				:= $(patsubst %.c, %.d, $(libc_test_sources))
libc_depends					:= $(patsubst %.c, %.d, $(libc_sources))
libc_depends_modules			:= common 
libc_test_depends_modules     = $(libc_depends_modules)
libc_test_depends_modules     += libc
libc_test_libdepend_static_objs   = $(foreach dep_module,$(libc_depends_modules),$($(dep_module)_static_objects))
libc_test_libdepend_static_objs   += $(libc_static_objects)
libc_clean_files				:=
libc_clean_files				+= $(libc_install_path_implib)
libc_clean_files				+= $(libc_static_objects)
libc_clean_files				+= $(libc_depends)

include $(libc_child_makefiles)

$(libc_path_curtestdir)%.o: $(libc_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(libc_path_curdir)%_static.o: $(libc_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(libc_test_install_path_static): $(libc_test_objects) $(libc_test_libdepend_static_objs)
	$(CC) -o $@ $(libc_test_objects) -Wl,--allow-multiple-definition $(libc_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: libc_all
libc_all: $(libc_child_all_targets) ## build all libc object files
libc_all: $(libc_static_objects)

.PHONY: libc_test_all
libc_test_all: $(libc_test_child_all_targets) ## build all libc_test tests
ifneq ($(libc_test_objects),)
libc_test_all: $(libc_test_install_path_static)
endif

.PHONY: libc_clean
libc_clean: $(libc_child_clean_targets) ## remove all libc object files
libc_clean:
	- $(RM) $(libc_clean_files)

.PHONY: libc_test_clean
libc_test_clean: $(libc_test_child_clean_targets) ## remove all libc_test tests
libc_test_clean:
	- $(RM) $(libc_test_install_path_static) $(libc_test_objects) $(libc_test_depends)

.PHONY: libc_re
libc_re: libc_clean
libc_re: libc_all

.PHONY: libc_test_re
libc_test_re: libc_test_clean
libc_test_re: libc_test_all

.PHONY: libc_test_run_all
libc_test_run_all: libc_test_all ## build and run libc_test
libc_test_run_all: $(libc_test_child_run_targets)
ifneq ($(libc_test_objects),)
libc_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(libc_test_install_path_static)
endif

.PHONY: libc_test_run
libc_test_run: libc_test_all
ifneq ($(libc_test_objects),)
libc_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(libc_test_install_path_static)
endif

-include $(libc_depends)
-include $(libc_test_depends)
