compare_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
compare_name_curdir          := $(notdir $(patsubst %/,%,$(compare_path_curdir)))
compare_child_makefiles      := $(wildcard $(compare_path_curdir)*/*mk)
compare_names                := $(basename $(notdir $(compare_child_makefiles)))
compare_all_targets          := $(foreach compare,$(compare_names),$(compare)_all)
compare_strip_targets        := $(foreach compare,$(compare_names),$(compare)_strip)
compare_clean_targets        := $(foreach compare,$(compare_names),$(compare)_clean)
compare_install_path         := $(PATH_INSTALL)/$(compare_name_curdir)
compare_install_path_static  := $(compare_install_path)$(EXT_LIB_STATIC)
compare_install_path_shared  := $(compare_install_path)$(EXT_LIB_SHARED)
compare_sources              := $(wildcard $(compare_path_curdir)*.c)
compare_static_objects       := $(patsubst %.c, %_static.o, $(compare_sources))
compare_shared_objects       := $(patsubst %.c, %_shared.o, $(compare_sources))
compare_depends              := $(patsubst %.c, %.d, $(compare_sources))
compare_depends_modules      := 
compare_depends_libs_static  := $(foreach module,$(compare_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
compare_depends_libs_shared  := $(foreach module,$(compare_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
compare_depends_libs_rules   := $(foreach module,$(compare_depends_modules),$(module)_all)

include $(compare_child_makefiles)

$(compare_path_curdir)%_static.o: $(compare_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(compare_path_curdir)%_shared.o: $(compare_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(compare_install_path_static): | $(compare_depends_libs_rules)
$(compare_install_path_static): $(compare_static_objects)
	ar -rcs $@ $^ $(compare_depends_libs_static)

$(compare_install_path_shared): | $(compare_depends_libs_rules)
$(compare_install_path_shared): $(compare_shared_objects)
	$(CC) -o $@ $^ $(LFLAGS) -shared $(compare_depends_libs_shared)

.PHONY: compare_all
compare_all: $(compare_all_targets) ## build and install all compare static and shared libraries
ifneq ($(compare_shared_objects),)
compare_all: $(compare_install_path_shared)
endif
ifneq ($(compare_static_objects),)
compare_all: $(compare_install_path_static)
endif

.PHONY: compare_clean
compare_clean: $(compare_clean_targets) ## remove and deinstall all compare static and shared libraries
compare_clean:
	- $(RM) $(compare_install_path_static) $(compare_install_path_shared) $(compare_static_objects) $(compare_shared_objects) $(compare_depends)

.PHONY: compare_strip
compare_strip: $(compare_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
compare_strip:
	strip --strip-all $(compare_install_path_shared)

-include $(compare_depends)
