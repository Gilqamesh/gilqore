wav_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
wav_path_curtestdir			:= $(wav_path_curdir)test/
wav_child_makefiles			:= $(wildcard $(wav_path_curdir)*/*mk)
wav_child_module_names		:= $(basename $(notdir $(wav_child_makefiles)))
wav_child_all_targets		:= $(foreach child_module,$(wav_child_module_names),$(child_module)_all)
wav_child_clean_targets		:= $(foreach child_module,$(wav_child_module_names),$(child_module)_clean)
wav_test_child_all_targets	:= $(foreach test_module,$(wav_child_module_names),$(test_module)_test_all)
wav_test_child_clean_targets	:= $(foreach test_module,$(wav_child_module_names),$(test_module)_test_clean)
wav_test_child_run_targets	:= $(foreach test_module,$(wav_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
wav_test_install_path_static := $(wav_path_curtestdir)wav_static$(EXT_EXE)
endif
wav_test_sources             := $(wildcard $(wav_path_curtestdir)*.c)
wav_sources					:= $(wildcard $(wav_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
wav_sources					+= $(wildcard $(wav_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
wav_sources					+= $(wildcard $(wav_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
wav_sources					+= $(wildcard $(wav_path_curdir)platform_specific/mac/*.c)
endif
wav_static_objects			:= $(patsubst %.c, %_static.o, $(wav_sources))
wav_test_objects				:= $(patsubst %.c, %.o, $(wav_test_sources))
wav_test_depends				:= $(patsubst %.c, %.d, $(wav_test_sources))
wav_depends					:= $(patsubst %.c, %.d, $(wav_sources))
wav_depends_modules			:= 
wav_test_depends_modules     = $(wav_depends_modules)
wav_test_depends_modules     += wav
wav_test_libdepend_static_objs   = $(foreach dep_module,$(wav_depends_modules),$($(dep_module)_static_objects))
wav_test_libdepend_static_objs   += $(wav_static_objects)
wav_clean_files				:=
wav_clean_files				+= $(wav_install_path_implib)
wav_clean_files				+= $(wav_static_objects)
wav_clean_files				+= $(wav_depends)

include $(wav_child_makefiles)

$(wav_path_curtestdir)%.o: $(wav_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
#	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(wav_path_curdir)%_static.o: $(wav_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(wav_test_install_path_static): $(wav_test_objects) $(wav_test_libdepend_static_objs)
	$(CC) -o $@ $(wav_test_objects) -Wl,--allow-multiple-definition $(wav_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: wav_all
wav_all: $(wav_child_all_targets) ## build all wav object files
wav_all: $(wav_static_objects)

.PHONY: wav_test_all
wav_test_all: $(wav_test_child_all_targets) ## build all wav_test tests
ifneq ($(wav_test_objects),)
wav_test_all: $(wav_test_install_path_static)
endif

.PHONY: wav_clean
wav_clean: $(wav_child_clean_targets) ## remove all wav object files
wav_clean:
	- $(RM) $(wav_clean_files)

.PHONY: wav_test_clean
wav_test_clean: $(wav_test_child_clean_targets) ## remove all wav_test tests
wav_test_clean:
	- $(RM) $(wav_test_install_path_static) $(wav_test_objects) $(wav_test_depends)

.PHONY: wav_re
wav_re: wav_clean
wav_re: wav_all

.PHONY: wav_test_re
wav_test_re: wav_test_clean
wav_test_re: wav_test_all

.PHONY: wav_test_run_all
wav_test_run_all: wav_test_all ## build and run wav_test
wav_test_run_all: $(wav_test_child_run_targets)
ifneq ($(wav_test_objects),)
wav_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(wav_test_install_path_static)
endif

.PHONY: wav_test_run
wav_test_run: wav_test_all
ifneq ($(wav_test_objects),)
wav_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(wav_test_install_path_static)
endif

-include $(wav_depends)
-include $(wav_test_depends)
