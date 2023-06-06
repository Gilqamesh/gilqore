process_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
process_path_curtestdir			:= $(process_path_curdir)test/
process_child_makefiles			:= $(wildcard $(process_path_curdir)*/*mk)
process_child_module_names		:= $(basename $(notdir $(process_child_makefiles)))
process_child_all_targets		:= $(foreach child_module,$(process_child_module_names),$(child_module)_all)
process_child_clean_targets		:= $(foreach child_module,$(process_child_module_names),$(child_module)_clean)
process_test_child_all_targets	:= $(foreach test_module,$(process_child_module_names),$(test_module)_test_all)
process_test_child_clean_targets	:= $(foreach test_module,$(process_child_module_names),$(test_module)_test_clean)
process_test_child_run_targets	:= $(foreach test_module,$(process_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
process_test_install_path_static := $(process_path_curtestdir)process_static$(EXT_EXE)
endif
process_test_sources             := $(wildcard $(process_path_curtestdir)*.c)
process_sources					:= $(wildcard $(process_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
process_sources					+= $(wildcard $(process_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
process_sources					+= $(wildcard $(process_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
process_sources					+= $(wildcard $(process_path_curdir)platform_specific/mac/*.c)
endif
process_static_objects			:= $(patsubst %.c, %_static.o, $(process_sources))
process_test_objects				:= $(patsubst %.c, %.o, $(process_test_sources))
process_test_depends				:= $(patsubst %.c, %.d, $(process_test_sources))
process_depends					:= $(patsubst %.c, %.d, $(process_sources))
process_depends_modules			:= file common time system libc random compare 
process_test_depends_modules     = $(process_depends_modules)
process_test_depends_modules     += process
process_test_libdepend_static_objs   = $(foreach dep_module,$(process_depends_modules),$($(dep_module)_static_objects))
process_test_libdepend_static_objs   += $(process_static_objects)
process_clean_files				:=
process_clean_files				+= $(process_install_path_implib)
process_clean_files				+= $(process_static_objects)
process_clean_files				+= $(process_depends)

include $(process_child_makefiles)

$(process_path_curtestdir)%.o: $(process_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(process_path_curdir)%_static.o: $(process_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(process_test_install_path_static): $(process_test_objects) $(process_test_libdepend_static_objs)
	$(CC) -o $@ $(process_test_objects) -Wl,--allow-multiple-definition $(process_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: process_all
process_all: $(process_child_all_targets) ## build all process object files
process_all: $(process_static_objects)

.PHONY: process_test_all
process_test_all: $(process_test_child_all_targets) ## build all process_test tests
ifneq ($(process_test_objects),)
process_test_all: $(process_test_install_path_static)
endif

.PHONY: process_clean
process_clean: $(process_child_clean_targets) ## remove all process object files
process_clean:
	- $(RM) $(process_clean_files)

.PHONY: process_test_clean
process_test_clean: $(process_test_child_clean_targets) ## remove all process_test tests
process_test_clean:
	- $(RM) $(process_test_install_path_static) $(process_test_objects) $(process_test_depends)

.PHONY: process_re
process_re: process_clean
process_re: process_all

.PHONY: process_test_re
process_test_re: process_test_clean
process_test_re: process_test_all

.PHONY: process_test_run_all
process_test_run_all: process_test_all ## build and run process_test
process_test_run_all: $(process_test_child_run_targets)
ifneq ($(process_test_objects),)
process_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(process_test_install_path_static)
endif

.PHONY: process_test_run
process_test_run: process_test_all
ifneq ($(process_test_objects),)
process_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(process_test_install_path_static)
endif

-include $(process_depends)
-include $(process_test_depends)
