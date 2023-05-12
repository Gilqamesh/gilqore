v4_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
v4_child_makefiles			:= $(wildcard $(v4_path_curdir)*/*mk)
v4_child_module_names		:= $(basename $(notdir $(v4_child_makefiles)))
v4_child_all_targets		:= $(foreach child_module,$(v4_child_module_names),$(child_module)_all)
v4_child_strip_targets		:= $(foreach child_module,$(v4_child_module_names),$(child_module)_strip)
v4_child_clean_targets		:= $(foreach child_module,$(v4_child_module_names),$(child_module)_clean)
v4_install_path_shared		:= $(PATH_INSTALL)/v4$(EXT_LIB_SHARED)
v4_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
v4_install_path_implib		:= $(PATH_INSTALL)/libv4dll.a
v4_shared_lflags			+= -Wl,--out-implib=$(v4_install_path_implib)
endif
v4_sources					:= $(wildcard $(v4_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
v4_sources					+= $(wildcard $(v4_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
v4_sources					+= $(wildcard $(v4_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
v4_sources					+= $(wildcard $(v4_path_curdir)platform_specific/mac/*.c)
endif
v4_static_objects			:= $(patsubst %.c, %_static.o, $(v4_sources))
v4_shared_objects			:= $(patsubst %.c, %_shared.o, $(v4_sources))
v4_depends					:= $(patsubst %.c, %.d, $(v4_sources))
v4_depends_modules			:= 
v4_depends_libs_shared		:= $(foreach module,$(v4_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# v4_depends_libs_targets		:= $(foreach module,$(v4_depends_modules),$(module)_all)
v4_clean_files				:=
v4_clean_files				+= $(v4_install_path_implib)
v4_clean_files				+= $(v4_install_path_shared)
v4_clean_files				+= $(v4_static_objects)
v4_clean_files				+= $(v4_shared_objects) 
v4_clean_files				+= $(v4_depends)

include $(v4_child_makefiles)

$(v4_path_curdir)%_static.o: $(v4_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(v4_path_curdir)%_shared.o: $(v4_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(v4_install_path_shared): $(v4_depends_libs_shared) $(v4_static_objects) $(v4_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(v4_shared_lflags) $(v4_shared_objects) $(v4_depends_libs_shared)

.PHONY: v4_all
v4_all: $(v4_child_all_targets) ## build and install all v4 static and shared libraries
ifneq ($(v4_shared_objects),)
v4_all: $(v4_install_path_shared)
endif

.PHONY: v4_clean
v4_clean: $(v4_child_clean_targets) ## remove and deinstall all v4 static and shared libraries
v4_clean:
	- $(RM) $(v4_clean_files)

.PHONY: v4_re
v4_re: v4_clean
v4_re: v4_all

.PHONY: v4_strip
v4_strip: $(v4_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
v4_strip:
	- strip --strip-all $(v4_install_path_shared)

-include $(v4_depends)
