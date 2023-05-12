string_replacer_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
string_replacer_child_makefiles			:= $(wildcard $(string_replacer_path_curdir)*/*mk)
string_replacer_child_module_names		:= $(basename $(notdir $(string_replacer_child_makefiles)))
string_replacer_child_all_targets		:= $(foreach child_module,$(string_replacer_child_module_names),$(child_module)_all)
string_replacer_child_strip_targets		:= $(foreach child_module,$(string_replacer_child_module_names),$(child_module)_strip)
string_replacer_child_clean_targets		:= $(foreach child_module,$(string_replacer_child_module_names),$(child_module)_clean)
string_replacer_install_path_shared		:= $(PATH_INSTALL)/string_replacer$(EXT_LIB_SHARED)
string_replacer_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
string_replacer_install_path_implib		:= $(PATH_INSTALL)/libstring_replacerdll.a
string_replacer_shared_lflags			+= -Wl,--out-implib=$(string_replacer_install_path_implib)
endif
string_replacer_sources					:= $(wildcard $(string_replacer_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
string_replacer_sources					+= $(wildcard $(string_replacer_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
string_replacer_sources					+= $(wildcard $(string_replacer_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
string_replacer_sources					+= $(wildcard $(string_replacer_path_curdir)platform_specific/mac/*.c)
endif
string_replacer_static_objects			:= $(patsubst %.c, %_static.o, $(string_replacer_sources))
string_replacer_shared_objects			:= $(patsubst %.c, %_shared.o, $(string_replacer_sources))
string_replacer_depends					:= $(patsubst %.c, %.d, $(string_replacer_sources))
string_replacer_depends_modules			:= libc common compare file time hash 
string_replacer_depends_libs_shared		:= $(foreach module,$(string_replacer_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# string_replacer_depends_libs_targets		:= $(foreach module,$(string_replacer_depends_modules),$(module)_all)
string_replacer_clean_files				:=
string_replacer_clean_files				+= $(string_replacer_install_path_implib)
string_replacer_clean_files				+= $(string_replacer_install_path_shared)
string_replacer_clean_files				+= $(string_replacer_static_objects)
string_replacer_clean_files				+= $(string_replacer_shared_objects) 
string_replacer_clean_files				+= $(string_replacer_depends)

include $(string_replacer_child_makefiles)

$(string_replacer_path_curdir)%_static.o: $(string_replacer_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(string_replacer_path_curdir)%_shared.o: $(string_replacer_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(string_replacer_install_path_shared): $(string_replacer_depends_libs_shared) $(string_replacer_static_objects) $(string_replacer_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(string_replacer_shared_lflags) $(string_replacer_shared_objects) $(string_replacer_depends_libs_shared)

.PHONY: string_replacer_all
string_replacer_all: $(string_replacer_child_all_targets) ## build and install all string_replacer static and shared libraries
ifneq ($(string_replacer_shared_objects),)
string_replacer_all: $(string_replacer_install_path_shared)
endif

.PHONY: string_replacer_clean
string_replacer_clean: $(string_replacer_child_clean_targets) ## remove and deinstall all string_replacer static and shared libraries
string_replacer_clean:
	- $(RM) $(string_replacer_clean_files)

.PHONY: string_replacer_re
string_replacer_re: string_replacer_clean
string_replacer_re: string_replacer_all

.PHONY: string_replacer_strip
string_replacer_strip: $(string_replacer_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
string_replacer_strip:
	- strip --strip-all $(string_replacer_install_path_shared)

-include $(string_replacer_depends)
