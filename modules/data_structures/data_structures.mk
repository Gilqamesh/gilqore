data_structures_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
data_structures_child_makefiles			:= $(wildcard $(data_structures_path_curdir)*/*mk)
data_structures_child_module_names		:= $(basename $(notdir $(data_structures_child_makefiles)))
data_structures_child_all_targets		:= $(foreach child_module,$(data_structures_child_module_names),$(child_module)_all)
data_structures_child_strip_targets		:= $(foreach child_module,$(data_structures_child_module_names),$(child_module)_strip)
data_structures_child_clean_targets		:= $(foreach child_module,$(data_structures_child_module_names),$(child_module)_clean)
data_structures_install_path_shared		:= $(PATH_INSTALL)/data_structures$(EXT_LIB_SHARED)
data_structures_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
data_structures_install_path_implib		:= $(PATH_INSTALL)/libdata_structuresdll.a
data_structures_shared_lflags			+= -Wl,--out-implib=$(data_structures_install_path_implib)
endif
data_structures_sources					:= $(wildcard $(data_structures_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
data_structures_sources					+= $(wildcard $(data_structures_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
data_structures_sources					+= $(wildcard $(data_structures_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
data_structures_sources					+= $(wildcard $(data_structures_path_curdir)platform_specific/mac/*.c)
endif
data_structures_static_objects			:= $(patsubst %.c, %_static.o, $(data_structures_sources))
data_structures_shared_objects			:= $(patsubst %.c, %_shared.o, $(data_structures_sources))
data_structures_depends					:= $(patsubst %.c, %.d, $(data_structures_sources))
data_structures_depends_modules			:= 
data_structures_depends_libs_shared		:= $(foreach module,$(data_structures_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# data_structures_depends_libs_targets		:= $(foreach module,$(data_structures_depends_modules),$(module)_all)
data_structures_clean_files				:=
data_structures_clean_files				+= $(data_structures_install_path_implib)
data_structures_clean_files				+= $(data_structures_install_path_shared)
data_structures_clean_files				+= $(data_structures_static_objects)
data_structures_clean_files				+= $(data_structures_shared_objects) 
data_structures_clean_files				+= $(data_structures_depends)

include $(data_structures_child_makefiles)

$(data_structures_path_curdir)%_static.o: $(data_structures_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(data_structures_path_curdir)%_shared.o: $(data_structures_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(data_structures_install_path_shared): $(data_structures_depends_libs_shared) $(data_structures_static_objects) $(data_structures_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(data_structures_shared_lflags) $(data_structures_shared_objects) $(data_structures_depends_libs_shared)

.PHONY: data_structures_all
data_structures_all: $(data_structures_child_all_targets) ## build and install all data_structures static and shared libraries
ifneq ($(data_structures_shared_objects),)
data_structures_all: $(data_structures_install_path_shared)
endif

.PHONY: data_structures_clean
data_structures_clean: $(data_structures_child_clean_targets) ## remove and deinstall all data_structures static and shared libraries
data_structures_clean:
	- $(RM) $(data_structures_clean_files)

.PHONY: data_structures_re
data_structures_re: data_structures_clean
data_structures_re: data_structures_all

.PHONY: data_structures_strip
data_structures_strip: $(data_structures_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
data_structures_strip:
	- strip --strip-all $(data_structures_install_path_shared)

-include $(data_structures_depends)
