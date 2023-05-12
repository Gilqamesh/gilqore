clamp_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
clamp_child_makefiles			:= $(wildcard $(clamp_path_curdir)*/*mk)
clamp_child_module_names		:= $(basename $(notdir $(clamp_child_makefiles)))
clamp_child_all_targets		:= $(foreach child_module,$(clamp_child_module_names),$(child_module)_all)
clamp_child_strip_targets		:= $(foreach child_module,$(clamp_child_module_names),$(child_module)_strip)
clamp_child_clean_targets		:= $(foreach child_module,$(clamp_child_module_names),$(child_module)_clean)
clamp_install_path_shared		:= $(PATH_INSTALL)/clamp$(EXT_LIB_SHARED)
clamp_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
clamp_install_path_implib		:= $(PATH_INSTALL)/libclampdll.a
clamp_shared_lflags			+= -Wl,--out-implib=$(clamp_install_path_implib)
endif
clamp_sources					:= $(wildcard $(clamp_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
clamp_sources					+= $(wildcard $(clamp_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
clamp_sources					+= $(wildcard $(clamp_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
clamp_sources					+= $(wildcard $(clamp_path_curdir)platform_specific/mac/*.c)
endif
clamp_static_objects			:= $(patsubst %.c, %_static.o, $(clamp_sources))
clamp_shared_objects			:= $(patsubst %.c, %_shared.o, $(clamp_sources))
clamp_depends					:= $(patsubst %.c, %.d, $(clamp_sources))
clamp_depends_modules			:= v2 v3 v4 
clamp_depends_libs_shared		:= $(foreach module,$(clamp_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# clamp_depends_libs_targets		:= $(foreach module,$(clamp_depends_modules),$(module)_all)
clamp_clean_files				:=
clamp_clean_files				+= $(clamp_install_path_implib)
clamp_clean_files				+= $(clamp_install_path_shared)
clamp_clean_files				+= $(clamp_static_objects)
clamp_clean_files				+= $(clamp_shared_objects) 
clamp_clean_files				+= $(clamp_depends)

include $(clamp_child_makefiles)

$(clamp_path_curdir)%_static.o: $(clamp_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(clamp_path_curdir)%_shared.o: $(clamp_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(clamp_install_path_shared): $(clamp_depends_libs_shared) $(clamp_static_objects) $(clamp_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON)  $(clamp_shared_lflags) $(clamp_shared_objects) $(clamp_depends_libs_shared)

.PHONY: clamp_all
clamp_all: $(clamp_child_all_targets) ## build and install all clamp static and shared libraries
ifneq ($(clamp_shared_objects),)
clamp_all: $(clamp_install_path_shared)
endif

.PHONY: clamp_clean
clamp_clean: $(clamp_child_clean_targets) ## remove and deinstall all clamp static and shared libraries
clamp_clean:
	- $(RM) $(clamp_clean_files)

.PHONY: clamp_re
clamp_re: clamp_clean
clamp_re: clamp_all

.PHONY: clamp_strip
clamp_strip: $(clamp_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
clamp_strip:
	- strip --strip-all $(clamp_install_path_shared)

-include $(clamp_depends)
