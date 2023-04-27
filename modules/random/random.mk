random_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
random_name_curdir          := $(notdir $(patsubst %/,%,$(random_path_curdir)))
random_child_makefiles      := $(wildcard $(random_path_curdir)*/*mk)
random_names                := $(basename $(notdir $(random_child_makefiles)))
random_all_targets          := $(foreach random,$(random_names),$(random)_all)
random_strip_targets        := $(foreach random,$(random_names),$(random)_strip)
random_clean_targets        := $(foreach random,$(random_names),$(random)_clean)
random_install_path         := $(PATH_INSTALL)/$(random_name_curdir)
random_install_path_static  := $(random_install_path)$(EXT_LIB_STATIC)
random_install_path_shared  := $(random_install_path)$(EXT_LIB_SHARED)
random_sources              := $(wildcard $(random_path_curdir)*.c)
random_static_objects       := $(patsubst %.c, %_static.o, $(random_sources))
random_shared_objects       := $(patsubst %.c, %_shared.o, $(random_sources))
random_depends              := $(patsubst %.c, %.d, $(random_sources))
random_depends_modules      := 
random_depends_libs         := $(foreach module,$(random_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
random_depends_libs_rules   := $(foreach module,$(random_depends_modules),$(module)_all)

include $(random_child_makefiles)

$(random_path_curdir)%_static.o: $(random_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $@.d -DGIL_LIB_STATIC

$(random_path_curdir)%_shared.o: $(random_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $@.d -fPIC -DGIL_LIB_SHARED_EXPORT

ifneq ($(random_static_objects),)
$(random_install_path_static): | $(random_depends_libs_rules)
$(random_install_path_static): $(random_static_objects)
	ar -rcs $@ $^ $(random_depends_libs)
endif

ifneq ($(random_shared_objects),)
$(random_install_path_shared): | $(random_depends_libs_rules)
$(random_install_path_shared): $(random_shared_objects)
	$(CC) -o $@ $^ $(LFLAGS) -shared $(random_depends_libs)
endif


.PHONY: random_all
random_all: $(random_all_targets) ## build and install all random static and shared libraries
random_all: $(random_install_path_shared)
random_all: $(random_install_path_static)

.PHONY: random_clean
random_clean: $(random_clean_targets) ## remove and deinstall all random static and shared libraries
random_clean:
	- $(RM) $(random_install_path_static) $(random_install_path_shared) $(random_static_objects) $(random_shared_objects) $(random_depends)

.PHONY: random_strip
random_strip: $(random_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
random_strip:
	strip --strip-all $(random_install_path_shared)

-include $(random_depends)
