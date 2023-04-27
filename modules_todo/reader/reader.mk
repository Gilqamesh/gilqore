# reader_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
# reader_name_curdir          := $(notdir $(patsubst %/,%,$(reader_path_curdir)))
# reader_child_makefiles      := $(wildcard $(reader_path_curdir)*/*mk)
# reader_names                := $(basename $(notdir $(reader_child_makefiles)))
# reader_all_targets          := $(foreach reader,$(reader_names),$(reader)_all)
# reader_strip_targets        := $(foreach reader,$(reader_names),$(reader)_strip)
# reader_clean_targets        := $(foreach reader,$(reader_names),$(reader)_clean)
# reader_path_lib             := $(PATH_INSTALL)/$(reader_name_curdir)$(EXT)
# reader_sources              := $(wildcard $(reader_path_curdir)*.c)
# reader_objects              := $(patsubst %.c, %.o, $(reader_sources))
# reader_depends              := $(patsubst %.c, %.d, $(reader_sources))
# reader_depends_modules      := 
# reader_depends_libs         := $(foreach module,$(reader_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
# reader_depends_libs_rules   := $(foreach module,$(reader_depends_modules),$(module)_all)

# include $(reader_child_makefiles)

# $(reader_path_curdir)%.o: $(reader_path_curdir)%.c
# 	$(CC) -c $< -o $@ $(CFLAGS)

# $(reader_path_lib): | $(reader_depends_libs_rules)
# $(reader_path_lib): $(reader_objects)
# 	$(CC) -o $@ $^ $(LDFLAGS) $(reader_depends_libs)

# .PHONY: reader_parent_all
# reader_parent_all: $(reader_all_targets) ## build and install all reader library

# .PHONY: reader_parent_clean
# reader_parent_clean: $(reader_clean_targets) ## remove and deinstall all reader library

# .PHONY: reader_parent_strip
# reader_parent_strip: $(reader_strip_targets) ## used during shared library build, removes all symbols that are not needed for relocation processing

# .PHONY: reader_all
# reader_all: $(reader_path_lib) ## build and install reader library

# .PHONY: reader_clean
# reader_clean: ## remove and deinstall reader library
# 	- $(RM) $(reader_path_lib) $(reader_objects) $(reader_depends)

# .PHONY: reader_strip
# reader_strip:
# 	strip --strip-all $(reader_path_lib)

# -include $(reader_depends)
