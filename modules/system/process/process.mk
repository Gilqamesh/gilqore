process_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
process_child_makefiles			:= $(wildcard $(process_path_curdir)*/*mk)
process_child_module_names		:= $(basename $(notdir $(process_child_makefiles)))
process_child_all_targets		:= $(foreach child_module,$(process_child_module_names),$(child_module)_all)
process_child_strip_targets		:= $(foreach child_module,$(process_child_module_names),$(child_module)_strip)
process_child_clean_targets		:= $(foreach child_module,$(process_child_module_names),$(child_module)_clean)
process_install_path_shared		:= $(PATH_INSTALL)/process$(EXT_LIB_SHARED)
process_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
process_install_path_implib		:= $(PATH_INSTALL)/libprocessdll.a
process_shared_lflags			+= -Wl,--out-implib=$(process_install_path_implib)
endif
process_sources					:= $(wildcard $(process_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
process_sources					+= $(wildcard $(process_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
process_sources					+= $(wildcard $(process_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
process_sources					+= $(wildcard $(process_path_curdir)platform_specific/mac/*.c)
endif
process_static_objects			:= $(patsubst %.c, %_static.o, $(process_sources))
process_shared_objects			:= $(patsubst %.c, %_shared.o, $(process_sources))
process_depends					:= $(patsubst %.c, %.d, $(process_sources))
process_depends_modules			:= 
process_depends_libs_shared		:= $(foreach module,$(process_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# process_depends_libs_targets		:= $(foreach module,$(process_depends_modules),$(module)_all)
process_clean_files				:=
process_clean_files				+= $(process_install_path_implib)
process_clean_files				+= $(process_install_path_shared)
process_clean_files				+= $(process_static_objects)
process_clean_files				+= $(process_shared_objects) 
process_clean_files				+= $(process_depends)

include $(process_child_makefiles)

$(process_path_curdir)%_static.o: $(process_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(process_path_curdir)%_shared.o: $(process_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(process_install_path_shared): $(process_depends_libs_shared) $(process_static_objects) $(process_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON)  $(process_shared_lflags) $(process_shared_objects) $(process_depends_libs_shared)

.PHONY: process_all
process_all: $(process_child_all_targets) ## build and install all process static and shared libraries
ifneq ($(process_shared_objects),)
process_all: $(process_install_path_shared)
endif

.PHONY: process_clean
process_clean: $(process_child_clean_targets) ## remove and deinstall all process static and shared libraries
process_clean:
	- $(RM) $(process_clean_files)

.PHONY: process_re
process_re: process_clean
process_re: process_all

.PHONY: process_strip
process_strip: $(process_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
process_strip:
	- strip --strip-all $(process_install_path_shared)

-include $(process_depends)
