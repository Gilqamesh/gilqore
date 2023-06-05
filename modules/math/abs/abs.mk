abs_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
abs_path_curtestdir			:= $(abs_path_curdir)test/
abs_child_makefiles			:= $(wildcard $(abs_path_curdir)*/*mk)
abs_child_module_names		:= $(basename $(notdir $(abs_child_makefiles)))
abs_child_all_targets		:= $(foreach child_module,$(abs_child_module_names),$(child_module)_all)
abs_child_clean_targets		:= $(foreach child_module,$(abs_child_module_names),$(child_module)_clean)
abs_test_child_all_targets	:= $(foreach test_module,$(abs_child_module_names),$(test_module)_test_all)
abs_test_child_clean_targets	:= $(foreach test_module,$(abs_child_module_names),$(test_module)_test_clean)
abs_test_child_run_targets	:= $(foreach test_module,$(abs_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
abs_test_install_path_static := $(abs_path_curtestdir)abs_static$(EXT_EXE)
endif
abs_test_sources             := $(wildcard $(abs_path_curtestdir)*.c)
abs_sources					:= $(wildcard $(abs_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
abs_sources					+= $(wildcard $(abs_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
abs_sources					+= $(wildcard $(abs_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
abs_sources					+= $(wildcard $(abs_path_curdir)platform_specific/mac/*.c)
endif
abs_static_objects			:= $(patsubst %.c, %_static.o, $(abs_sources))
abs_test_objects				:= $(patsubst %.c, %.o, $(abs_test_sources))
abs_test_depends				:= $(patsubst %.c, %.d, $(abs_test_sources))
abs_depends					:= $(patsubst %.c, %.d, $(abs_sources))
abs_depends_modules			:= 
abs_test_depends_modules     = $(abs_depends_modules)
abs_test_depends_modules     += abs
abs_test_libdepend_static_objs   = $(foreach dep_module,$(abs_depends_modules),$($(dep_module)_static_objects))
abs_test_libdepend_static_objs   += $(abs_static_objects)
abs_clean_files				:=
abs_clean_files				+= $(abs_install_path_implib)
abs_clean_files				+= $(abs_static_objects)
abs_clean_files				+= $(abs_depends)

include $(abs_child_makefiles)

$(abs_path_curtestdir)%.o: $(abs_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(abs_path_curdir)%_static.o: $(abs_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(abs_test_install_path_static): $(abs_test_objects) $(abs_test_libdepend_static_objs)
	$(CC) -o $@ $(abs_test_objects) -Wl,--allow-multiple-definition $(abs_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: abs_all
abs_all: $(abs_child_all_targets) ## build all abs object files
abs_all: $(abs_static_objects)

.PHONY: abs_test_all
abs_test_all: $(abs_test_child_all_targets) ## build all abs_test tests
ifneq ($(abs_test_objects),)
abs_test_all: $(abs_test_install_path_static)
endif

.PHONY: abs_clean
abs_clean: $(abs_child_clean_targets) ## remove all abs object files
abs_clean:
	- $(RM) $(abs_clean_files)

.PHONY: abs_test_clean
abs_test_clean: $(abs_test_child_clean_targets) ## remove all abs_test tests
abs_test_clean:
	- $(RM) $(abs_test_install_path_static) $(abs_test_objects) $(abs_test_depends)

.PHONY: abs_re
abs_re: abs_clean
abs_re: abs_all

.PHONY: abs_test_re
abs_test_re: abs_test_clean
abs_test_re: abs_test_all

.PHONY: abs_test_run_all
abs_test_run_all: abs_test_all ## build and run abs_test
abs_test_run_all: $(abs_test_child_run_targets)
ifneq ($(abs_test_objects),)
abs_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(abs_test_install_path_static)
endif

.PHONY: abs_test_run
abs_test_run: abs_test_all
ifneq ($(abs_test_objects),)
abs_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(abs_test_install_path_static)
endif

-include $(abs_depends)
-include $(abs_test_depends)
