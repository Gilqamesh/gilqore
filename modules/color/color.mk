color_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
color_child_makefiles			:= $(wildcard $(color_path_curdir)*/*mk)
color_child_module_names		:= $(basename $(notdir $(color_child_makefiles)))
color_child_all_targets		:= $(foreach child_module,$(color_child_module_names),$(child_module)_all)
color_child_strip_targets		:= $(foreach child_module,$(color_child_module_names),$(child_module)_strip)
color_child_clean_targets		:= $(foreach child_module,$(color_child_module_names),$(child_module)_clean)
color_install_path_shared		:= $(PATH_INSTALL)/color$(EXT_LIB_SHARED)
color_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
color_install_path_implib		:= $(PATH_INSTALL)/libcolordll.a
color_shared_lflags			+= -Wl,--out-implib=$(color_install_path_implib)
endif
color_sources					:= $(wildcard $(color_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
color_sources					+= $(wildcard $(color_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
color_sources					+= $(wildcard $(color_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
color_sources					+= $(wildcard $(color_path_curdir)platform_specific/mac/*.c)
endif
color_static_objects			:= $(patsubst %.c, %_static.o, $(color_sources))
color_shared_objects			:= $(patsubst %.c, %_shared.o, $(color_sources))
color_depends					:= $(patsubst %.c, %.d, $(color_sources))
color_depends_modules			:=  v4
color_depends_libs_shared		:= $(foreach module,$(color_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
color_depends_libs_targets		:= $(foreach module,$(color_depends_modules),$(module)_all)
color_clean_files				:=
color_clean_files				+= $(color_install_path_implib)
color_clean_files				+= $(color_install_path_shared)
color_clean_files				+= $(color_static_objects)
color_clean_files				+= $(color_shared_objects) 
color_clean_files				+= $(color_depends)

include $(color_child_makefiles)

$(color_path_curdir)%_static.o: $(color_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(color_path_curdir)%_shared.o: $(color_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(color_install_path_shared): $(color_depends_libs_shared)
$(color_install_path_shared): $(color_static_objects)
$(color_install_path_shared): $(color_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(color_shared_lflags) $(color_shared_objects) $(color_depends_libs_shared)

.PHONY: color_all
color_all: $(color_child_all_targets) ## build and install all color static and shared libraries
ifneq ($(color_shared_objects),)
color_all: $(color_install_path_shared)
endif

.PHONY: color_clean
color_clean: $(color_child_clean_targets) ## remove and deinstall all color static and shared libraries
color_clean:
	- $(RM) $(color_clean_files)

.PHONY: color_re
color_re: color_clean
color_re: color_all

.PHONY: color_strip
color_strip: $(color_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
color_strip:
	- strip --strip-all $(color_install_path_shared)

-include $(color_depends)
