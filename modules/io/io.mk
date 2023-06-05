io_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
io_path_curtestdir			:= $(io_path_curdir)test/
io_child_makefiles			:= $(wildcard $(io_path_curdir)*/*mk)
io_child_module_names		:= $(basename $(notdir $(io_child_makefiles)))
io_child_all_targets		:= $(foreach child_module,$(io_child_module_names),$(child_module)_all)
io_child_clean_targets		:= $(foreach child_module,$(io_child_module_names),$(child_module)_clean)
io_test_child_all_targets	:= $(foreach test_module,$(io_child_module_names),$(test_module)_test_all)
io_test_child_clean_targets	:= $(foreach test_module,$(io_child_module_names),$(test_module)_test_clean)
io_test_child_run_targets	:= $(foreach test_module,$(io_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
io_test_install_path_static := $(io_path_curtestdir)io_static$(EXT_EXE)
endif
io_test_sources             := $(wildcard $(io_path_curtestdir)*.c)
io_sources					:= $(wildcard $(io_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
io_sources					+= $(wildcard $(io_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
io_sources					+= $(wildcard $(io_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
io_sources					+= $(wildcard $(io_path_curdir)platform_specific/mac/*.c)
endif
io_static_objects			:= $(patsubst %.c, %_static.o, $(io_sources))
io_test_objects				:= $(patsubst %.c, %.o, $(io_test_sources))
io_test_depends				:= $(patsubst %.c, %.d, $(io_test_sources))
io_depends					:= $(patsubst %.c, %.d, $(io_sources))
io_depends_modules			:= 
io_test_depends_modules     = $(io_depends_modules)
io_test_depends_modules     += io
io_test_libdepend_static_objs   = $(foreach dep_module,$(io_depends_modules),$($(dep_module)_static_objects))
io_test_libdepend_static_objs   += $(io_static_objects)
io_clean_files				:=
io_clean_files				+= $(io_install_path_implib)
io_clean_files				+= $(io_static_objects)
io_clean_files				+= $(io_depends)

include $(io_child_makefiles)

$(io_path_curtestdir)%.o: $(io_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(io_path_curdir)%_static.o: $(io_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(io_test_install_path_static): $(io_test_objects) $(io_test_libdepend_static_objs)
	$(CC) -o $@ $(io_test_objects) -Wl,--allow-multiple-definition $(io_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: io_all
io_all: $(io_child_all_targets) ## build all io object files
io_all: $(io_static_objects)

.PHONY: io_test_all
io_test_all: $(io_test_child_all_targets) ## build all io_test tests
ifneq ($(io_test_objects),)
io_test_all: $(io_test_install_path_static)
endif

.PHONY: io_clean
io_clean: $(io_child_clean_targets) ## remove all io object files
io_clean:
	- $(RM) $(io_clean_files)

.PHONY: io_test_clean
io_test_clean: $(io_test_child_clean_targets) ## remove all io_test tests
io_test_clean:
	- $(RM) $(io_test_install_path_static) $(io_test_objects) $(io_test_depends)

.PHONY: io_re
io_re: io_clean
io_re: io_all

.PHONY: io_test_re
io_test_re: io_test_clean
io_test_re: io_test_all

.PHONY: io_test_run_all
io_test_run_all: io_test_all ## build and run io_test
io_test_run_all: $(io_test_child_run_targets)
ifneq ($(io_test_objects),)
io_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(io_test_install_path_static)
endif

.PHONY: io_test_run
io_test_run: io_test_all
ifneq ($(io_test_objects),)
io_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(io_test_install_path_static)
endif

-include $(io_depends)
-include $(io_test_depends)
