modules_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
modules_path_curtestdir			:= $(modules_path_curdir)test/
modules_child_makefiles			:= $(wildcard $(modules_path_curdir)*/*mk)
modules_child_module_names		:= $(basename $(notdir $(modules_child_makefiles)))
modules_child_all_targets		:= $(foreach child_module,$(modules_child_module_names),$(child_module)_all)
modules_child_clean_targets		:= $(foreach child_module,$(modules_child_module_names),$(child_module)_clean)
modules_test_child_all_targets	:= $(foreach test_module,$(modules_child_module_names),$(test_module)_test_all)
modules_test_child_clean_targets	:= $(foreach test_module,$(modules_child_module_names),$(test_module)_test_clean)
modules_test_child_run_targets	:= $(foreach test_module,$(modules_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
modules_test_install_path_static := $(modules_path_curtestdir)modules_static$(EXT_EXE)
endif
modules_test_sources             := $(wildcard $(modules_path_curtestdir)*.c)
modules_sources					:= $(wildcard $(modules_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
modules_sources					+= $(wildcard $(modules_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
modules_sources					+= $(wildcard $(modules_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
modules_sources					+= $(wildcard $(modules_path_curdir)platform_specific/mac/*.c)
endif
modules_static_objects			:= $(patsubst %.c, %_static.o, $(modules_sources))
modules_test_objects				:= $(patsubst %.c, %.o, $(modules_test_sources))
modules_test_depends				:= $(patsubst %.c, %.d, $(modules_test_sources))
modules_depends					:= $(patsubst %.c, %.d, $(modules_sources))
modules_depends_modules			:= file common time system libc random compare file_reader hash circular_buffer mod file_writer string directory string_replacer v2 clamp v3 v4 math abs sqrt file_path 
modules_test_depends_modules     = $(modules_depends_modules)
modules_test_depends_modules     += modules
modules_test_libdepend_static_objs   = $(foreach dep_module,$(modules_depends_modules),$($(dep_module)_static_objects))
modules_test_libdepend_static_objs   += $(modules_static_objects)
modules_clean_files				:=
modules_clean_files				+= $(modules_install_path_implib)
modules_clean_files				+= $(modules_static_objects)
modules_clean_files				+= $(modules_depends)

include $(modules_child_makefiles)

$(modules_path_curtestdir)%.o: $(modules_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(modules_path_curdir)%_static.o: $(modules_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(modules_test_install_path_static): $(modules_test_objects) $(modules_test_libdepend_static_objs)
	$(CC) -o $@ $(modules_test_objects) -Wl,--allow-multiple-definition $(modules_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: modules_all
modules_all: $(modules_child_all_targets) ## build all modules object files
modules_all: $(modules_static_objects)

.PHONY: modules_test_all
modules_test_all: $(modules_test_child_all_targets) ## build all modules_test tests
ifneq ($(modules_test_objects),)
modules_test_all: $(modules_test_install_path_static)
endif

.PHONY: modules_clean
modules_clean: $(modules_child_clean_targets) ## remove all modules object files
modules_clean:
	- $(RM) $(modules_clean_files)

.PHONY: modules_test_clean
modules_test_clean: $(modules_test_child_clean_targets) ## remove all modules_test tests
modules_test_clean:
	- $(RM) $(modules_test_install_path_static) $(modules_test_objects) $(modules_test_depends)

.PHONY: modules_re
modules_re: modules_clean
modules_re: modules_all

.PHONY: modules_test_re
modules_test_re: modules_test_clean
modules_test_re: modules_test_all

.PHONY: modules_test_run_all
modules_test_run_all: modules_test_all ## build and run modules_test
modules_test_run_all: $(modules_test_child_run_targets)
ifneq ($(modules_test_objects),)
modules_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(modules_test_install_path_static)
endif

.PHONY: modules_test_run
modules_test_run: modules_test_all
ifneq ($(modules_test_objects),)
modules_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(modules_test_install_path_static)
endif

-include $(modules_depends)
-include $(modules_test_depends)
