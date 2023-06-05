string_replacer_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
string_replacer_path_curtestdir			:= $(string_replacer_path_curdir)test/
string_replacer_child_makefiles			:= $(wildcard $(string_replacer_path_curdir)*/*mk)
string_replacer_child_module_names		:= $(basename $(notdir $(string_replacer_child_makefiles)))
string_replacer_child_all_targets		:= $(foreach child_module,$(string_replacer_child_module_names),$(child_module)_all)
string_replacer_child_clean_targets		:= $(foreach child_module,$(string_replacer_child_module_names),$(child_module)_clean)
string_replacer_test_child_all_targets	:= $(foreach test_module,$(string_replacer_child_module_names),$(test_module)_test_all)
string_replacer_test_child_clean_targets	:= $(foreach test_module,$(string_replacer_child_module_names),$(test_module)_test_clean)
string_replacer_test_child_run_targets	:= $(foreach test_module,$(string_replacer_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
string_replacer_test_install_path_static := $(string_replacer_path_curtestdir)string_replacer_static$(EXT_EXE)
endif
string_replacer_test_sources             := $(wildcard $(string_replacer_path_curtestdir)*.c)
string_replacer_sources					:= $(wildcard $(string_replacer_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
string_replacer_sources					+= $(wildcard $(string_replacer_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
string_replacer_sources					+= $(wildcard $(string_replacer_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
string_replacer_sources					+= $(wildcard $(string_replacer_path_curdir)platform_specific/mac/*.c)
endif
string_replacer_static_objects			:= $(patsubst %.c, %_static.o, $(string_replacer_sources))
string_replacer_test_objects				:= $(patsubst %.c, %.o, $(string_replacer_test_sources))
string_replacer_test_depends				:= $(patsubst %.c, %.d, $(string_replacer_test_sources))
string_replacer_depends					:= $(patsubst %.c, %.d, $(string_replacer_sources))
string_replacer_depends_modules			:= libc common compare file time hash 
string_replacer_test_depends_modules     = $(string_replacer_depends_modules)
string_replacer_test_depends_modules     += string_replacer
string_replacer_test_libdepend_static_objs   = $(foreach dep_module,$(string_replacer_depends_modules),$($(dep_module)_static_objects))
string_replacer_test_libdepend_static_objs   += $(string_replacer_static_objects)
string_replacer_clean_files				:=
string_replacer_clean_files				+= $(string_replacer_install_path_implib)
string_replacer_clean_files				+= $(string_replacer_static_objects)
string_replacer_clean_files				+= $(string_replacer_depends)

include $(string_replacer_child_makefiles)

$(string_replacer_path_curtestdir)%.o: $(string_replacer_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(string_replacer_path_curdir)%_static.o: $(string_replacer_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(string_replacer_test_install_path_static): $(string_replacer_test_objects) $(string_replacer_test_libdepend_static_objs)
	$(CC) -o $@ $(string_replacer_test_objects) -Wl,--allow-multiple-definition $(string_replacer_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: string_replacer_all
string_replacer_all: $(string_replacer_child_all_targets) ## build all string_replacer object files
string_replacer_all: $(string_replacer_static_objects)

.PHONY: string_replacer_test_all
string_replacer_test_all: $(string_replacer_test_child_all_targets) ## build all string_replacer_test tests
ifneq ($(string_replacer_test_objects),)
string_replacer_test_all: $(string_replacer_test_install_path_static)
endif

.PHONY: string_replacer_clean
string_replacer_clean: $(string_replacer_child_clean_targets) ## remove all string_replacer object files
string_replacer_clean:
	- $(RM) $(string_replacer_clean_files)

.PHONY: string_replacer_test_clean
string_replacer_test_clean: $(string_replacer_test_child_clean_targets) ## remove all string_replacer_test tests
string_replacer_test_clean:
	- $(RM) $(string_replacer_test_install_path_static) $(string_replacer_test_objects) $(string_replacer_test_depends)

.PHONY: string_replacer_re
string_replacer_re: string_replacer_clean
string_replacer_re: string_replacer_all

.PHONY: string_replacer_test_re
string_replacer_test_re: string_replacer_test_clean
string_replacer_test_re: string_replacer_test_all

.PHONY: string_replacer_test_run_all
string_replacer_test_run_all: string_replacer_test_all ## build and run string_replacer_test
string_replacer_test_run_all: $(string_replacer_test_child_run_targets)
ifneq ($(string_replacer_test_objects),)
string_replacer_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(string_replacer_test_install_path_static)
endif

.PHONY: string_replacer_test_run
string_replacer_test_run: string_replacer_test_all
ifneq ($(string_replacer_test_objects),)
string_replacer_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(string_replacer_test_install_path_static)
endif

-include $(string_replacer_depends)
-include $(string_replacer_test_depends)
