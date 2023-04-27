console_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
console_name_curdir          := $(notdir $(patsubst %/,%,$(console_path_curdir)))
console_child_makefiles      := $(wildcard $(console_path_curdir)*/*mk)
console_names                := $(basename $(notdir $(console_child_makefiles)))
console_all_targets          := $(foreach console,$(console_names),$(console)_all)
console_strip_targets        := $(foreach console,$(console_names),$(console)_strip)
console_clean_targets        := $(foreach console,$(console_names),$(console)_clean)
console_install_path         := $(PATH_INSTALL)/$(console_name_curdir)
console_install_path_static  := $(console_install_path)$(EXT_LIB_STATIC)
console_install_path_shared  := $(console_install_path)$(EXT_LIB_SHARED)
console_sources              := $(wildcard $(console_path_curdir)*.c)
console_static_objects       := $(patsubst %.c, %_static.o, $(console_sources))
console_shared_objects       := $(patsubst %.c, %_shared.o, $(console_sources))
console_depends              := $(patsubst %.c, %.d, $(console_sources))
console_depends_modules      := libc common
console_depends_libs_static  := $(foreach module,$(console_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_STATIC))
console_depends_libs_shared  := $(foreach module,$(console_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
console_depends_libs_rules   := $(foreach module,$(console_depends_modules),$(module)_all)

include $(console_child_makefiles)

$(console_path_curdir)%_static.o: $(console_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(console_path_curdir)%_shared.o: $(console_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(console_install_path_static): | $(console_depends_libs_rules)
$(console_install_path_static): $(console_static_objects)
	ar -rcs $@ $^ $(console_depends_libs_static)

$(console_install_path_shared): | $(console_depends_libs_rules)
$(console_install_path_shared): $(console_shared_objects)
	$(CC) -o $@ $^ $(LFLAGS) -shared $(console_depends_libs_shared)

.PHONY: console_all
console_all: $(console_all_targets) ## build and install all console static and shared libraries
ifneq ($(console_shared_objects),)
console_all: $(console_install_path_shared)
endif
ifneq ($(console_static_objects),)
console_all: $(console_install_path_static)
endif

.PHONY: console_clean
console_clean: $(console_clean_targets) ## remove and deinstall all console static and shared libraries
console_clean:
	- $(RM) $(console_install_path_static) $(console_install_path_shared) $(console_static_objects) $(console_shared_objects) $(console_depends)

.PHONY: console_strip
console_strip: $(console_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
console_strip:
	strip --strip-all $(console_install_path_shared)

-include $(console_depends)
