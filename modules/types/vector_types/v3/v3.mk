v3_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
v3_child_makefiles			:= $(wildcard $(v3_path_curdir)*/*mk)
v3_child_module_names		:= $(basename $(notdir $(v3_child_makefiles)))
v3_child_all_targets		:= $(foreach child_module,$(v3_child_module_names),$(child_module)_all)
v3_child_strip_targets		:= $(foreach child_module,$(v3_child_module_names),$(child_module)_strip)
v3_child_clean_targets		:= $(foreach child_module,$(v3_child_module_names),$(child_module)_clean)
v3_install_path_shared		:= $(PATH_INSTALL)/v3$(EXT_LIB_SHARED)
v3_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
v3_install_path_implib		:= $(PATH_INSTALL)/libv3dll.a
v3_shared_lflags			+= -Wl,--out-implib=$(v3_install_path_implib)
endif
v3_sources					:= $(wildcard $(v3_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
v3_sources					+= $(wildcard $(v3_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
v3_sources					+= $(wildcard $(v3_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
v3_sources					+= $(wildcard $(v3_path_curdir)platform_specific/mac/*.c)
endif
v3_static_objects			:= $(patsubst %.c, %_static.o, $(v3_sources))
v3_shared_objects			:= $(patsubst %.c, %_shared.o, $(v3_sources))
v3_depends					:= $(patsubst %.c, %.d, $(v3_sources))
v3_depends_modules			:=  
v3_depends_libs_shared		:= $(foreach module,$(v3_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
v3_depends_libs_targets		:= $(foreach module,$(v3_depends_modules),$(module)_all)
v3_clean_files				:=
v3_clean_files				+= $(v3_install_path_implib)
v3_clean_files				+= $(v3_install_path_shared)
v3_clean_files				+= $(v3_static_objects)
v3_clean_files				+= $(v3_shared_objects) 
v3_clean_files				+= $(v3_depends)

include $(v3_child_makefiles)

$(v3_path_curdir)%_static.o: $(v3_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(v3_path_curdir)%_shared.o: $(v3_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(v3_install_path_shared): $(v3_depends_libs_shared)
$(v3_install_path_shared): $(v3_static_objects)
$(v3_install_path_shared): $(v3_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(v3_shared_lflags) $(v3_shared_objects) $(v3_depends_libs_shared)

.PHONY: v3_all
v3_all: $(v3_child_all_targets) ## build and install all v3 static and shared libraries
ifneq ($(v3_shared_objects),)
v3_all: $(v3_install_path_shared)
endif

.PHONY: v3_clean
v3_clean: $(v3_child_clean_targets) ## remove and deinstall all v3 static and shared libraries
v3_clean:
	- $(RM) $(v3_clean_files)

.PHONY: v3_re
v3_re: v3_clean
v3_re: v3_all

.PHONY: v3_strip
v3_strip: $(v3_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
v3_strip:
	- strip --strip-all $(v3_install_path_shared)

-include $(v3_depends)
