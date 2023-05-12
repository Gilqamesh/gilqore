sqrt_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
sqrt_child_makefiles			:= $(wildcard $(sqrt_path_curdir)*/*mk)
sqrt_child_module_names		:= $(basename $(notdir $(sqrt_child_makefiles)))
sqrt_child_all_targets		:= $(foreach child_module,$(sqrt_child_module_names),$(child_module)_all)
sqrt_child_strip_targets		:= $(foreach child_module,$(sqrt_child_module_names),$(child_module)_strip)
sqrt_child_clean_targets		:= $(foreach child_module,$(sqrt_child_module_names),$(child_module)_clean)
sqrt_install_path_shared		:= $(PATH_INSTALL)/sqrt$(EXT_LIB_SHARED)
sqrt_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
sqrt_install_path_implib		:= $(PATH_INSTALL)/libsqrtdll.a
sqrt_shared_lflags			+= -Wl,--out-implib=$(sqrt_install_path_implib)
endif
sqrt_sources					:= $(wildcard $(sqrt_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
sqrt_sources					+= $(wildcard $(sqrt_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
sqrt_sources					+= $(wildcard $(sqrt_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
sqrt_sources					+= $(wildcard $(sqrt_path_curdir)platform_specific/mac/*.c)
endif
sqrt_static_objects			:= $(patsubst %.c, %_static.o, $(sqrt_sources))
sqrt_shared_objects			:= $(patsubst %.c, %_shared.o, $(sqrt_sources))
sqrt_depends					:= $(patsubst %.c, %.d, $(sqrt_sources))
sqrt_depends_modules			:= 
sqrt_depends_libs_shared		:= $(foreach module,$(sqrt_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# sqrt_depends_libs_targets		:= $(foreach module,$(sqrt_depends_modules),$(module)_all)
sqrt_clean_files				:=
sqrt_clean_files				+= $(sqrt_install_path_implib)
sqrt_clean_files				+= $(sqrt_install_path_shared)
sqrt_clean_files				+= $(sqrt_static_objects)
sqrt_clean_files				+= $(sqrt_shared_objects) 
sqrt_clean_files				+= $(sqrt_depends)

include $(sqrt_child_makefiles)

$(sqrt_path_curdir)%_static.o: $(sqrt_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(sqrt_path_curdir)%_shared.o: $(sqrt_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(sqrt_install_path_shared): $(sqrt_depends_libs_shared) $(sqrt_static_objects) $(sqrt_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON)  $(sqrt_shared_lflags) $(sqrt_shared_objects) $(sqrt_depends_libs_shared)

.PHONY: sqrt_all
sqrt_all: $(sqrt_child_all_targets) ## build and install all sqrt static and shared libraries
ifneq ($(sqrt_shared_objects),)
sqrt_all: $(sqrt_install_path_shared)
endif

.PHONY: sqrt_clean
sqrt_clean: $(sqrt_child_clean_targets) ## remove and deinstall all sqrt static and shared libraries
sqrt_clean:
	- $(RM) $(sqrt_clean_files)

.PHONY: sqrt_re
sqrt_re: sqrt_clean
sqrt_re: sqrt_all

.PHONY: sqrt_strip
sqrt_strip: $(sqrt_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
sqrt_strip:
	- strip --strip-all $(sqrt_install_path_shared)

-include $(sqrt_depends)
