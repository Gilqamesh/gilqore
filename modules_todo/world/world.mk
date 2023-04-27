# world_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
# world_name_curdir          := $(notdir $(patsubst %/,%,$(world_path_curdir)))
# world_child_makefiles      := $(wildcard $(world_path_curdir)*/*mk)
# world_names                := $(basename $(notdir $(world_child_makefiles)))
# world_all_targets          := $(foreach world,$(world_names),$(world)_all)
# world_strip_targets        := $(foreach world,$(world_names),$(world)_strip)
# world_clean_targets        := $(foreach world,$(world_names),$(world)_clean)
# world_path_lib             := $(PATH_INSTALL)/$(world_name_curdir)$(EXT)
# world_sources              := $(wildcard $(world_path_curdir)*.c)
# world_objects              := $(patsubst %.c, %.o, $(world_sources))
# world_depends              := $(patsubst %.c, %.d, $(world_sources))
# world_depends_modules      := 
# world_depends_libs         := $(foreach module,$(world_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
# world_depends_libs_rules   := $(foreach module,$(world_depends_modules),$(module)_all)

# include $(world_child_makefiles)

# $(world_path_curdir)%.o: $(world_path_curdir)%.c
# 	$(CC) -c $< -o $@ $(CFLAGS)

# $(world_path_lib): | $(world_depends_libs_rules)
# $(world_path_lib): $(world_objects)
# 	$(CC) -o $@ $^ $(LDFLAGS) $(world_depends_libs)

# .PHONY: world_parent_all
# world_parent_all: $(world_all_targets) ## build and install all world library

# .PHONY: world_parent_clean
# world_parent_clean: $(world_clean_targets) ## remove and deinstall all world library

# .PHONY: world_parent_strip
# world_parent_strip: $(world_strip_targets) ## used during shared library build, removes all symbols that are not needed for relocation processing

# .PHONY: world_all
# world_all: $(world_path_lib) ## build and install world library

# .PHONY: world_clean
# world_clean: ## remove and deinstall world library
# 	- $(RM) $(world_path_lib) $(world_objects) $(world_depends)

# .PHONY: world_strip
# world_strip:
# 	strip --strip-all $(world_path_lib)

# -include $(world_depends)
