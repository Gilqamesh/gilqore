v3_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
v3_name_curdir          := $(notdir $(patsubst %/,%,$(v3_path_curdir)))
v3_child_makefiles      := $(wildcard $(v3_path_curdir)*/*mk)
v3_names                := $(basename $(notdir $(v3_child_makefiles)))
v3_all_targets          := $(foreach v3,$(v3_names),$(v3)_all)
v3_strip_targets        := $(foreach v3,$(v3_names),$(v3)_strip)
v3_clean_targets        := $(foreach v3,$(v3_names),$(v3)_clean)
v3_install_path         := $(PATH_INSTALL)/$(v3_name_curdir)
v3_install_path_static  := $(v3_install_path)$(EXT_LIB_STATIC)
v3_install_path_shared  := $(v3_install_path)$(EXT_LIB_SHARED)
v3_sources              := $(wildcard $(v3_path_curdir)*.c)
v3_static_objects       := $(patsubst %.c, %_static.o, $(v3_sources))
v3_shared_objects       := $(patsubst %.c, %_shared.o, $(v3_sources))
v3_depends              := $(patsubst %.c, %.d, $(v3_sources))
v3_depends_modules      := 
v3_depends_libs         := $(foreach module,$(v3_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
v3_depends_libs_rules   := $(foreach module,$(v3_depends_modules),$(module)_all)

include $(v3_child_makefiles)

$(v3_path_curdir)%_static.o: $(v3_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $@.d -DGIL_LIB_STATIC

$(v3_path_curdir)%_shared.o: $(v3_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $@.d -fPIC -DGIL_LIB_SHARED_EXPORT

ifneq ($(v3_static_objects),)
$(v3_install_path_static): | $(v3_depends_libs_rules)
$(v3_install_path_static): $(v3_static_objects)
	ar -rcs $@ $^ $(v3_depends_libs)
endif

ifneq ($(v3_shared_objects),)
$(v3_install_path_shared): | $(v3_depends_libs_rules)
$(v3_install_path_shared): $(v3_shared_objects)
	$(CC) -o $@ $^ $(LFLAGS) -shared $(v3_depends_libs)
endif


.PHONY: v3_all
v3_all: $(v3_all_targets) ## build and install all v3 static and shared libraries
v3_all: $(v3_install_path_shared)
v3_all: $(v3_install_path_static)

.PHONY: v3_clean
v3_clean: $(v3_clean_targets) ## remove and deinstall all v3 static and shared libraries
v3_clean:
	- $(RM) $(v3_install_path_static) $(v3_install_path_shared) $(v3_static_objects) $(v3_shared_objects) $(v3_depends)

.PHONY: v3_strip
v3_strip: $(v3_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
v3_strip:
	strip --strip-all $(v3_install_path_shared)

-include $(v3_depends)
