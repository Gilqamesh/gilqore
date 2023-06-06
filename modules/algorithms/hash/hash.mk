hash_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
hash_path_curtestdir			:= $(hash_path_curdir)test/
hash_child_makefiles			:= $(wildcard $(hash_path_curdir)*/*mk)
hash_child_module_names		:= $(basename $(notdir $(hash_child_makefiles)))
hash_child_all_targets		:= $(foreach child_module,$(hash_child_module_names),$(child_module)_all)
hash_child_clean_targets		:= $(foreach child_module,$(hash_child_module_names),$(child_module)_clean)
hash_test_child_all_targets	:= $(foreach test_module,$(hash_child_module_names),$(test_module)_test_all)
hash_test_child_clean_targets	:= $(foreach test_module,$(hash_child_module_names),$(test_module)_test_clean)
hash_test_child_run_targets	:= $(foreach test_module,$(hash_child_module_names),$(test_module)_test_run)
ifeq ($(PLATFORM), WINDOWS)
hash_test_install_path_static := $(hash_path_curtestdir)hash_static$(EXT_EXE)
endif
hash_test_sources             := $(wildcard $(hash_path_curtestdir)*.c)
hash_sources					:= $(wildcard $(hash_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
hash_sources					+= $(wildcard $(hash_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
hash_sources					+= $(wildcard $(hash_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
hash_sources					+= $(wildcard $(hash_path_curdir)platform_specific/mac/*.c)
endif
hash_static_objects			:= $(patsubst %.c, %_static.o, $(hash_sources))
hash_test_objects				:= $(patsubst %.c, %.o, $(hash_test_sources))
hash_test_depends				:= $(patsubst %.c, %.d, $(hash_test_sources))
hash_depends					:= $(patsubst %.c, %.d, $(hash_sources))
hash_depends_modules			:= 
hash_test_depends_modules     := hash test_framework libc common process file time system random compare file_reader circular_buffer mod 
hash_test_depends_modules     += hash
hash_test_libdepend_static_objs   = $(foreach dep_module,$(hash_test_depends_modules),$($(dep_module)_static_objects))
hash_clean_files				:=
hash_clean_files				+= $(hash_install_path_implib)
hash_clean_files				+= $(hash_static_objects)
hash_clean_files				+= $(hash_test_objects)
hash_clean_files				+= $(hash_depends)

include $(hash_child_makefiles)

$(hash_path_curtestdir)%.o: $(hash_path_curtestdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_SHARED_EXPORT

$(hash_path_curdir)%_static.o: $(hash_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(hash_test_install_path_static): $(hash_test_objects) $(hash_test_libdepend_static_objs)
	$(CC) -o $@ $(hash_test_objects) -Wl,--allow-multiple-definition $(hash_test_libdepend_static_objs) $(LFLAGS_COMMON) -mconsole

.PHONY: hash_all
hash_all: $(hash_static_objects) ## build all hash object files

.PHONY: hash_test_all
hash_test_all: $(hash_test_install_path_static) ## build hash_test test

.PHONY: hash_clean
hash_clean: $(hash_child_clean_targets) ## remove all hash object files
hash_clean:
	- $(RM) $(hash_clean_files)

.PHONY: hash_test_clean
hash_test_clean: $(hash_test_child_clean_targets) ## remove all hash_test tests
hash_test_clean:
	- $(RM) $(hash_test_install_path_static) $(hash_test_objects) $(hash_test_depends)

.PHONY: hash_re
hash_re: hash_clean
hash_re: hash_all

.PHONY: hash_test_re
hash_test_re: hash_test_clean
hash_test_re: hash_test_all

.PHONY: hash_test_run_all
hash_test_run_all: $(hash_test_child_all_targets) ## build and run hash_test
hash_test_run_all: $(hash_test_child_run_targets)
ifneq ($(hash_test_objects),)
hash_test_run_all: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(hash_test_install_path_static)
endif

.PHONY: hash_test_run
hash_test_run: hash_test_all
ifneq ($(hash_test_objects),)
hash_test_run: $(PATH_INSTALL)/test_framework$(EXT_EXE)
	@$(PATH_INSTALL)/test_framework$(EXT_EXE) $(hash_test_install_path_static)
endif

-include $(hash_depends)
-include $(hash_test_depends)
