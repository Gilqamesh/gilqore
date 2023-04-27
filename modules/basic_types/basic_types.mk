basic_types_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
basic_types_name_curdir          := $(notdir $(patsubst %/,%,$(basic_types_path_curdir)))
basic_types_child_makefiles      := $(wildcard $(basic_types_path_curdir)*/*mk)
basic_types_names                := $(basename $(notdir $(basic_types_child_makefiles)))
basic_types_all_targets          := $(foreach basic_types,$(basic_types_names),$(basic_types)_all)
basic_types_strip_targets        := $(foreach basic_types,$(basic_types_names),$(basic_types)_strip)
basic_types_clean_targets        := $(foreach basic_types,$(basic_types_names),$(basic_types)_clean)
basic_types_install_path         := $(PATH_INSTALL)/$(basic_types_name_curdir)
basic_types_install_path_static  := $(basic_types_install_path)$(EXT_LIB_STATIC)
basic_types_install_path_shared  := $(basic_types_install_path)$(EXT_LIB_SHARED)
basic_types_sources              := $(wildcard $(basic_types_path_curdir)*.c)
basic_types_static_objects       := $(patsubst %.c, %_static.o, $(basic_types_sources))
basic_types_shared_objects       := $(patsubst %.c, %_shared.o, $(basic_types_sources))
basic_types_depends              := $(patsubst %.c, %.d, $(basic_types_sources))
basic_types_depends_modules      := compare
basic_types_depends_libs_static  := $(foreach module,$(basic_types_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
basic_types_depends_libs_shared  := $(foreach module,$(basic_types_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
basic_types_depends_libs_rules   := $(foreach module,$(basic_types_depends_modules),$(module)_all)

include $(basic_types_child_makefiles)

$(basic_types_path_curdir)%_static.o: $(basic_types_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(basic_types_path_curdir)%_shared.o: $(basic_types_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(basic_types_install_path_static): | $(basic_types_depends_libs_rules)
$(basic_types_install_path_static): $(basic_types_static_objects)
	ar -rcs $@ $^ $(basic_types_depends_libs_static)

$(basic_types_install_path_shared): | $(basic_types_depends_libs_rules)
$(basic_types_install_path_shared): $(basic_types_shared_objects)
	$(CC) -o $@ $^ $(LFLAGS) -shared $(basic_types_depends_libs_shared)

.PHONY: basic_types_all
basic_types_all: $(basic_types_all_targets) ## build and install all basic_types static and shared libraries
ifneq ($(basic_types_shared_objects),)
basic_types_all: $(basic_types_install_path_shared)
endif
ifneq ($(basic_types_static_objects),)
basic_types_all: $(basic_types_install_path_static)
endif

.PHONY: basic_types_clean
basic_types_clean: $(basic_types_clean_targets) ## remove and deinstall all basic_types static and shared libraries
basic_types_clean:
	- $(RM) $(basic_types_install_path_static) $(basic_types_install_path_shared) $(basic_types_static_objects) $(basic_types_shared_objects) $(basic_types_depends)

.PHONY: basic_types_strip
basic_types_strip: $(basic_types_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
basic_types_strip:
	strip --strip-all $(basic_types_install_path_shared)

-include $(basic_types_depends)
