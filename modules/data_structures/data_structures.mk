data_structures_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
data_structures_name_curdir          := $(notdir $(patsubst %/,%,$(data_structures_path_curdir)))
data_structures_child_makefiles      := $(wildcard $(data_structures_path_curdir)*/*mk)
data_structures_names                := $(basename $(notdir $(data_structures_child_makefiles)))
data_structures_all_targets          := $(foreach data_structures,$(data_structures_names),$(data_structures)_all)
data_structures_strip_targets        := $(foreach data_structures,$(data_structures_names),$(data_structures)_strip)
data_structures_clean_targets        := $(foreach data_structures,$(data_structures_names),$(data_structures)_clean)
data_structures_install_path         := $(PATH_INSTALL)/$(data_structures_name_curdir)
data_structures_install_path_static  := $(data_structures_install_path)$(EXT_LIB_STATIC)
data_structures_install_path_shared  := $(data_structures_install_path)$(EXT_LIB_SHARED)
data_structures_sources              := $(wildcard $(data_structures_path_curdir)*.c)
data_structures_static_objects       := $(patsubst %.c, %_static.o, $(data_structures_sources))
data_structures_shared_objects       := $(patsubst %.c, %_shared.o, $(data_structures_sources))
data_structures_depends              := $(patsubst %.c, %.d, $(data_structures_sources))
data_structures_depends_modules      := 
data_structures_depends_libs_static  := $(foreach module,$(data_structures_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
data_structures_depends_libs_shared  := $(foreach module,$(data_structures_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
data_structures_depends_libs_rules   := $(foreach module,$(data_structures_depends_modules),$(module)_all)

include $(data_structures_child_makefiles)

$(data_structures_path_curdir)%_static.o: $(data_structures_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(data_structures_path_curdir)%_shared.o: $(data_structures_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(data_structures_install_path_static): | $(data_structures_depends_libs_rules)
$(data_structures_install_path_static): $(data_structures_static_objects)
	ar -rcs $@ $^ $(data_structures_depends_libs_static)

$(data_structures_install_path_shared): | $(data_structures_depends_libs_rules)
$(data_structures_install_path_shared): $(data_structures_shared_objects)
	$(CC) -o $@ $^ $(LFLAGS) -shared $(data_structures_depends_libs_shared)

.PHONY: data_structures_all
data_structures_all: $(data_structures_all_targets) ## build and install all data_structures static and shared libraries
ifneq ($(data_structures_shared_objects),)
data_structures_all: $(data_structures_install_path_shared)
endif
ifneq ($(data_structures_static_objects),)
data_structures_all: $(data_structures_install_path_static)
endif

.PHONY: data_structures_clean
data_structures_clean: $(data_structures_clean_targets) ## remove and deinstall all data_structures static and shared libraries
data_structures_clean:
	- $(RM) $(data_structures_install_path_static) $(data_structures_install_path_shared) $(data_structures_static_objects) $(data_structures_shared_objects) $(data_structures_depends)

.PHONY: data_structures_strip
data_structures_strip: $(data_structures_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
data_structures_strip:
	strip --strip-all $(data_structures_install_path_shared)

-include $(data_structures_depends)
