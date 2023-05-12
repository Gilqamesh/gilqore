modules_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
modules_child_makefiles			:= $(wildcard $(modules_path_curdir)*/*mk)
modules_child_module_names		:= $(basename $(notdir $(modules_child_makefiles)))
modules_child_all_targets		:= $(foreach child_module,$(modules_child_module_names),$(child_module)_all)
modules_child_strip_targets		:= $(foreach child_module,$(modules_child_module_names),$(child_module)_strip)
modules_child_clean_targets		:= $(foreach child_module,$(modules_child_module_names),$(child_module)_clean)
modules_install_path_shared		:= $(PATH_INSTALL)/modules$(EXT_LIB_SHARED)
modules_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
modules_install_path_implib		:= $(PATH_INSTALL)/libmodulesdll.a
modules_shared_lflags			+= -Wl,--out-implib=$(modules_install_path_implib)
endif
modules_sources					:= $(wildcard $(modules_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
modules_sources					+= $(wildcard $(modules_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
modules_sources					+= $(wildcard $(modules_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
modules_sources					+= $(wildcard $(modules_path_curdir)platform_specific/mac/*.c)
endif
modules_static_objects			:= $(patsubst %.c, %_static.o, $(modules_sources))
modules_shared_objects			:= $(patsubst %.c, %_shared.o, $(modules_sources))
modules_depends					:= $(patsubst %.c, %.d, $(modules_sources))
modules_depends_modules			:= 
modules_depends_libs_shared		:= $(foreach module,$(modules_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# modules_depends_libs_targets		:= $(foreach module,$(modules_depends_modules),$(module)_all)
modules_clean_files				:=
modules_clean_files				+= $(modules_install_path_implib)
modules_clean_files				+= $(modules_install_path_shared)
modules_clean_files				+= $(modules_static_objects)
modules_clean_files				+= $(modules_shared_objects) 
modules_clean_files				+= $(modules_depends)

include $(modules_child_makefiles)

$(modules_path_curdir)%_static.o: $(modules_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(modules_path_curdir)%_shared.o: $(modules_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(modules_install_path_shared): $(modules_depends_libs_shared) $(modules_static_objects) $(modules_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON)  $(modules_shared_lflags) $(modules_shared_objects) $(modules_depends_libs_shared)

.PHONY: modules_all
modules_all: $(modules_child_all_targets) ## build and install all modules static and shared libraries
ifneq ($(modules_shared_objects),)
modules_all: $(modules_install_path_shared)
endif

.PHONY: modules_clean
modules_clean: $(modules_child_clean_targets) ## remove and deinstall all modules static and shared libraries
modules_clean:
	- $(RM) $(modules_clean_files)

.PHONY: modules_re
modules_re: modules_clean
modules_re: modules_all

.PHONY: modules_strip
modules_strip: $(modules_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
modules_strip:
	- strip --strip-all $(modules_install_path_shared)

-include $(modules_depends)
