graphics_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
graphics_child_makefiles			:= $(wildcard $(graphics_path_curdir)*/*mk)
graphics_child_module_names		:= $(basename $(notdir $(graphics_child_makefiles)))
graphics_child_all_targets		:= $(foreach child_module,$(graphics_child_module_names),$(child_module)_all)
graphics_child_strip_targets		:= $(foreach child_module,$(graphics_child_module_names),$(child_module)_strip)
graphics_child_clean_targets		:= $(foreach child_module,$(graphics_child_module_names),$(child_module)_clean)
graphics_install_path_shared		:= $(PATH_INSTALL)/graphics$(EXT_LIB_SHARED)
graphics_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
graphics_install_path_implib		:= $(PATH_INSTALL)/libgraphicsdll.a
graphics_shared_lflags			+= -Wl,--out-implib=$(graphics_install_path_implib)
endif
graphics_sources					:= $(wildcard $(graphics_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
graphics_sources					+= $(wildcard $(graphics_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
graphics_sources					+= $(wildcard $(graphics_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
graphics_sources					+= $(wildcard $(graphics_path_curdir)platform_specific/mac/*.c)
endif
graphics_static_objects			:= $(patsubst %.c, %_static.o, $(graphics_sources))
graphics_shared_objects			:= $(patsubst %.c, %_shared.o, $(graphics_sources))
graphics_depends					:= $(patsubst %.c, %.d, $(graphics_sources))
graphics_depends_modules			:=  
graphics_depends_libs_shared		:= $(foreach module,$(graphics_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
graphics_depends_libs_targets		:= $(foreach module,$(graphics_depends_modules),$(module)_all)
graphics_clean_files				:=
graphics_clean_files				+= $(graphics_install_path_implib)
graphics_clean_files				+= $(graphics_install_path_shared)
graphics_clean_files				+= $(graphics_static_objects)
graphics_clean_files				+= $(graphics_shared_objects) 
graphics_clean_files				+= $(graphics_depends)

include $(graphics_child_makefiles)

$(graphics_path_curdir)%_static.o: $(graphics_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(graphics_path_curdir)%_shared.o: $(graphics_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(graphics_install_path_shared): $(graphics_depends_libs_shared)
$(graphics_install_path_shared): $(graphics_static_objects)
$(graphics_install_path_shared): $(graphics_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(graphics_shared_lflags) $(graphics_shared_objects) $(graphics_depends_libs_shared)

.PHONY: graphics_all
graphics_all: $(graphics_child_all_targets) ## build and install all graphics static and shared libraries
ifneq ($(graphics_shared_objects),)
graphics_all: $(graphics_install_path_shared)
endif

.PHONY: graphics_clean
graphics_clean: $(graphics_child_clean_targets) ## remove and deinstall all graphics static and shared libraries
graphics_clean:
	- $(RM) $(graphics_clean_files)

.PHONY: graphics_re
graphics_re: graphics_clean
graphics_re: graphics_all

.PHONY: graphics_strip
graphics_strip: $(graphics_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
graphics_strip:
	- strip --strip-all $(graphics_install_path_shared)

-include $(graphics_depends)
