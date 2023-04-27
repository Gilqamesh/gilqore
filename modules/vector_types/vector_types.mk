vector_types_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
vector_types_name_curdir          := $(notdir $(patsubst %/,%,$(vector_types_path_curdir)))
vector_types_child_makefiles      := $(wildcard $(vector_types_path_curdir)*/*mk)
vector_types_names                := $(basename $(notdir $(vector_types_child_makefiles)))
vector_types_all_targets          := $(foreach vector_types,$(vector_types_names),$(vector_types)_all)
vector_types_strip_targets        := $(foreach vector_types,$(vector_types_names),$(vector_types)_strip)
vector_types_clean_targets        := $(foreach vector_types,$(vector_types_names),$(vector_types)_clean)
vector_types_install_path         := $(PATH_INSTALL)/$(vector_types_name_curdir)
vector_types_install_path_static  := $(vector_types_install_path)$(EXT_LIB_STATIC)
vector_types_install_path_shared  := $(vector_types_install_path)$(EXT_LIB_SHARED)
vector_types_sources              := $(wildcard $(vector_types_path_curdir)*.c)
vector_types_static_objects       := $(patsubst %.c, %_static.o, $(vector_types_sources))
vector_types_shared_objects       := $(patsubst %.c, %_shared.o, $(vector_types_sources))
vector_types_depends              := $(patsubst %.c, %.d, $(vector_types_sources))
vector_types_depends_modules      := 
vector_types_depends_libs         := $(foreach module,$(vector_types_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
vector_types_depends_libs_rules   := $(foreach module,$(vector_types_depends_modules),$(module)_all)

include $(vector_types_child_makefiles)

$(vector_types_path_curdir)%_static.o: $(vector_types_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $@.d -DGIL_LIB_STATIC

$(vector_types_path_curdir)%_shared.o: $(vector_types_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $@.d -fPIC -DGIL_LIB_SHARED_EXPORT

ifneq ($(vector_types_static_objects),)
$(vector_types_install_path_static): | $(vector_types_depends_libs_rules)
$(vector_types_install_path_static): $(vector_types_static_objects)
	ar -rcs $@ $^ $(vector_types_depends_libs)
endif

ifneq ($(vector_types_shared_objects),)
$(vector_types_install_path_shared): | $(vector_types_depends_libs_rules)
$(vector_types_install_path_shared): $(vector_types_shared_objects)
	$(CC) -o $@ $^ $(LFLAGS) -shared $(vector_types_depends_libs)
endif


.PHONY: vector_types_all
vector_types_all: $(vector_types_all_targets) ## build and install all vector_types static and shared libraries
vector_types_all: $(vector_types_install_path_shared)
vector_types_all: $(vector_types_install_path_static)

.PHONY: vector_types_clean
vector_types_clean: $(vector_types_clean_targets) ## remove and deinstall all vector_types static and shared libraries
vector_types_clean:
	- $(RM) $(vector_types_install_path_static) $(vector_types_install_path_shared) $(vector_types_static_objects) $(vector_types_shared_objects) $(vector_types_depends)

.PHONY: vector_types_strip
vector_types_strip: $(vector_types_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
vector_types_strip:
	strip --strip-all $(vector_types_install_path_shared)

-include $(vector_types_depends)
