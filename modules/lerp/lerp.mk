lerp_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
lerp_child_makefiles			:= $(wildcard $(lerp_path_curdir)*/*mk)
lerp_child_module_names		:= $(basename $(notdir $(lerp_child_makefiles)))
lerp_child_all_targets		:= $(foreach child_module,$(lerp_child_module_names),$(child_module)_all)
lerp_child_strip_targets		:= $(foreach child_module,$(lerp_child_module_names),$(child_module)_strip)
lerp_child_clean_targets		:= $(foreach child_module,$(lerp_child_module_names),$(child_module)_clean)
lerp_install_path_shared		:= $(PATH_INSTALL)/lerp$(EXT_LIB_SHARED)
lerp_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
lerp_install_path_implib		:= $(PATH_INSTALL)/liblerpdll.a
lerp_shared_lflags			+= -Wl,--out-implib=$(lerp_install_path_implib)
endif
lerp_sources					:= $(wildcard $(lerp_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
lerp_sources					+= $(wildcard $(lerp_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
lerp_sources					+= $(wildcard $(lerp_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
lerp_sources					+= $(wildcard $(lerp_path_curdir)platform_specific/mac/*.c)
endif
lerp_static_objects			:= $(patsubst %.c, %_static.o, $(lerp_sources))
lerp_shared_objects			:= $(patsubst %.c, %_shared.o, $(lerp_sources))
lerp_depends					:= $(patsubst %.c, %.d, $(lerp_sources))
lerp_depends_modules			:=  color
lerp_depends_libs_shared		:= $(foreach module,$(lerp_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
lerp_depends_libs_targets		:= $(foreach module,$(lerp_depends_modules),$(module)_all)
lerp_clean_files				:=
lerp_clean_files				+= $(lerp_install_path_implib)
lerp_clean_files				+= $(lerp_install_path_shared)
lerp_clean_files				+= $(lerp_static_objects)
lerp_clean_files				+= $(lerp_shared_objects) 
lerp_clean_files				+= $(lerp_depends)

include $(lerp_child_makefiles)

$(lerp_path_curdir)%_static.o: $(lerp_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(lerp_path_curdir)%_shared.o: $(lerp_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(lerp_install_path_shared): $(lerp_depends_libs_shared)
$(lerp_install_path_shared): $(lerp_static_objects)
$(lerp_install_path_shared): $(lerp_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(lerp_shared_lflags) $(lerp_shared_objects) $(lerp_depends_libs_shared)

.PHONY: lerp_all
lerp_all: $(lerp_child_all_targets) ## build and install all lerp static and shared libraries
ifneq ($(lerp_shared_objects),)
lerp_all: $(lerp_install_path_shared)
endif

.PHONY: lerp_clean
lerp_clean: $(lerp_child_clean_targets) ## remove and deinstall all lerp static and shared libraries
lerp_clean:
	- $(RM) $(lerp_clean_files)

.PHONY: lerp_re
lerp_re: lerp_clean
lerp_re: lerp_all

.PHONY: lerp_strip
lerp_strip: $(lerp_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
lerp_strip:
	- strip --strip-all $(lerp_install_path_shared)

-include $(lerp_depends)
