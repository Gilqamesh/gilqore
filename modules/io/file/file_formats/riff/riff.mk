riff_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
riff_child_makefiles			:= $(wildcard $(riff_path_curdir)*/*mk)
riff_child_module_names		:= $(basename $(notdir $(riff_child_makefiles)))
riff_child_all_targets		:= $(foreach child_module,$(riff_child_module_names),$(child_module)_all)
riff_child_strip_targets		:= $(foreach child_module,$(riff_child_module_names),$(child_module)_strip)
riff_child_clean_targets		:= $(foreach child_module,$(riff_child_module_names),$(child_module)_clean)
riff_install_path_shared		:= $(PATH_INSTALL)/riff$(EXT_LIB_SHARED)
riff_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
riff_install_path_implib		:= $(PATH_INSTALL)/libriffdll.a
riff_shared_lflags			+= -Wl,--out-implib=$(riff_install_path_implib)
endif
riff_sources					:= $(wildcard $(riff_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
riff_sources					+= $(wildcard $(riff_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
riff_sources					+= $(wildcard $(riff_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
riff_sources					+= $(wildcard $(riff_path_curdir)platform_specific/mac/*.c)
endif
riff_static_objects			:= $(patsubst %.c, %_static.o, $(riff_sources))
riff_shared_objects			:= $(patsubst %.c, %_shared.o, $(riff_sources))
riff_depends					:= $(patsubst %.c, %.d, $(riff_sources))
riff_depends_modules			:= 
riff_depends_libs_shared		:= $(foreach module,$(riff_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# riff_depends_libs_targets		:= $(foreach module,$(riff_depends_modules),$(module)_all)
riff_clean_files				:=
riff_clean_files				+= $(riff_install_path_implib)
riff_clean_files				+= $(riff_install_path_shared)
riff_clean_files				+= $(riff_static_objects)
riff_clean_files				+= $(riff_shared_objects) 
riff_clean_files				+= $(riff_depends)

include $(riff_child_makefiles)

$(riff_path_curdir)%_static.o: $(riff_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(riff_path_curdir)%_shared.o: $(riff_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(riff_install_path_shared): $(riff_depends_libs_shared) $(riff_static_objects) $(riff_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(riff_shared_lflags) $(riff_shared_objects) $(riff_depends_libs_shared)

.PHONY: riff_all
riff_all: $(riff_child_all_targets) ## build and install all riff static and shared libraries
ifneq ($(riff_shared_objects),)
riff_all: $(riff_install_path_shared)
endif

.PHONY: riff_clean
riff_clean: $(riff_child_clean_targets) ## remove and deinstall all riff static and shared libraries
riff_clean:
	- $(RM) $(riff_clean_files)

.PHONY: riff_re
riff_re: riff_clean
riff_re: riff_all

.PHONY: riff_strip
riff_strip: $(riff_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
riff_strip:
	- strip --strip-all $(riff_install_path_shared)

-include $(riff_depends)
