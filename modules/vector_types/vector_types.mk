vector_types_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
vector_types_child_makefiles			:= $(wildcard $(vector_types_path_curdir)*/*mk)
vector_types_child_module_names		:= $(basename $(notdir $(vector_types_child_makefiles)))
vector_types_child_all_targets		:= $(foreach child_module,$(vector_types_child_module_names),$(child_module)_all)
vector_types_child_strip_targets		:= $(foreach child_module,$(vector_types_child_module_names),$(child_module)_strip)
vector_types_child_clean_targets		:= $(foreach child_module,$(vector_types_child_module_names),$(child_module)_clean)
vector_types_install_path_shared		:= $(PATH_INSTALL)/vector_types$(EXT_LIB_SHARED)
vector_types_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
vector_types_install_path_implib		:= $(PATH_INSTALL)/libvector_typesdll.a
vector_types_shared_lflags			+= -Wl,--out-implib=$(vector_types_install_path_implib)
endif
vector_types_sources					:= $(wildcard $(vector_types_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
vector_types_sources					+= $(wildcard $(vector_types_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
vector_types_sources					+= $(wildcard $(vector_types_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
vector_types_sources					+= $(wildcard $(vector_types_path_curdir)platform_specific/mac/*.c)
endif
vector_types_static_objects			:= $(patsubst %.c, %_static.o, $(vector_types_sources))
vector_types_shared_objects			:= $(patsubst %.c, %_shared.o, $(vector_types_sources))
vector_types_depends					:= $(patsubst %.c, %.d, $(vector_types_sources))
vector_types_depends_modules			:=  
vector_types_depends_libs_shared		:= $(foreach module,$(vector_types_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
vector_types_depends_libs_targets		:= $(foreach module,$(vector_types_depends_modules),$(module)_all)
vector_types_clean_files				:=
vector_types_clean_files				+= $(vector_types_install_path_implib)
vector_types_clean_files				+= $(vector_types_install_path_shared)
vector_types_clean_files				+= $(vector_types_static_objects)
vector_types_clean_files				+= $(vector_types_shared_objects) 
vector_types_clean_files				+= $(vector_types_depends)

include $(vector_types_child_makefiles)

$(vector_types_path_curdir)%_static.o: $(vector_types_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(vector_types_path_curdir)%_shared.o: $(vector_types_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(vector_types_install_path_shared): $(vector_types_depends_libs_shared)
$(vector_types_install_path_shared): $(vector_types_static_objects)
$(vector_types_install_path_shared): $(vector_types_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(vector_types_shared_lflags) $(vector_types_shared_objects) $(vector_types_depends_libs_shared)

.PHONY: vector_types_all
vector_types_all: $(vector_types_child_all_targets) ## build and install all vector_types static and shared libraries
ifneq ($(vector_types_shared_objects),)
vector_types_all: $(vector_types_install_path_shared)
endif

.PHONY: vector_types_clean
vector_types_clean: $(vector_types_child_clean_targets) ## remove and deinstall all vector_types static and shared libraries
vector_types_clean:
	- $(RM) $(vector_types_clean_files)

.PHONY: vector_types_re
vector_types_re: vector_types_clean
vector_types_re: vector_types_all

.PHONY: vector_types_strip
vector_types_strip: $(vector_types_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
vector_types_strip:
	- strip --strip-all $(vector_types_install_path_shared)

-include $(vector_types_depends)
