math_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
math_path_curtestdir			:= $(math_path_curdir)test/
math_child_makefiles			:= $(wildcard $(math_path_curdir)*/*mk)
math_child_module_names		:= $(basename $(notdir $(math_child_makefiles)))
math_child_all_targets		:= $(foreach child_module,$(math_child_module_names),$(child_module)_all)
math_child_clean_targets		:= $(foreach child_module,$(math_child_module_names),$(child_module)_clean)
math_test_child_all_targets	:= $(foreach test_module,$(math_child_module_names),$(test_module)_test_all)
math_test_child_clean_targets	:= $(foreach test_module,$(math_child_module_names),$(test_module)_test_clean)
math_test_child_run_targets	:= $(foreach test_module,$(math_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
math_test_install_path_static := $(math_path_curtestdir)math_static$(EXT_EXE)
endif
math_test_sources             := $(wildcard $(math_path_curtestdir)*.c)
math_sources					:= $(wildcard $(math_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
math_sources					+= $(wildcard $(math_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
math_sources					+= $(wildcard $(math_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
math_sources					+= $(wildcard $(math_path_curdir)platform_specific/mac/*.c)
endif
math_static_objects			:= $(patsubst %.c, %_static.o, $(math_sources))
math_test_objects				:= $(patsubst %.c, %.o, $(math_test_sources))
math_test_depends				:= $(patsubst %.c, %.d, $(math_test_sources))
math_depends					:= $(patsubst %.c, %.d, $(math_sources))
math_depends_modules			:= 
math_test_depends_modules     = $(math_depends_modules)
math_test_depends_modules     += math
math_test_libdepend_static_objs   = $(foreach dep_module,$(math_depends_modules),$($(dep_module)_static_objects))
math_test_libdepend_static_objs   += $(math_static_objects)
math_clean_files				:=
math_clean_files				+= $(math_install_path_implib)
math_clean_files				+= $(math_static_objects)
math_clean_files				+= $(math_depends)

include $(math_child_makefiles)

$(math_path_curtestdir)%.o: $(math_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(math_path_curdir)%_static.o: $(math_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(math_test_install_path_static): $(math_test_objects) $(math_test_libdepend_static_objs)
	$(CC) -o $@ $(math_test_objects) -Wl,--allow-multiple-definition $(math_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: math_all
math_all: $(math_child_all_targets) ## build all math object files
math_all: $(math_static_objects)

.PHONY: math_test_all
math_test_all: $(math_test_child_all_targets) ## build all math_test tests
ifneq ($(math_test_objects),)
math_test_all: $(math_test_install_path_static)
endif

.PHONY: math_clean
math_clean: $(math_child_clean_targets) ## remove all math object files
math_clean:
	- $(RM) $(math_clean_files)

.PHONY: math_test_clean
math_test_clean: $(math_test_child_clean_targets) ## remove all math_test tests
math_test_clean:
	- $(RM) $(math_test_install_path_static) $(math_test_objects) $(math_test_depends)

.PHONY: math_re
math_re: math_clean
math_re: math_all

.PHONY: math_test_re
math_test_re: math_test_clean
math_test_re: math_test_all

.PHONY: math_test_run_all
math_test_run_all: math_test_all ## build and run math_test
math_test_run_all: $(math_test_child_run_targets)
ifneq ($(math_test_objects),)
math_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(math_test_install_path_static)
endif

.PHONY: math_test_run
math_test_run: math_test_all
ifneq ($(math_test_objects),)
math_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(math_test_install_path_static)
endif

-include $(math_depends)
-include $(math_test_depends)
