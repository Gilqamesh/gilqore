string_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
string_child_makefiles			:= $(wildcard $(string_path_curdir)*/*mk)
string_child_module_names		:= $(basename $(notdir $(string_child_makefiles)))
string_child_all_targets		:= $(foreach child_module,$(string_child_module_names),$(child_module)_all)
string_child_strip_targets		:= $(foreach child_module,$(string_child_module_names),$(child_module)_strip)
string_child_clean_targets		:= $(foreach child_module,$(string_child_module_names),$(child_module)_clean)
string_install_path_shared		:= $(PATH_INSTALL)/string$(EXT_LIB_SHARED)
string_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
string_install_path_implib		:= $(PATH_INSTALL)/libstringdll.a
string_shared_lflags			+= -Wl,--out-implib=$(string_install_path_implib)
endif
string_sources					:= $(wildcard $(string_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
string_sources					+= $(wildcard $(string_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
string_sources					+= $(wildcard $(string_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
string_sources					+= $(wildcard $(string_path_curdir)platform_specific/mac/*.c)
endif
string_static_objects			:= $(patsubst %.c, %_static.o, $(string_sources))
string_shared_objects			:= $(patsubst %.c, %_shared.o, $(string_sources))
string_depends					:= $(patsubst %.c, %.d, $(string_sources))
string_depends_modules			:= libc common 
string_depends_libs_shared		:= $(foreach module,$(string_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# string_depends_libs_targets		:= $(foreach module,$(string_depends_modules),$(module)_all)
string_clean_files				:=
string_clean_files				+= $(string_install_path_implib)
string_clean_files				+= $(string_install_path_shared)
string_clean_files				+= $(string_static_objects)
string_clean_files				+= $(string_shared_objects) 
string_clean_files				+= $(string_depends)

include $(string_child_makefiles)

$(string_path_curdir)%_static.o: $(string_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(string_path_curdir)%_shared.o: $(string_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(string_install_path_shared): $(string_depends_libs_shared) $(string_static_objects) $(string_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON)  $(string_shared_lflags) $(string_shared_objects) $(string_depends_libs_shared)

.PHONY: string_all
string_all: $(string_child_all_targets) ## build and install all string static and shared libraries
ifneq ($(string_shared_objects),)
string_all: $(string_install_path_shared)
endif

.PHONY: string_clean
string_clean: $(string_child_clean_targets) ## remove and deinstall all string static and shared libraries
string_clean:
	- $(RM) $(string_clean_files)

.PHONY: string_re
string_re: string_clean
string_re: string_all

.PHONY: string_strip
string_strip: $(string_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
string_strip:
	- strip --strip-all $(string_install_path_shared)

-include $(string_depends)
