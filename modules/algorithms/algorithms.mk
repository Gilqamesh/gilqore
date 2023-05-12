algorithms_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
algorithms_child_makefiles			:= $(wildcard $(algorithms_path_curdir)*/*mk)
algorithms_child_module_names		:= $(basename $(notdir $(algorithms_child_makefiles)))
algorithms_child_all_targets		:= $(foreach child_module,$(algorithms_child_module_names),$(child_module)_all)
algorithms_child_strip_targets		:= $(foreach child_module,$(algorithms_child_module_names),$(child_module)_strip)
algorithms_child_clean_targets		:= $(foreach child_module,$(algorithms_child_module_names),$(child_module)_clean)
algorithms_install_path_shared		:= $(PATH_INSTALL)/algorithms$(EXT_LIB_SHARED)
algorithms_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
algorithms_install_path_implib		:= $(PATH_INSTALL)/libalgorithmsdll.a
algorithms_shared_lflags			+= -Wl,--out-implib=$(algorithms_install_path_implib)
endif
algorithms_sources					:= $(wildcard $(algorithms_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
algorithms_sources					+= $(wildcard $(algorithms_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
algorithms_sources					+= $(wildcard $(algorithms_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
algorithms_sources					+= $(wildcard $(algorithms_path_curdir)platform_specific/mac/*.c)
endif
algorithms_static_objects			:= $(patsubst %.c, %_static.o, $(algorithms_sources))
algorithms_shared_objects			:= $(patsubst %.c, %_shared.o, $(algorithms_sources))
algorithms_depends					:= $(patsubst %.c, %.d, $(algorithms_sources))
algorithms_depends_modules			:= 
algorithms_depends_libs_shared		:= $(foreach module,$(algorithms_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# algorithms_depends_libs_targets		:= $(foreach module,$(algorithms_depends_modules),$(module)_all)
algorithms_clean_files				:=
algorithms_clean_files				+= $(algorithms_install_path_implib)
algorithms_clean_files				+= $(algorithms_install_path_shared)
algorithms_clean_files				+= $(algorithms_static_objects)
algorithms_clean_files				+= $(algorithms_shared_objects) 
algorithms_clean_files				+= $(algorithms_depends)

include $(algorithms_child_makefiles)

$(algorithms_path_curdir)%_static.o: $(algorithms_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(algorithms_path_curdir)%_shared.o: $(algorithms_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(algorithms_install_path_shared): $(algorithms_depends_libs_shared) $(algorithms_static_objects) $(algorithms_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(algorithms_shared_lflags) $(algorithms_shared_objects) $(algorithms_depends_libs_shared)

.PHONY: algorithms_all
algorithms_all: $(algorithms_child_all_targets) ## build and install all algorithms static and shared libraries
ifneq ($(algorithms_shared_objects),)
algorithms_all: $(algorithms_install_path_shared)
endif

.PHONY: algorithms_clean
algorithms_clean: $(algorithms_child_clean_targets) ## remove and deinstall all algorithms static and shared libraries
algorithms_clean:
	- $(RM) $(algorithms_clean_files)

.PHONY: algorithms_re
algorithms_re: algorithms_clean
algorithms_re: algorithms_all

.PHONY: algorithms_strip
algorithms_strip: $(algorithms_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
algorithms_strip:
	- strip --strip-all $(algorithms_install_path_shared)

-include $(algorithms_depends)
