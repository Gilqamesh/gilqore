gmc_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
gmc_child_makefiles			:= $(wildcard $(gmc_path_curdir)*/*mk)
gmc_child_module_names		:= $(basename $(notdir $(gmc_child_makefiles)))
gmc_child_all_targets		:= $(foreach child_module,$(gmc_child_module_names),$(child_module)_all)
gmc_child_strip_targets		:= $(foreach child_module,$(gmc_child_module_names),$(child_module)_strip)
gmc_child_clean_targets		:= $(foreach child_module,$(gmc_child_module_names),$(child_module)_clean)
gmc_install_path_shared		:= $(PATH_INSTALL)/gmc$(EXT_LIB_SHARED)
gmc_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
gmc_install_path_implib		:= $(PATH_INSTALL)/libgmcdll.a
gmc_shared_lflags			+= -Wl,--out-implib=$(gmc_install_path_implib)
endif
gmc_sources					:= $(wildcard $(gmc_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
gmc_sources					+= $(wildcard $(gmc_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
gmc_sources					+= $(wildcard $(gmc_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
gmc_sources					+= $(wildcard $(gmc_path_curdir)platform_specific/mac/*.c)
endif
gmc_static_objects			:= $(patsubst %.c, %_static.o, $(gmc_sources))
gmc_shared_objects			:= $(patsubst %.c, %_shared.o, $(gmc_sources))
gmc_depends					:= $(patsubst %.c, %.d, $(gmc_sources))
gmc_depends_modules			:= 
gmc_depends_libs_shared		:= $(foreach module,$(gmc_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# gmc_depends_libs_targets		:= $(foreach module,$(gmc_depends_modules),$(module)_all)
gmc_clean_files				:=
gmc_clean_files				+= $(gmc_install_path_implib)
gmc_clean_files				+= $(gmc_install_path_shared)
gmc_clean_files				+= $(gmc_static_objects)
gmc_clean_files				+= $(gmc_shared_objects) 
gmc_clean_files				+= $(gmc_depends)

include $(gmc_child_makefiles)

$(gmc_path_curdir)%_static.o: $(gmc_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(gmc_path_curdir)%_shared.o: $(gmc_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(gmc_install_path_shared): $(gmc_depends_libs_shared) $(gmc_static_objects) $(gmc_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(gmc_shared_lflags) $(gmc_shared_objects) $(gmc_depends_libs_shared)

.PHONY: gmc_all
gmc_all: $(gmc_child_all_targets) ## build and install all gmc static and shared libraries
ifneq ($(gmc_shared_objects),)
gmc_all: $(gmc_install_path_shared)
endif

.PHONY: gmc_clean
gmc_clean: $(gmc_child_clean_targets) ## remove and deinstall all gmc static and shared libraries
gmc_clean:
	- $(RM) $(gmc_clean_files)

.PHONY: gmc_re
gmc_re: gmc_clean
gmc_re: gmc_all

.PHONY: gmc_strip
gmc_strip: $(gmc_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
gmc_strip:
	- strip --strip-all $(gmc_install_path_shared)

-include $(gmc_depends)
