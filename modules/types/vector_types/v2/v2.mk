v2_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
v2_child_makefiles			:= $(wildcard $(v2_path_curdir)*/*mk)
v2_child_module_names		:= $(basename $(notdir $(v2_child_makefiles)))
v2_child_all_targets		:= $(foreach child_module,$(v2_child_module_names),$(child_module)_all)
v2_child_strip_targets		:= $(foreach child_module,$(v2_child_module_names),$(child_module)_strip)
v2_child_clean_targets		:= $(foreach child_module,$(v2_child_module_names),$(child_module)_clean)
v2_install_path_shared		:= $(PATH_INSTALL)/v2$(EXT_LIB_SHARED)
v2_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
v2_install_path_implib		:= $(PATH_INSTALL)/libv2dll.a
v2_shared_lflags			+= -Wl,--out-implib=$(v2_install_path_implib)
endif
v2_sources					:= $(wildcard $(v2_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
v2_sources					+= $(wildcard $(v2_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
v2_sources					+= $(wildcard $(v2_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
v2_sources					+= $(wildcard $(v2_path_curdir)platform_specific/mac/*.c)
endif
v2_static_objects			:= $(patsubst %.c, %_static.o, $(v2_sources))
v2_shared_objects			:= $(patsubst %.c, %_shared.o, $(v2_sources))
v2_depends					:= $(patsubst %.c, %.d, $(v2_sources))
v2_depends_modules			:= 
v2_depends_libs_shared		:= $(foreach module,$(v2_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# v2_depends_libs_targets		:= $(foreach module,$(v2_depends_modules),$(module)_all)
v2_clean_files				:=
v2_clean_files				+= $(v2_install_path_implib)
v2_clean_files				+= $(v2_install_path_shared)
v2_clean_files				+= $(v2_static_objects)
v2_clean_files				+= $(v2_shared_objects) 
v2_clean_files				+= $(v2_depends)

include $(v2_child_makefiles)

$(v2_path_curdir)%_static.o: $(v2_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(v2_path_curdir)%_shared.o: $(v2_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(v2_install_path_shared): $(v2_depends_libs_shared) $(v2_static_objects) $(v2_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON)  $(v2_shared_lflags) $(v2_shared_objects) $(v2_depends_libs_shared)

.PHONY: v2_all
v2_all: $(v2_child_all_targets) ## build and install all v2 static and shared libraries
ifneq ($(v2_shared_objects),)
v2_all: $(v2_install_path_shared)
endif

.PHONY: v2_clean
v2_clean: $(v2_child_clean_targets) ## remove and deinstall all v2 static and shared libraries
v2_clean:
	- $(RM) $(v2_clean_files)

.PHONY: v2_re
v2_re: v2_clean
v2_re: v2_all

.PHONY: v2_strip
v2_strip: $(v2_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
v2_strip:
	- strip --strip-all $(v2_install_path_shared)

-include $(v2_depends)
