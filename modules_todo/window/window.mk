# window_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
# window_name_curdir          := $(notdir $(patsubst %/,%,$(window_path_curdir)))
# window_child_makefiles      := $(wildcard $(window_path_curdir)*/*mk)
# window_names                := $(basename $(notdir $(window_child_makefiles)))
# window_all_targets          := $(foreach window,$(window_names),$(window)_all)
# window_strip_targets        := $(foreach window,$(window_names),$(window)_strip)
# window_clean_targets        := $(foreach window,$(window_names),$(window)_clean)
# window_path_lib             := $(PATH_INSTALL)/$(window_name_curdir)$(EXT)
# window_sources              := $(wildcard $(window_path_curdir)*.c)
# window_objects              := $(patsubst %.c, %.o, $(window_sources))
# window_depends              := $(patsubst %.c, %.d, $(window_sources))
# window_depends_modules      := 
# window_depends_libs         := $(foreach module,$(window_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
# window_depends_libs_rules   := $(foreach module,$(window_depends_modules),$(module)_all)

# include $(window_child_makefiles)

# $(window_path_curdir)%.o: $(window_path_curdir)%.c
# 	$(CC) -c $< -o $@ $(CFLAGS)

# $(window_path_lib): | $(window_depends_libs_rules)
# $(window_path_lib): $(window_objects)
# 	$(CC) -o $@ $^ $(LDFLAGS) $(window_depends_libs)

# .PHONY: window_parent_all
# window_parent_all: $(window_all_targets) ## build and install all window library

# .PHONY: window_parent_clean
# window_parent_clean: $(window_clean_targets) ## remove and deinstall all window library

# .PHONY: window_parent_strip
# window_parent_strip: $(window_strip_targets) ## used during shared library build, removes all symbols that are not needed for relocation processing

# .PHONY: window_all
# window_all: $(window_path_lib) ## build and install window library

# .PHONY: window_clean
# window_clean: ## remove and deinstall window library
# 	- $(RM) $(window_path_lib) $(window_objects) $(window_depends)

# .PHONY: window_strip
# window_strip:
# 	strip --strip-all $(window_path_lib)

# -include $(window_depends)
