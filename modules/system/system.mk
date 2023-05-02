system_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
system_child_makefiles			:= $(wildcard $(system_path_curdir)*/*mk)
system_child_module_names		:= $(basename $(notdir $(system_child_makefiles)))
system_child_all_targets		:= $(foreach child_module,$(system_child_module_names),$(child_module)_all)
system_child_strip_targets		:= $(foreach child_module,$(system_child_module_names),$(child_module)_strip)
system_child_clean_targets		:= $(foreach child_module,$(system_child_module_names),$(child_module)_clean)
system_install_path_shared		:= $(PATH_INSTALL)/system$(EXT_LIB_SHARED)
system_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
system_install_path_implib		:= $(PATH_INSTALL)/libsystemdll.a
system_shared_lflags			+= -Wl,--out-implib=$(system_install_path_implib)
endif
system_sources					:= $(wildcard $(system_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
system_sources					+= $(wildcard $(system_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
system_sources					+= $(wildcard $(system_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
system_sources					+= $(wildcard $(system_path_curdir)platform_specific/mac/*.c)
endif
system_static_objects			:= $(patsubst %.c, %_static.o, $(system_sources))
system_shared_objects			:= $(patsubst %.c, %_shared.o, $(system_sources))
system_depends					:= $(patsubst %.c, %.d, $(system_sources))
system_depends_modules			:=  
system_depends_libs_shared		:= $(foreach module,$(system_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
system_depends_libs_targets		:= $(foreach module,$(system_depends_modules),$(module)_all)
system_clean_files				:=
system_clean_files				+= $(system_install_path_implib)
system_clean_files				+= $(system_install_path_shared)
system_clean_files				+= $(system_static_objects)
system_clean_files				+= $(system_shared_objects) 
system_clean_files				+= $(system_depends)

include $(system_child_makefiles)

$(system_path_curdir)%_static.o: $(system_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(system_path_curdir)%_shared.o: $(system_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(system_install_path_shared): $(system_depends_libs_shared)
$(system_install_path_shared): $(system_static_objects)
$(system_install_path_shared): $(system_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(system_shared_lflags) $(system_shared_objects) $(system_depends_libs_shared)

.PHONY: system_all
system_all: $(system_child_all_targets) ## build and install all system static and shared libraries
ifneq ($(system_shared_objects),)
system_all: $(system_install_path_shared)
endif

.PHONY: system_clean
system_clean: $(system_child_clean_targets) ## remove and deinstall all system static and shared libraries
system_clean:
	- $(RM) $(system_clean_files)

.PHONY: system_re
system_re: system_clean
system_re: system_all

.PHONY: system_strip
system_strip: $(system_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
system_strip:
	- strip --strip-all $(system_install_path_shared)

-include $(system_depends)
