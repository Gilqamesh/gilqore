random_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
random_child_makefiles			:= $(wildcard $(random_path_curdir)*/*mk)
random_child_module_names		:= $(basename $(notdir $(random_child_makefiles)))
random_child_all_targets		:= $(foreach child_module,$(random_child_module_names),$(child_module)_all)
random_child_strip_targets		:= $(foreach child_module,$(random_child_module_names),$(child_module)_strip)
random_child_clean_targets		:= $(foreach child_module,$(random_child_module_names),$(child_module)_clean)
random_install_path_shared		:= $(PATH_INSTALL)/random$(EXT_LIB_SHARED)
random_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
random_install_path_implib		:= $(PATH_INSTALL)/librandomdll.a
random_shared_lflags			+= -Wl,--out-implib=$(random_install_path_implib)
endif
random_sources					:= $(wildcard $(random_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
random_sources					+= $(wildcard $(random_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
random_sources					+= $(wildcard $(random_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
random_sources					+= $(wildcard $(random_path_curdir)platform_specific/mac/*.c)
endif
random_static_objects			:= $(patsubst %.c, %_static.o, $(random_sources))
random_shared_objects			:= $(patsubst %.c, %_shared.o, $(random_sources))
random_depends					:= $(patsubst %.c, %.d, $(random_sources))
random_depends_modules			:=  
random_depends_libs_shared		:= $(foreach module,$(random_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
random_depends_libs_targets		:= $(foreach module,$(random_depends_modules),$(module)_all)
random_clean_files				:=
random_clean_files				+= $(random_install_path_implib)
random_clean_files				+= $(random_install_path_shared)
random_clean_files				+= $(random_static_objects)
random_clean_files				+= $(random_shared_objects) 
random_clean_files				+= $(random_depends)

include $(random_child_makefiles)

$(random_path_curdir)%_static.o: $(random_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(random_path_curdir)%_shared.o: $(random_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(random_install_path_shared): $(random_depends_libs_shared)
$(random_install_path_shared): $(random_static_objects)
$(random_install_path_shared): $(random_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(random_shared_lflags) $(random_shared_objects) $(random_depends_libs_shared)

.PHONY: random_all
random_all: $(random_child_all_targets) ## build and install all random static and shared libraries
ifneq ($(random_shared_objects),)
random_all: $(random_install_path_shared)
endif

.PHONY: random_clean
random_clean: $(random_child_clean_targets) ## remove and deinstall all random static and shared libraries
random_clean:
	- $(RM) $(random_clean_files)

.PHONY: random_re
random_re: random_clean
random_re: random_all

.PHONY: random_strip
random_strip: $(random_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
random_strip:
	- strip --strip-all $(random_install_path_shared)

-include $(random_depends)
