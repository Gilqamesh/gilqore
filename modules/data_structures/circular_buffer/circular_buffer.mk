circular_buffer_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
circular_buffer_child_makefiles			:= $(wildcard $(circular_buffer_path_curdir)*/*mk)
circular_buffer_child_module_names		:= $(basename $(notdir $(circular_buffer_child_makefiles)))
circular_buffer_child_all_targets		:= $(foreach child_module,$(circular_buffer_child_module_names),$(child_module)_all)
circular_buffer_child_strip_targets		:= $(foreach child_module,$(circular_buffer_child_module_names),$(child_module)_strip)
circular_buffer_child_clean_targets		:= $(foreach child_module,$(circular_buffer_child_module_names),$(child_module)_clean)
circular_buffer_install_path_shared		:= $(PATH_INSTALL)/circular_buffer$(EXT_LIB_SHARED)
circular_buffer_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
circular_buffer_install_path_implib		:= $(PATH_INSTALL)/libcircular_bufferdll.a
circular_buffer_shared_lflags			+= -Wl,--out-implib=$(circular_buffer_install_path_implib)
endif
circular_buffer_sources					:= $(wildcard $(circular_buffer_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
circular_buffer_sources					+= $(wildcard $(circular_buffer_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
circular_buffer_sources					+= $(wildcard $(circular_buffer_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
circular_buffer_sources					+= $(wildcard $(circular_buffer_path_curdir)platform_specific/mac/*.c)
endif
circular_buffer_static_objects			:= $(patsubst %.c, %_static.o, $(circular_buffer_sources))
circular_buffer_shared_objects			:= $(patsubst %.c, %_shared.o, $(circular_buffer_sources))
circular_buffer_depends					:= $(patsubst %.c, %.d, $(circular_buffer_sources))
circular_buffer_depends_modules			:=  libc common compare mod
circular_buffer_depends_libs_shared		:= $(foreach module,$(circular_buffer_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
circular_buffer_depends_libs_targets		:= $(foreach module,$(circular_buffer_depends_modules),$(module)_all)
circular_buffer_clean_files				:=
circular_buffer_clean_files				+= $(circular_buffer_install_path_implib)
circular_buffer_clean_files				+= $(circular_buffer_install_path_shared)
circular_buffer_clean_files				+= $(circular_buffer_static_objects)
circular_buffer_clean_files				+= $(circular_buffer_shared_objects) 
circular_buffer_clean_files				+= $(circular_buffer_depends)

include $(circular_buffer_child_makefiles)

$(circular_buffer_path_curdir)%_static.o: $(circular_buffer_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(circular_buffer_path_curdir)%_shared.o: $(circular_buffer_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(circular_buffer_install_path_shared): $(circular_buffer_depends_libs_shared)
$(circular_buffer_install_path_shared): $(circular_buffer_static_objects)
$(circular_buffer_install_path_shared): $(circular_buffer_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(circular_buffer_shared_lflags) $(circular_buffer_shared_objects) $(circular_buffer_depends_libs_shared)

.PHONY: circular_buffer_all
circular_buffer_all: $(circular_buffer_child_all_targets) ## build and install all circular_buffer static and shared libraries
ifneq ($(circular_buffer_shared_objects),)
circular_buffer_all: $(circular_buffer_install_path_shared)
endif

.PHONY: circular_buffer_clean
circular_buffer_clean: $(circular_buffer_child_clean_targets) ## remove and deinstall all circular_buffer static and shared libraries
circular_buffer_clean:
	- $(RM) $(circular_buffer_clean_files)

.PHONY: circular_buffer_re
circular_buffer_re: circular_buffer_clean
circular_buffer_re: circular_buffer_all

.PHONY: circular_buffer_strip
circular_buffer_strip: $(circular_buffer_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
circular_buffer_strip:
	- strip --strip-all $(circular_buffer_install_path_shared)

-include $(circular_buffer_depends)
