vector_types_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
vector_types_path_curtestdir			:= $(vector_types_path_curdir)test/
vector_types_child_makefiles			:= $(wildcard $(vector_types_path_curdir)*/*mk)
vector_types_child_module_names		:= $(basename $(notdir $(vector_types_child_makefiles)))
vector_types_child_all_targets		:= $(foreach child_module,$(vector_types_child_module_names),$(child_module)_all)
vector_types_child_clean_targets		:= $(foreach child_module,$(vector_types_child_module_names),$(child_module)_clean)
vector_types_test_child_all_targets	:= $(foreach test_module,$(vector_types_child_module_names),$(test_module)_test_all)
vector_types_test_child_clean_targets	:= $(foreach test_module,$(vector_types_child_module_names),$(test_module)_test_clean)
vector_types_test_child_run_targets	:= $(foreach test_module,$(vector_types_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
vector_types_test_install_path_static := $(vector_types_path_curtestdir)vector_types_static$(EXT_EXE)
endif
vector_types_test_sources             := $(wildcard $(vector_types_path_curtestdir)*.c)
vector_types_sources					:= $(wildcard $(vector_types_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
vector_types_sources					+= $(wildcard $(vector_types_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
vector_types_sources					+= $(wildcard $(vector_types_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
vector_types_sources					+= $(wildcard $(vector_types_path_curdir)platform_specific/mac/*.c)
endif
vector_types_static_objects			:= $(patsubst %.c, %_static.o, $(vector_types_sources))
vector_types_test_objects				:= $(patsubst %.c, %.o, $(vector_types_test_sources))
vector_types_test_depends				:= $(patsubst %.c, %.d, $(vector_types_test_sources))
vector_types_depends					:= $(patsubst %.c, %.d, $(vector_types_sources))
vector_types_depends_modules			:= 
vector_types_test_depends_modules     = $(vector_types_depends_modules)
vector_types_test_depends_modules     += vector_types
vector_types_test_libdepend_static_objs   = $(foreach dep_module,$(vector_types_depends_modules),$($(dep_module)_static_objects))
vector_types_test_libdepend_static_objs   += $(vector_types_static_objects)
vector_types_clean_files				:=
vector_types_clean_files				+= $(vector_types_install_path_implib)
vector_types_clean_files				+= $(vector_types_static_objects)
vector_types_clean_files				+= $(vector_types_depends)

include $(vector_types_child_makefiles)

$(vector_types_path_curtestdir)%.o: $(vector_types_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(vector_types_path_curdir)%_static.o: $(vector_types_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(vector_types_test_install_path_static): $(vector_types_test_objects) $(vector_types_test_libdepend_static_objs)
	$(CC) -o $@ $(vector_types_test_objects) -Wl,--allow-multiple-definition $(vector_types_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: vector_types_all
vector_types_all: $(vector_types_child_all_targets) ## build all vector_types object files
vector_types_all: $(vector_types_static_objects)

.PHONY: vector_types_test_all
vector_types_test_all: $(vector_types_test_child_all_targets) ## build all vector_types_test tests
ifneq ($(vector_types_test_objects),)
vector_types_test_all: $(vector_types_test_install_path_static)
endif

.PHONY: vector_types_clean
vector_types_clean: $(vector_types_child_clean_targets) ## remove all vector_types object files
vector_types_clean:
	- $(RM) $(vector_types_clean_files)

.PHONY: vector_types_test_clean
vector_types_test_clean: $(vector_types_test_child_clean_targets) ## remove all vector_types_test tests
vector_types_test_clean:
	- $(RM) $(vector_types_test_install_path_static) $(vector_types_test_objects) $(vector_types_test_depends)

.PHONY: vector_types_re
vector_types_re: vector_types_clean
vector_types_re: vector_types_all

.PHONY: vector_types_test_re
vector_types_test_re: vector_types_test_clean
vector_types_test_re: vector_types_test_all

.PHONY: vector_types_test_run_all
vector_types_test_run_all: vector_types_test_all ## build and run vector_types_test
vector_types_test_run_all: $(vector_types_test_child_run_targets)
ifneq ($(vector_types_test_objects),)
vector_types_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(vector_types_test_install_path_static)
endif

.PHONY: vector_types_test_run
vector_types_test_run: vector_types_test_all
ifneq ($(vector_types_test_objects),)
vector_types_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(vector_types_test_install_path_static)
endif

-include $(vector_types_depends)
-include $(vector_types_test_depends)
