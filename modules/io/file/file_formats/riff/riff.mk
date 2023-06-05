riff_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
riff_path_curtestdir			:= $(riff_path_curdir)test/
riff_child_makefiles			:= $(wildcard $(riff_path_curdir)*/*mk)
riff_child_module_names		:= $(basename $(notdir $(riff_child_makefiles)))
riff_child_all_targets		:= $(foreach child_module,$(riff_child_module_names),$(child_module)_all)
riff_child_clean_targets		:= $(foreach child_module,$(riff_child_module_names),$(child_module)_clean)
riff_test_child_all_targets	:= $(foreach test_module,$(riff_child_module_names),$(test_module)_test_all)
riff_test_child_clean_targets	:= $(foreach test_module,$(riff_child_module_names),$(test_module)_test_clean)
riff_test_child_run_targets	:= $(foreach test_module,$(riff_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
riff_test_install_path_static := $(riff_path_curtestdir)riff_static$(EXT_EXE)
endif
riff_test_sources             := $(wildcard $(riff_path_curtestdir)*.c)
riff_sources					:= $(wildcard $(riff_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
riff_sources					+= $(wildcard $(riff_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
riff_sources					+= $(wildcard $(riff_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
riff_sources					+= $(wildcard $(riff_path_curdir)platform_specific/mac/*.c)
endif
riff_static_objects			:= $(patsubst %.c, %_static.o, $(riff_sources))
riff_test_objects				:= $(patsubst %.c, %.o, $(riff_test_sources))
riff_test_depends				:= $(patsubst %.c, %.d, $(riff_test_sources))
riff_depends					:= $(patsubst %.c, %.d, $(riff_sources))
riff_depends_modules			:= 
riff_test_depends_modules     = $(riff_depends_modules)
riff_test_depends_modules     += riff
riff_test_libdepend_static_objs   = $(foreach dep_module,$(riff_depends_modules),$($(dep_module)_static_objects))
riff_test_libdepend_static_objs   += $(riff_static_objects)
riff_clean_files				:=
riff_clean_files				+= $(riff_install_path_implib)
riff_clean_files				+= $(riff_static_objects)
riff_clean_files				+= $(riff_depends)

include $(riff_child_makefiles)

$(riff_path_curtestdir)%.o: $(riff_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(riff_path_curdir)%_static.o: $(riff_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(riff_test_install_path_static): $(riff_test_objects) $(riff_test_libdepend_static_objs)
	$(CC) -o $@ $(riff_test_objects) -Wl,--allow-multiple-definition $(riff_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: riff_all
riff_all: $(riff_child_all_targets) ## build all riff object files
riff_all: $(riff_static_objects)

.PHONY: riff_test_all
riff_test_all: $(riff_test_child_all_targets) ## build all riff_test tests
ifneq ($(riff_test_objects),)
riff_test_all: $(riff_test_install_path_static)
endif

.PHONY: riff_clean
riff_clean: $(riff_child_clean_targets) ## remove all riff object files
riff_clean:
	- $(RM) $(riff_clean_files)

.PHONY: riff_test_clean
riff_test_clean: $(riff_test_child_clean_targets) ## remove all riff_test tests
riff_test_clean:
	- $(RM) $(riff_test_install_path_static) $(riff_test_objects) $(riff_test_depends)

.PHONY: riff_re
riff_re: riff_clean
riff_re: riff_all

.PHONY: riff_test_re
riff_test_re: riff_test_clean
riff_test_re: riff_test_all

.PHONY: riff_test_run_all
riff_test_run_all: riff_test_all ## build and run riff_test
riff_test_run_all: $(riff_test_child_run_targets)
ifneq ($(riff_test_objects),)
riff_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(riff_test_install_path_static)
endif

.PHONY: riff_test_run
riff_test_run: riff_test_all
ifneq ($(riff_test_objects),)
riff_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(riff_test_install_path_static)
endif

-include $(riff_depends)
-include $(riff_test_depends)
