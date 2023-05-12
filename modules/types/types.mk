types_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
types_child_makefiles			:= $(wildcard $(types_path_curdir)*/*mk)
types_child_module_names		:= $(basename $(notdir $(types_child_makefiles)))
types_child_all_targets		:= $(foreach child_module,$(types_child_module_names),$(child_module)_all)
types_child_strip_targets		:= $(foreach child_module,$(types_child_module_names),$(child_module)_strip)
types_child_clean_targets		:= $(foreach child_module,$(types_child_module_names),$(child_module)_clean)
types_install_path_shared		:= $(PATH_INSTALL)/types$(EXT_LIB_SHARED)
types_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
types_install_path_implib		:= $(PATH_INSTALL)/libtypesdll.a
types_shared_lflags			+= -Wl,--out-implib=$(types_install_path_implib)
endif
types_sources					:= $(wildcard $(types_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
types_sources					+= $(wildcard $(types_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
types_sources					+= $(wildcard $(types_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
types_sources					+= $(wildcard $(types_path_curdir)platform_specific/mac/*.c)
endif
types_static_objects			:= $(patsubst %.c, %_static.o, $(types_sources))
types_shared_objects			:= $(patsubst %.c, %_shared.o, $(types_sources))
types_depends					:= $(patsubst %.c, %.d, $(types_sources))
types_depends_modules			:= 
types_depends_libs_shared		:= $(foreach module,$(types_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# types_depends_libs_targets		:= $(foreach module,$(types_depends_modules),$(module)_all)
types_clean_files				:=
types_clean_files				+= $(types_install_path_implib)
types_clean_files				+= $(types_install_path_shared)
types_clean_files				+= $(types_static_objects)
types_clean_files				+= $(types_shared_objects) 
types_clean_files				+= $(types_depends)

include $(types_child_makefiles)

$(types_path_curdir)%_static.o: $(types_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(types_path_curdir)%_shared.o: $(types_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(types_install_path_shared): $(types_depends_libs_shared) $(types_static_objects) $(types_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON)  $(types_shared_lflags) $(types_shared_objects) $(types_depends_libs_shared)

.PHONY: types_all
types_all: $(types_child_all_targets) ## build and install all types static and shared libraries
ifneq ($(types_shared_objects),)
types_all: $(types_install_path_shared)
endif

.PHONY: types_clean
types_clean: $(types_child_clean_targets) ## remove and deinstall all types static and shared libraries
types_clean:
	- $(RM) $(types_clean_files)

.PHONY: types_re
types_re: types_clean
types_re: types_all

.PHONY: types_strip
types_strip: $(types_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
types_strip:
	- strip --strip-all $(types_install_path_shared)

-include $(types_depends)
