modules_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
modules_name_curdir          := $(notdir $(patsubst %/,%,$(modules_path_curdir)))
modules_child_makefiles      := $(wildcard $(modules_path_curdir)*/*mk)
modules_names                := $(basename $(notdir $(modules_child_makefiles)))
modules_all_targets          := $(foreach modules,$(modules_names),$(modules)_all)
modules_strip_targets        := $(foreach modules,$(modules_names),$(modules)_strip)
modules_clean_targets        := $(foreach modules,$(modules_names),$(modules)_clean)
modules_install_path         := $(PATH_INSTALL)/$(modules_name_curdir)
modules_install_path_static  := $(modules_install_path)$(EXT_LIB_STATIC)
modules_install_path_shared  := $(modules_install_path)$(EXT_LIB_SHARED)
modules_sources              := $(wildcard $(modules_path_curdir)*.c)
modules_static_objects       := $(patsubst %.c, %_static.o, $(modules_sources))
modules_shared_objects       := $(patsubst %.c, %_shared.o, $(modules_sources))
modules_depends              := $(patsubst %.c, %.d, $(modules_sources))
modules_depends_modules      := 
modules_depends_libs         := $(foreach module,$(modules_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
modules_depends_libs_rules   := $(foreach module,$(modules_depends_modules),$(module)_all)

include $(modules_child_makefiles)

$(modules_path_curdir)%_static.o: $(modules_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $@.d -DGIL_LIB_STATIC

$(modules_path_curdir)%_shared.o: $(modules_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $@.d -fPIC -DGIL_LIB_SHARED_EXPORT

ifneq ($(modules_static_objects),)
$(modules_install_path_static): | $(modules_depends_libs_rules)
$(modules_install_path_static): $(modules_static_objects)
	ar -rcs $@ $^ $(modules_depends_libs)
endif

ifneq ($(modules_shared_objects),)
$(modules_install_path_shared): | $(modules_depends_libs_rules)
$(modules_install_path_shared): $(modules_shared_objects)
	$(CC) -o $@ $^ $(LFLAGS) -shared $(modules_depends_libs)
endif


.PHONY: modules_all
modules_all: $(modules_all_targets) ## build and install all modules static and shared libraries
modules_all: $(modules_install_path_shared)
modules_all: $(modules_install_path_static)

.PHONY: modules_clean
modules_clean: $(modules_clean_targets) ## remove and deinstall all modules static and shared libraries
modules_clean:
	- $(RM) $(modules_install_path_static) $(modules_install_path_shared) $(modules_static_objects) $(modules_shared_objects) $(modules_depends)

.PHONY: modules_strip
modules_strip: $(modules_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
modules_strip:
	strip --strip-all $(modules_install_path_shared)

-include $(modules_depends)
