wav_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
wav_child_makefiles			:= $(wildcard $(wav_path_curdir)*/*mk)
wav_child_module_names		:= $(basename $(notdir $(wav_child_makefiles)))
wav_child_all_targets		:= $(foreach child_module,$(wav_child_module_names),$(child_module)_all)
wav_child_strip_targets		:= $(foreach child_module,$(wav_child_module_names),$(child_module)_strip)
wav_child_clean_targets		:= $(foreach child_module,$(wav_child_module_names),$(child_module)_clean)
wav_install_path_shared		:= $(PATH_INSTALL)/wav$(EXT_LIB_SHARED)
wav_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
wav_install_path_implib		:= $(PATH_INSTALL)/libwavdll.a
wav_shared_lflags			+= -Wl,--out-implib=$(wav_install_path_implib)
endif
wav_sources					:= $(wildcard $(wav_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
wav_sources					+= $(wildcard $(wav_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
wav_sources					+= $(wildcard $(wav_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
wav_sources					+= $(wildcard $(wav_path_curdir)platform_specific/mac/*.c)
endif
wav_static_objects			:= $(patsubst %.c, %_static.o, $(wav_sources))
wav_shared_objects			:= $(patsubst %.c, %_shared.o, $(wav_sources))
wav_depends					:= $(patsubst %.c, %.d, $(wav_sources))
wav_depends_modules			:=  
wav_depends_libs_shared		:= $(foreach module,$(wav_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
wav_depends_libs_targets		:= $(foreach module,$(wav_depends_modules),$(module)_all)
wav_clean_files				:=
wav_clean_files				+= $(wav_install_path_implib)
wav_clean_files				+= $(wav_install_path_shared)
wav_clean_files				+= $(wav_static_objects)
wav_clean_files				+= $(wav_shared_objects) 
wav_clean_files				+= $(wav_depends)

include $(wav_child_makefiles)

$(wav_path_curdir)%_static.o: $(wav_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(wav_path_curdir)%_shared.o: $(wav_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(wav_install_path_shared): $(wav_depends_libs_shared)
$(wav_install_path_shared): $(wav_static_objects)
$(wav_install_path_shared): $(wav_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(wav_shared_lflags) $(wav_shared_objects) $(wav_depends_libs_shared)

.PHONY: wav_all
wav_all: $(wav_child_all_targets) ## build and install all wav static and shared libraries
ifneq ($(wav_shared_objects),)
wav_all: $(wav_install_path_shared)
endif

.PHONY: wav_clean
wav_clean: $(wav_child_clean_targets) ## remove and deinstall all wav static and shared libraries
wav_clean:
	- $(RM) $(wav_clean_files)

.PHONY: wav_re
wav_re: wav_clean
wav_re: wav_all

.PHONY: wav_strip
wav_strip: $(wav_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
wav_strip:
	- strip --strip-all $(wav_install_path_shared)

-include $(wav_depends)
