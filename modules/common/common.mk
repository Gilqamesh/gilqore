common_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
common_name_curdir          := $(notdir $(patsubst %/,%,$(common_path_curdir)))
common_child_makefiles      := $(wildcard $(common_path_curdir)*/*mk)
common_names                := $(basename $(notdir $(common_child_makefiles)))
common_all_targets          := $(foreach common,$(common_names),$(common)_all)
common_strip_targets        := $(foreach common,$(common_names),$(common)_strip)
common_clean_targets        := $(foreach common,$(common_names),$(common)_clean)
common_install_path         := $(PATH_INSTALL)/$(common_name_curdir)
common_install_path_static  := $(common_install_path)$(EXT_LIB_STATIC)
common_install_path_shared  := $(common_install_path)$(EXT_LIB_SHARED)
common_sources              := $(wildcard $(common_path_curdir)*.c)
common_static_objects       := $(patsubst %.c, %_static.o, $(common_sources))
common_shared_objects       := $(patsubst %.c, %_shared.o, $(common_sources))
common_depends              := $(patsubst %.c, %.d, $(common_sources))
common_depends_modules      := 
common_depends_libs         := $(foreach module,$(common_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
common_depends_libs_rules   := $(foreach module,$(common_depends_modules),$(module)_all)

include $(common_child_makefiles)

$(common_path_curdir)%_static.o: $(common_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $@.d -DGIL_LIB_STATIC

$(common_path_curdir)%_shared.o: $(common_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $@.d -fPIC -DGIL_LIB_SHARED_EXPORT

ifneq ($(common_static_objects),)
$(common_install_path_static): | $(common_depends_libs_rules)
$(common_install_path_static): $(common_static_objects)
	ar -rcs $@ $^ $(common_depends_libs)
endif

ifneq ($(common_shared_objects),)
$(common_install_path_shared): | $(common_depends_libs_rules)
$(common_install_path_shared): $(common_shared_objects)
	$(CC) -o $@ $^ $(LFLAGS) -shared $(common_depends_libs)
endif


.PHONY: common_all
common_all: $(common_all_targets) ## build and install all common static and shared libraries
common_all: $(common_install_path_shared)
common_all: $(common_install_path_static)

.PHONY: common_clean
common_clean: $(common_clean_targets) ## remove and deinstall all common static and shared libraries
common_clean:
	- $(RM) $(common_install_path_static) $(common_install_path_shared) $(common_static_objects) $(common_shared_objects) $(common_depends)

.PHONY: common_strip
common_strip: $(common_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
common_strip:
	strip --strip-all $(common_install_path_shared)

-include $(common_depends)
