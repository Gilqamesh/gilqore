basic_types_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
basic_types_child_makefiles			:= $(wildcard $(basic_types_path_curdir)*/*mk)
basic_types_child_module_names		:= $(basename $(notdir $(basic_types_child_makefiles)))
basic_types_child_all_targets		:= $(foreach child_module,$(basic_types_child_module_names),$(child_module)_all)
basic_types_child_strip_targets		:= $(foreach child_module,$(basic_types_child_module_names),$(child_module)_strip)
basic_types_child_clean_targets		:= $(foreach child_module,$(basic_types_child_module_names),$(child_module)_clean)
basic_types_install_path_shared		:= $(PATH_INSTALL)/basic_types$(EXT_LIB_SHARED)
basic_types_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
basic_types_install_path_implib		:= $(PATH_INSTALL)/libbasic_typesdll.a
basic_types_shared_lflags			+= -Wl,--out-implib=$(basic_types_install_path_implib)
endif
basic_types_sources					:= $(wildcard $(basic_types_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
basic_types_sources					+= $(wildcard $(basic_types_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
basic_types_sources					+= $(wildcard $(basic_types_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
basic_types_sources					+= $(wildcard $(basic_types_path_curdir)platform_specific/mac/*.c)
endif
basic_types_static_objects			:= $(patsubst %.c, %_static.o, $(basic_types_sources))
basic_types_shared_objects			:= $(patsubst %.c, %_shared.o, $(basic_types_sources))
basic_types_depends					:= $(patsubst %.c, %.d, $(basic_types_sources))
basic_types_depends_modules			:= 
basic_types_depends_libs_shared		:= $(foreach module,$(basic_types_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# basic_types_depends_libs_targets		:= $(foreach module,$(basic_types_depends_modules),$(module)_all)
basic_types_clean_files				:=
basic_types_clean_files				+= $(basic_types_install_path_implib)
basic_types_clean_files				+= $(basic_types_install_path_shared)
basic_types_clean_files				+= $(basic_types_static_objects)
basic_types_clean_files				+= $(basic_types_shared_objects) 
basic_types_clean_files				+= $(basic_types_depends)

include $(basic_types_child_makefiles)

$(basic_types_path_curdir)%_static.o: $(basic_types_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(basic_types_path_curdir)%_shared.o: $(basic_types_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(basic_types_install_path_shared): $(basic_types_depends_libs_shared) $(basic_types_static_objects) $(basic_types_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(basic_types_shared_lflags) $(basic_types_shared_objects) $(basic_types_depends_libs_shared)

.PHONY: basic_types_all
basic_types_all: $(basic_types_child_all_targets) ## build and install all basic_types static and shared libraries
ifneq ($(basic_types_shared_objects),)
basic_types_all: $(basic_types_install_path_shared)
endif

.PHONY: basic_types_clean
basic_types_clean: $(basic_types_child_clean_targets) ## remove and deinstall all basic_types static and shared libraries
basic_types_clean:
	- $(RM) $(basic_types_clean_files)

.PHONY: basic_types_re
basic_types_re: basic_types_clean
basic_types_re: basic_types_all

.PHONY: basic_types_strip
basic_types_strip: $(basic_types_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
basic_types_strip:
	- strip --strip-all $(basic_types_install_path_shared)

-include $(basic_types_depends)
