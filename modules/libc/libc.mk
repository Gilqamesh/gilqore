libc_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
libc_child_makefiles			:= $(wildcard $(libc_path_curdir)*/*mk)
libc_child_module_names		:= $(basename $(notdir $(libc_child_makefiles)))
libc_child_all_targets		:= $(foreach child_module,$(libc_child_module_names),$(child_module)_all)
libc_child_strip_targets		:= $(foreach child_module,$(libc_child_module_names),$(child_module)_strip)
libc_child_clean_targets		:= $(foreach child_module,$(libc_child_module_names),$(child_module)_clean)
libc_install_path_shared		:= $(PATH_INSTALL)/libc$(EXT_LIB_SHARED)
libc_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
libc_install_path_implib		:= $(PATH_INSTALL)/liblibcdll.a
libc_shared_lflags			+= -Wl,--out-implib=$(libc_install_path_implib)
endif
libc_sources					:= $(wildcard $(libc_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
libc_sources					+= $(wildcard $(libc_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
libc_sources					+= $(wildcard $(libc_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
libc_sources					+= $(wildcard $(libc_path_curdir)platform_specific/mac/*.c)
endif
libc_static_objects			:= $(patsubst %.c, %_static.o, $(libc_sources))
libc_shared_objects			:= $(patsubst %.c, %_shared.o, $(libc_sources))
libc_depends					:= $(patsubst %.c, %.d, $(libc_sources))
libc_depends_modules			:= common 
libc_depends_libs_shared		:= $(foreach module,$(libc_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# libc_depends_libs_targets		:= $(foreach module,$(libc_depends_modules),$(module)_all)
libc_clean_files				:=
libc_clean_files				+= $(libc_install_path_implib)
libc_clean_files				+= $(libc_install_path_shared)
libc_clean_files				+= $(libc_static_objects)
libc_clean_files				+= $(libc_shared_objects) 
libc_clean_files				+= $(libc_depends)

include $(libc_child_makefiles)

$(libc_path_curdir)%_static.o: $(libc_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(libc_path_curdir)%_shared.o: $(libc_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(libc_install_path_shared): $(libc_depends_libs_shared) $(libc_static_objects) $(libc_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(libc_shared_lflags) $(libc_shared_objects) $(libc_depends_libs_shared)

.PHONY: libc_all
libc_all: $(libc_child_all_targets) ## build and install all libc static and shared libraries
ifneq ($(libc_shared_objects),)
libc_all: $(libc_install_path_shared)
endif

.PHONY: libc_clean
libc_clean: $(libc_child_clean_targets) ## remove and deinstall all libc static and shared libraries
libc_clean:
	- $(RM) $(libc_clean_files)

.PHONY: libc_re
libc_re: libc_clean
libc_re: libc_all

.PHONY: libc_strip
libc_strip: $(libc_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
libc_strip:
	- strip --strip-all $(libc_install_path_shared)

-include $(libc_depends)
