circular_buffer_test_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
circular_buffer_test_path_curtestdir			:= $(circular_buffer_test_path_curdir)test/
circular_buffer_test_child_makefiles			:= $(wildcard $(circular_buffer_test_path_curdir)*/*mk)
circular_buffer_test_child_module_names		:= $(basename $(notdir $(circular_buffer_test_child_makefiles)))
circular_buffer_test_child_all_targets		:= $(foreach child_module,$(circular_buffer_test_child_module_names),$(child_module)_all)
circular_buffer_test_child_strip_targets		:= $(foreach child_module,$(circular_buffer_test_child_module_names),$(child_module)_strip)
circular_buffer_test_child_clean_targets		:= $(foreach child_module,$(circular_buffer_test_child_module_names),$(child_module)_clean)
circular_buffer_test_test_child_all_targets	:= $(foreach test_module,$(circular_buffer_test_child_module_names),$(test_module)_test_all)
circular_buffer_test_test_child_clean_targets	:= $(foreach test_module,$(circular_buffer_test_child_module_names),$(test_module)_test_clean)
circular_buffer_test_test_child_run_targets	:= $(foreach test_module,$(circular_buffer_test_child_module_names),$(test_module)_test_run)
circular_buffer_test_install_path_shared		:= $(PATH_INSTALL)/circular_buffer_test$(EXT_LIB_SHARED)
circular_buffer_test_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
circular_buffer_test_test_install_path_static := $(circular_buffer_test_path_curdir)circular_buffer_test_static$(EXT_EXE)
circular_buffer_test_install_path_implib		:= $(PATH_INSTALL)/libcircular_buffer_testdll.a
circular_buffer_test_shared_lflags			+= -Wl,--out-implib=$(circular_buffer_test_install_path_implib)
endif
circular_buffer_test_test_sources             := $(wildcard $(circular_buffer_test_path_curtestdir)*.c)
circular_buffer_test_sources					:= $(wildcard $(circular_buffer_test_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
circular_buffer_test_sources					+= $(wildcard $(circular_buffer_test_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
circular_buffer_test_sources					+= $(wildcard $(circular_buffer_test_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
circular_buffer_test_sources					+= $(wildcard $(circular_buffer_test_path_curdir)platform_specific/mac/*.c)
endif
circular_buffer_test_static_objects			:= $(patsubst %.c, %_static.o, $(circular_buffer_test_sources))
circular_buffer_test_test_objects				:= $(patsubst %.c, %.o, $(circular_buffer_test_test_sources))
circular_buffer_test_test_depends				:= $(patsubst %.c, %.d, $(circular_buffer_test_test_sources))
circular_buffer_test_shared_objects			:= $(patsubst %.c, %_shared.o, $(circular_buffer_test_sources))
circular_buffer_test_depends					:= $(patsubst %.c, %.d, $(circular_buffer_test_sources))
circular_buffer_test_depends_modules			:= 
circular_buffer_test_test_depends_modules     += circular_buffer_test
circular_buffer_test_test_libdepend_static_objs   = $(foreach dep_module,$(circular_buffer_test_depends_modules),$($(dep_module)_static_objects))
circular_buffer_test_test_libdepend_static_objs   += $(circular_buffer_test_static_objects)
circular_buffer_test_depends_libs_shared		:= $(foreach module,$(circular_buffer_test_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# circular_buffer_test_depends_libs_targets		:= $(foreach module,$(circular_buffer_test_depends_modules),$(module)_all)
circular_buffer_test_clean_files				:=
circular_buffer_test_clean_files				+= $(circular_buffer_test_install_path_implib)
circular_buffer_test_clean_files				+= $(circular_buffer_test_install_path_shared)
circular_buffer_test_clean_files				+= $(circular_buffer_test_static_objects)
circular_buffer_test_clean_files				+= $(circular_buffer_test_shared_objects) 
circular_buffer_test_clean_files				+= $(circular_buffer_test_depends)
 
include $(circular_buffer_test_child_makefiles)

$(circular_buffer_test_path_curtestdir)%.o: $(circular_buffer_test_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(circular_buffer_test_path_curdir)%_static.o: $(circular_buffer_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(circular_buffer_test_path_curdir)%_shared.o: $(circular_buffer_test_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(circular_buffer_test_install_path_shared): $(circular_buffer_test_depends_libs_shared) $(circular_buffer_test_static_objects) $(circular_buffer_test_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(circular_buffer_test_shared_lflags) $(circular_buffer_test_shared_objects) $(circular_buffer_test_depends_libs_shared)

$(circular_buffer_test_test_install_path_static): $(circular_buffer_test_test_objects) $(circular_buffer_test_test_libdepend_static_objs)
	$(CC) -o $@ $(circular_buffer_test_test_objects) -Wl,--allow-multiple-definition $(circular_buffer_test_test_libdepend_static_objs) $(LFLAGS_COMMON) $(LFLAGS_SPECIFIC)

.PHONY: circular_buffer_test_all
circular_buffer_test_all: $(circular_buffer_test_child_all_targets) ## build and install all circular_buffer_test static and shared libraries
ifneq ($(circular_buffer_test_shared_objects),)
circular_buffer_test_all: $(circular_buffer_test_install_path_shared)
endif

.PHONY: circular_buffer_test_test_all
circular_buffer_test_test_all: $(circular_buffer_test_test_child_all_targets) ## build all circular_buffer_test_test tests
ifneq ($(circular_buffer_test_test_objects),)
circular_buffer_test_test_all: $(circular_buffer_test_test_install_path_static)
endif

.PHONY: circular_buffer_test_clean
circular_buffer_test_clean: $(circular_buffer_test_child_clean_targets) ## remove and deinstall all circular_buffer_test static and shared libraries
circular_buffer_test_clean:
	- $(RM) $(circular_buffer_test_clean_files)

.PHONY: circular_buffer_test_test_clean
circular_buffer_test_test_clean: $(circular_buffer_test_test_child_clean_targets) ## remove all circular_buffer_test_test tests
circular_buffer_test_test_clean:
	- $(RM) $(circular_buffer_test_test_install_path_static) $(circular_buffer_test_test_objects) $(circular_buffer_test_test_depends)

.PHONY: circular_buffer_test_re
circular_buffer_test_re: circular_buffer_test_clean
circular_buffer_test_re: circular_buffer_test_all

.PHONY: circular_buffer_test_test_re
circular_buffer_test_test_re: circular_buffer_test_test_clean
circular_buffer_test_test_re: circular_buffer_test_test_all

.PHONY: circular_buffer_test_test_run_all
circular_buffer_test_test_run_all: circular_buffer_test_test_all ## build and run static circular_buffer_test_test
circular_buffer_test_test_run_all: $(circular_buffer_test_test_child_run_targets)
ifneq ($(circular_buffer_test_test_objects),)
circular_buffer_test_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(circular_buffer_test_test_install_path_static)
endif

.PHONY: circular_buffer_test_test_run
circular_buffer_test_test_run: circular_buffer_test_test_all
ifneq ($(circular_buffer_test_test_objects),)
circular_buffer_test_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(circular_buffer_test_test_install_path_static)
endif

.PHONY: circular_buffer_test_strip
circular_buffer_test_strip: $(circular_buffer_test_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
circular_buffer_test_strip:
	- strip --strip-all $(circular_buffer_test_install_path_shared)

-include $(circular_buffer_test_depends)
-include $(circular_buffer_test_test_depends)
