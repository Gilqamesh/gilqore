tools_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
tools_child_makefiles			:= $(wildcard $(tools_path_curdir)*/*mk)
tools_child_module_names		:= $(basename $(notdir $(tools_child_makefiles)))
tools_child_all_targets		:= $(foreach child_module,$(tools_child_module_names),$(child_module)_all)
tools_child_strip_targets		:= $(foreach child_module,$(tools_child_module_names),$(child_module)_strip)
tools_child_clean_targets		:= $(foreach child_module,$(tools_child_module_names),$(child_module)_clean)
tools_install_path_shared		:= $(PATH_INSTALL)/tools$(EXT_LIB_SHARED)
tools_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
tools_install_path_implib		:= $(PATH_INSTALL)/libtoolsdll.a
tools_shared_lflags			+= -Wl,--out-implib=$(tools_install_path_implib)
endif
tools_sources					:= $(wildcard $(tools_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
tools_sources					+= $(wildcard $(tools_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
tools_sources					+= $(wildcard $(tools_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
tools_sources					+= $(wildcard $(tools_path_curdir)platform_specific/mac/*.c)
endif
tools_static_objects			:= $(patsubst %.c, %_static.o, $(tools_sources))
tools_shared_objects			:= $(patsubst %.c, %_shared.o, $(tools_sources))
tools_depends					:= $(patsubst %.c, %.d, $(tools_sources))
tools_depends_modules			:=  
tools_depends_libs_shared		:= $(foreach module,$(tools_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
tools_depends_libs_targets		:= $(foreach module,$(tools_depends_modules),$(module)_all)
tools_clean_files				:=
tools_clean_files				+= $(tools_install_path_implib)
tools_clean_files				+= $(tools_install_path_shared)
tools_clean_files				+= $(tools_static_objects)
tools_clean_files				+= $(tools_shared_objects) 
tools_clean_files				+= $(tools_depends)

include $(tools_child_makefiles)

$(tools_path_curdir)%_static.o: $(tools_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(tools_path_curdir)%_shared.o: $(tools_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(tools_install_path_shared): $(tools_depends_libs_shared)
$(tools_install_path_shared): $(tools_static_objects)
$(tools_install_path_shared): $(tools_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(tools_shared_lflags) $(tools_shared_objects) $(tools_depends_libs_shared)

.PHONY: tools_all
tools_all: $(tools_child_all_targets) ## build and install all tools static and shared libraries
ifneq ($(tools_shared_objects),)
tools_all: $(tools_install_path_shared)
endif

.PHONY: tools_clean
tools_clean: $(tools_child_clean_targets) ## remove and deinstall all tools static and shared libraries
tools_clean:
	- $(RM) $(tools_clean_files)

.PHONY: tools_re
tools_re: tools_clean
tools_re: tools_all

.PHONY: tools_strip
tools_strip: $(tools_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
tools_strip:
	- strip --strip-all $(tools_install_path_shared)

-include $(tools_depends)
