circular_buffer_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
circular_buffer_name_curdir          := $(notdir $(patsubst %/,%,$(circular_buffer_path_curdir)))
circular_buffer_child_makefiles      := $(wildcard $(circular_buffer_path_curdir)*/*mk)
circular_buffer_names                := $(basename $(notdir $(circular_buffer_child_makefiles)))
circular_buffer_all_targets          := $(foreach circular_buffer,$(circular_buffer_names),$(circular_buffer)_all)
circular_buffer_strip_targets        := $(foreach circular_buffer,$(circular_buffer_names),$(circular_buffer)_strip)
circular_buffer_clean_targets        := $(foreach circular_buffer,$(circular_buffer_names),$(circular_buffer)_clean)
circular_buffer_install_path         := $(PATH_INSTALL)/$(circular_buffer_name_curdir)
circular_buffer_install_path_static  := $(circular_buffer_install_path)$(EXT_LIB_STATIC)
circular_buffer_install_path_shared  := $(circular_buffer_install_path)$(EXT_LIB_SHARED)
circular_buffer_sources              := $(wildcard $(circular_buffer_path_curdir)*.c)
circular_buffer_static_objects       := $(patsubst %.c, %_static.o, $(circular_buffer_sources))
circular_buffer_shared_objects       := $(patsubst %.c, %_shared.o, $(circular_buffer_sources))
circular_buffer_depends              := $(patsubst %.c, %.d, $(circular_buffer_sources))
circular_buffer_depends_modules      := libc common compare
circular_buffer_depends_libs         := $(foreach module,$(circular_buffer_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
circular_buffer_depends_libs_rules   := $(foreach module,$(circular_buffer_depends_modules),$(module)_all)

include $(circular_buffer_child_makefiles)

$(circular_buffer_path_curdir)%_static.o: $(circular_buffer_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $@.d -DGIL_LIB_STATIC

$(circular_buffer_path_curdir)%_shared.o: $(circular_buffer_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $@.d -fPIC -DGIL_LIB_SHARED_EXPORT

ifneq ($(circular_buffer_static_objects),)
$(circular_buffer_install_path_static): | $(circular_buffer_depends_libs_rules)
$(circular_buffer_install_path_static): $(circular_buffer_static_objects)
	ar -rcs $@ $^ $(circular_buffer_depends_libs)
endif

ifneq ($(circular_buffer_shared_objects),)
$(circular_buffer_install_path_shared): | $(circular_buffer_depends_libs_rules)
$(circular_buffer_install_path_shared): $(circular_buffer_shared_objects)
	$(CC) -o $@ $^ $(LFLAGS) -shared $(circular_buffer_depends_libs)
endif


.PHONY: circular_buffer_all
circular_buffer_all: $(circular_buffer_all_targets) ## build and install all circular_buffer static and shared libraries
circular_buffer_all: $(circular_buffer_install_path_shared)
circular_buffer_all: $(circular_buffer_install_path_static)

.PHONY: circular_buffer_clean
circular_buffer_clean: $(circular_buffer_clean_targets) ## remove and deinstall all circular_buffer static and shared libraries
circular_buffer_clean:
	- $(RM) $(circular_buffer_install_path_static) $(circular_buffer_install_path_shared) $(circular_buffer_static_objects) $(circular_buffer_shared_objects) $(circular_buffer_depends)

.PHONY: circular_buffer_strip
circular_buffer_strip: $(circular_buffer_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
circular_buffer_strip:
	strip --strip-all $(circular_buffer_install_path_shared)

-include $(circular_buffer_depends)
