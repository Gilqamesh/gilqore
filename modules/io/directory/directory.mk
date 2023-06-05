directory_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
directory_path_curtestdir			:= $(directory_path_curdir)test/
directory_child_makefiles			:= $(wildcard $(directory_path_curdir)*/*mk)
directory_child_module_names		:= $(basename $(notdir $(directory_child_makefiles)))
directory_child_all_targets		:= $(foreach child_module,$(directory_child_module_names),$(child_module)_all)
directory_child_clean_targets		:= $(foreach child_module,$(directory_child_module_names),$(child_module)_clean)
directory_test_child_all_targets	:= $(foreach test_module,$(directory_child_module_names),$(test_module)_test_all)
directory_test_child_clean_targets	:= $(foreach test_module,$(directory_child_module_names),$(test_module)_test_clean)
directory_test_child_run_targets	:= $(foreach test_module,$(directory_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
directory_test_install_path_static := $(directory_path_curtestdir)directory_static$(EXT_EXE)
endif
directory_test_sources             := $(wildcard $(directory_path_curtestdir)*.c)
directory_sources					:= $(wildcard $(directory_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
directory_sources					+= $(wildcard $(directory_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
directory_sources					+= $(wildcard $(directory_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
directory_sources					+= $(wildcard $(directory_path_curdir)platform_specific/mac/*.c)
endif
directory_static_objects			:= $(patsubst %.c, %_static.o, $(directory_sources))
directory_test_objects				:= $(patsubst %.c, %.o, $(directory_test_sources))
directory_test_depends				:= $(patsubst %.c, %.d, $(directory_test_sources))
directory_depends					:= $(patsubst %.c, %.d, $(directory_sources))
directory_depends_modules			:= common libc compare file time 
directory_test_depends_modules     = $(directory_depends_modules)
directory_test_depends_modules     += directory
directory_test_libdepend_static_objs   = $(foreach dep_module,$(directory_depends_modules),$($(dep_module)_static_objects))
directory_test_libdepend_static_objs   += $(directory_static_objects)
directory_clean_files				:=
directory_clean_files				+= $(directory_install_path_implib)
directory_clean_files				+= $(directory_static_objects)
directory_clean_files				+= $(directory_depends)

include $(directory_child_makefiles)

$(directory_path_curtestdir)%.o: $(directory_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(directory_path_curdir)%_static.o: $(directory_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(directory_test_install_path_static): $(directory_test_objects) $(directory_test_libdepend_static_objs)
	$(CC) -o $@ $(directory_test_objects) -Wl,--allow-multiple-definition $(directory_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: directory_all
directory_all: $(directory_child_all_targets) ## build all directory object files
directory_all: $(directory_static_objects)

.PHONY: directory_test_all
directory_test_all: $(directory_test_child_all_targets) ## build all directory_test tests
ifneq ($(directory_test_objects),)
directory_test_all: $(directory_test_install_path_static)
endif

.PHONY: directory_clean
directory_clean: $(directory_child_clean_targets) ## remove all directory object files
directory_clean:
	- $(RM) $(directory_clean_files)

.PHONY: directory_test_clean
directory_test_clean: $(directory_test_child_clean_targets) ## remove all directory_test tests
directory_test_clean:
	- $(RM) $(directory_test_install_path_static) $(directory_test_objects) $(directory_test_depends)

.PHONY: directory_re
directory_re: directory_clean
directory_re: directory_all

.PHONY: directory_test_re
directory_test_re: directory_test_clean
directory_test_re: directory_test_all

.PHONY: directory_test_run_all
directory_test_run_all: directory_test_all ## build and run directory_test
directory_test_run_all: $(directory_test_child_run_targets)
ifneq ($(directory_test_objects),)
directory_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(directory_test_install_path_static)
endif

.PHONY: directory_test_run
directory_test_run: directory_test_all
ifneq ($(directory_test_objects),)
directory_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(directory_test_install_path_static)
endif

-include $(directory_depends)
-include $(directory_test_depends)
