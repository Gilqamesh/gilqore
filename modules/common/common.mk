common_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
common_child_makefiles			:= $(wildcard $(common_path_curdir)*/*mk)
common_child_module_names		:= $(basename $(notdir $(common_child_makefiles)))
common_child_all_targets		:= $(foreach child_module,$(common_child_module_names),$(child_module)_all)
common_child_strip_targets		:= $(foreach child_module,$(common_child_module_names),$(child_module)_strip)
common_child_clean_targets		:= $(foreach child_module,$(common_child_module_names),$(child_module)_clean)
common_install_path_shared		:= $(PATH_INSTALL)/common$(EXT_LIB_SHARED)
common_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
common_install_path_implib		:= $(PATH_INSTALL)/libcommondll.a
common_shared_lflags			+= -Wl,--out-implib=$(common_install_path_implib)
endif
common_sources					:= $(wildcard $(common_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
common_sources					+= $(wildcard $(common_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
common_sources					+= $(wildcard $(common_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
common_sources					+= $(wildcard $(common_path_curdir)platform_specific/mac/*.c)
endif
common_static_objects			:= $(patsubst %.c, %_static.o, $(common_sources))
common_shared_objects			:= $(patsubst %.c, %_shared.o, $(common_sources))
common_depends					:= $(patsubst %.c, %.d, $(common_sources))
common_depends_modules			:= 
common_depends_libs_shared		:= $(foreach module,$(common_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# common_depends_libs_targets		:= $(foreach module,$(common_depends_modules),$(module)_all)
common_clean_files				:=
common_clean_files				+= $(common_install_path_implib)
common_clean_files				+= $(common_install_path_shared)
common_clean_files				+= $(common_static_objects)
common_clean_files				+= $(common_shared_objects) 
common_clean_files				+= $(common_depends)

include $(common_child_makefiles)

$(common_path_curdir)%_static.o: $(common_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(common_path_curdir)%_shared.o: $(common_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(common_install_path_shared): $(common_depends_libs_shared) $(common_static_objects) $(common_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON)  $(common_shared_lflags) $(common_shared_objects) $(common_depends_libs_shared)

.PHONY: common_all
common_all: $(common_child_all_targets) ## build and install all common static and shared libraries
ifneq ($(common_shared_objects),)
common_all: $(common_install_path_shared)
endif

.PHONY: common_clean
common_clean: $(common_child_clean_targets) ## remove and deinstall all common static and shared libraries
common_clean:
	- $(RM) $(common_clean_files)

.PHONY: common_re
common_re: common_clean
common_re: common_all

.PHONY: common_strip
common_strip: $(common_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
common_strip:
	- strip --strip-all $(common_install_path_shared)

-include $(common_depends)
