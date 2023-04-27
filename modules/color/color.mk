color_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
color_name_curdir          := $(notdir $(patsubst %/,%,$(color_path_curdir)))
color_child_makefiles      := $(wildcard $(color_path_curdir)*/*mk)
color_names                := $(basename $(notdir $(color_child_makefiles)))
color_all_targets          := $(foreach color,$(color_names),$(color)_all)
color_strip_targets        := $(foreach color,$(color_names),$(color)_strip)
color_clean_targets        := $(foreach color,$(color_names),$(color)_clean)
color_install_path         := $(PATH_INSTALL)/$(color_name_curdir)
color_install_path_static  := $(color_install_path)$(EXT_LIB_STATIC)
color_install_path_shared  := $(color_install_path)$(EXT_LIB_SHARED)
color_sources              := $(wildcard $(color_path_curdir)*.c)
color_static_objects       := $(patsubst %.c, %_static.o, $(color_sources))
color_shared_objects       := $(patsubst %.c, %_shared.o, $(color_sources))
color_depends              := $(patsubst %.c, %.d, $(color_sources))
color_depends_modules      := v4
color_depends_libs         := $(foreach module,$(color_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
color_depends_libs_rules   := $(foreach module,$(color_depends_modules),$(module)_all)

include $(color_child_makefiles)

$(color_path_curdir)%_static.o: $(color_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $@.d -DGIL_LIB_STATIC

$(color_path_curdir)%_shared.o: $(color_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $@.d -fPIC -DGIL_LIB_SHARED_EXPORT

ifneq ($(color_static_objects),)
$(color_install_path_static): | $(color_depends_libs_rules)
$(color_install_path_static): $(color_static_objects)
	ar -rcs $@ $^ $(color_depends_libs)
endif

ifneq ($(color_shared_objects),)
$(color_install_path_shared): | $(color_depends_libs_rules)
$(color_install_path_shared): $(color_shared_objects)
	$(CC) -o $@ $^ $(LFLAGS) -shared $(color_depends_libs)
endif


.PHONY: color_all
color_all: $(color_all_targets) ## build and install all color static and shared libraries
color_all: $(color_install_path_shared)
color_all: $(color_install_path_static)

.PHONY: color_clean
color_clean: $(color_clean_targets) ## remove and deinstall all color static and shared libraries
color_clean:
	- $(RM) $(color_install_path_static) $(color_install_path_shared) $(color_static_objects) $(color_shared_objects) $(color_depends)

.PHONY: color_strip
color_strip: $(color_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
color_strip:
	strip --strip-all $(color_install_path_shared)

-include $(color_depends)
