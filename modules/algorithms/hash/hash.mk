hash_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
hash_child_makefiles			:= $(wildcard $(hash_path_curdir)*/*mk)
hash_child_module_names		:= $(basename $(notdir $(hash_child_makefiles)))
hash_child_all_targets		:= $(foreach child_module,$(hash_child_module_names),$(child_module)_all)
hash_child_strip_targets		:= $(foreach child_module,$(hash_child_module_names),$(child_module)_strip)
hash_child_clean_targets		:= $(foreach child_module,$(hash_child_module_names),$(child_module)_clean)
hash_install_path_shared		:= $(PATH_INSTALL)/hash$(EXT_LIB_SHARED)
hash_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
hash_install_path_implib		:= $(PATH_INSTALL)/libhashdll.a
hash_shared_lflags			+= -Wl,--out-implib=$(hash_install_path_implib)
endif
hash_sources					:= $(wildcard $(hash_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
hash_sources					+= $(wildcard $(hash_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
hash_sources					+= $(wildcard $(hash_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
hash_sources					+= $(wildcard $(hash_path_curdir)platform_specific/mac/*.c)
endif
hash_static_objects			:= $(patsubst %.c, %_static.o, $(hash_sources))
hash_shared_objects			:= $(patsubst %.c, %_shared.o, $(hash_sources))
hash_depends					:= $(patsubst %.c, %.d, $(hash_sources))
hash_depends_modules			:= 
hash_depends_libs_shared		:= $(foreach module,$(hash_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# hash_depends_libs_targets		:= $(foreach module,$(hash_depends_modules),$(module)_all)
hash_clean_files				:=
hash_clean_files				+= $(hash_install_path_implib)
hash_clean_files				+= $(hash_install_path_shared)
hash_clean_files				+= $(hash_static_objects)
hash_clean_files				+= $(hash_shared_objects) 
hash_clean_files				+= $(hash_depends)

include $(hash_child_makefiles)

$(hash_path_curdir)%_static.o: $(hash_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(hash_path_curdir)%_shared.o: $(hash_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(hash_install_path_shared): $(hash_depends_libs_shared) $(hash_static_objects) $(hash_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON)  $(hash_shared_lflags) $(hash_shared_objects) $(hash_depends_libs_shared)

.PHONY: hash_all
hash_all: $(hash_child_all_targets) ## build and install all hash static and shared libraries
ifneq ($(hash_shared_objects),)
hash_all: $(hash_install_path_shared)
endif

.PHONY: hash_clean
hash_clean: $(hash_child_clean_targets) ## remove and deinstall all hash static and shared libraries
hash_clean:
	- $(RM) $(hash_clean_files)

.PHONY: hash_re
hash_re: hash_clean
hash_re: hash_all

.PHONY: hash_strip
hash_strip: $(hash_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
hash_strip:
	- strip --strip-all $(hash_install_path_shared)

-include $(hash_depends)
