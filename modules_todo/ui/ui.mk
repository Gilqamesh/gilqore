# ui_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
# ui_name_curdir          := $(notdir $(patsubst %/,%,$(ui_path_curdir)))
# ui_child_makefiles      := $(wildcard $(ui_path_curdir)*/*mk)
# ui_names                := $(basename $(notdir $(ui_child_makefiles)))
# ui_all_targets          := $(foreach ui,$(ui_names),$(ui)_all)
# ui_strip_targets        := $(foreach ui,$(ui_names),$(ui)_strip)
# ui_clean_targets        := $(foreach ui,$(ui_names),$(ui)_clean)
# ui_path_lib             := $(PATH_INSTALL)/$(ui_name_curdir)$(EXT)
# ui_sources              := $(wildcard $(ui_path_curdir)*.c)
# ui_objects              := $(patsubst %.c, %.o, $(ui_sources))
# ui_depends              := $(patsubst %.c, %.d, $(ui_sources))
# ui_depends_modules      := 
# ui_depends_libs         := $(foreach module,$(ui_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
# ui_depends_libs_rules   := $(foreach module,$(ui_depends_modules),$(module)_all)

# include $(ui_child_makefiles)

# $(ui_path_curdir)%.o: $(ui_path_curdir)%.c
# 	$(CC) -c $< -o $@ $(CFLAGS)

# $(ui_path_lib): | $(ui_depends_libs_rules)
# $(ui_path_lib): $(ui_objects)
# 	$(CC) -o $@ $^ $(LDFLAGS) $(ui_depends_libs)

# .PHONY: ui_parent_all
# ui_parent_all: $(ui_all_targets) ## build and install all ui library

# .PHONY: ui_parent_clean
# ui_parent_clean: $(ui_clean_targets) ## remove and deinstall all ui library

# .PHONY: ui_parent_strip
# ui_parent_strip: $(ui_strip_targets) ## used during shared library build, removes all symbols that are not needed for relocation processing

# .PHONY: ui_all
# ui_all: $(ui_path_lib) ## build and install ui library

# .PHONY: ui_clean
# ui_clean: ## remove and deinstall ui library
# 	- $(RM) $(ui_path_lib) $(ui_objects) $(ui_depends)

# .PHONY: ui_strip
# ui_strip:
# 	strip --strip-all $(ui_path_lib)

# -include $(ui_depends)
