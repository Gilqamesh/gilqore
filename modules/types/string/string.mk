string_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
string_path_curtestdir			:= $(string_path_curdir)test/
string_child_makefiles			:= $(wildcard $(string_path_curdir)*/*mk)
string_child_module_names		:= $(basename $(notdir $(string_child_makefiles)))
string_child_all_targets		:= $(foreach child_module,$(string_child_module_names),$(child_module)_all)
string_child_clean_targets		:= $(foreach child_module,$(string_child_module_names),$(child_module)_clean)
string_test_child_all_targets	:= $(foreach test_module,$(string_child_module_names),$(test_module)_test_all)
string_test_child_clean_targets	:= $(foreach test_module,$(string_child_module_names),$(test_module)_test_clean)
string_test_child_run_targets	:= $(foreach test_module,$(string_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
string_test_install_path_static := $(string_path_curtestdir)string_static$(EXT_EXE)
endif
string_test_sources             := $(wildcard $(string_path_curtestdir)*.c)
string_sources					:= $(wildcard $(string_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
string_sources					+= $(wildcard $(string_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
string_sources					+= $(wildcard $(string_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
string_sources					+= $(wildcard $(string_path_curdir)platform_specific/mac/*.c)
endif
string_static_objects			:= $(patsubst %.c, %_static.o, $(string_sources))
string_test_objects				:= $(patsubst %.c, %.o, $(string_test_sources))
string_test_depends				:= $(patsubst %.c, %.d, $(string_test_sources))
string_depends					:= $(patsubst %.c, %.d, $(string_sources))
string_depends_modules			:= 
string_test_depends_modules     = $(string_depends_modules)
string_test_depends_modules     += string
string_test_libdepend_static_objs   = $(foreach dep_module,$(string_depends_modules),$($(dep_module)_static_objects))
string_test_libdepend_static_objs   += $(string_static_objects)
string_clean_files				:=
string_clean_files				+= $(string_install_path_implib)
string_clean_files				+= $(string_static_objects)
string_clean_files				+= $(string_depends)

include $(string_child_makefiles)

$(string_path_curtestdir)%.o: $(string_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(string_path_curdir)%_static.o: $(string_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(string_test_install_path_static): $(string_test_objects) $(string_test_libdepend_static_objs)
	$(CC) -o $@ $(string_test_objects) -Wl,--allow-multiple-definition $(string_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: string_all
string_all: $(string_child_all_targets) ## build all string object files
string_all: $(string_static_objects)

.PHONY: string_test_all
string_test_all: $(string_test_child_all_targets) ## build all string_test tests
ifneq ($(string_test_objects),)
string_test_all: $(string_test_install_path_static)
endif

.PHONY: string_clean
string_clean: $(string_child_clean_targets) ## remove all string object files
string_clean:
	- $(RM) $(string_clean_files)

.PHONY: string_test_clean
string_test_clean: $(string_test_child_clean_targets) ## remove all string_test tests
string_test_clean:
	- $(RM) $(string_test_install_path_static) $(string_test_objects) $(string_test_depends)

.PHONY: string_re
string_re: string_clean
string_re: string_all

.PHONY: string_test_re
string_test_re: string_test_clean
string_test_re: string_test_all

.PHONY: string_test_run_all
string_test_run_all: string_test_all ## build and run string_test
string_test_run_all: $(string_test_child_run_targets)
ifneq ($(string_test_objects),)
string_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(string_test_install_path_static)
endif

.PHONY: string_test_run
string_test_run: string_test_all
ifneq ($(string_test_objects),)
string_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(string_test_install_path_static)
endif

-include $(string_depends)
-include $(string_test_depends)
