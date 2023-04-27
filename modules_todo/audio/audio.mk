# audio_path_curdir          := $(dir $(lastword $(MAKEFILE_LIST)))
# audio_name_curdir          := $(notdir $(patsubst %/,%,$(audio_path_curdir)))
# audio_child_makefiles      := $(wildcard $(audio_path_curdir)*/*mk)
# audio_names                := $(basename $(notdir $(audio_child_makefiles)))
# audio_all_targets          := $(foreach audio,$(audio_names),$(audio)_all)
# audio_strip_targets        := $(foreach audio,$(audio_names),$(audio)_strip)
# audio_clean_targets        := $(foreach audio,$(audio_names),$(audio)_clean)
# audio_path_lib             := $(PATH_INSTALL)/$(audio_name_curdir)$(EXT)
# audio_sources              := $(wildcard $(audio_path_curdir)*.c)
# audio_objects              := $(patsubst %.c, %.o, $(audio_sources))
# audio_depends              := $(patsubst %.c, %.d, $(audio_sources))
# audio_depends_modules      := 
# audio_depends_libs         := $(foreach module,$(audio_depends_modules),$(PATH_INSTALL)/$(module)$(EXT))
# audio_depends_libs_rules   := $(foreach module,$(audio_depends_modules),$(module)_all)

# include $(audio_child_makefiles)

# $(audio_path_curdir)%.o: $(audio_path_curdir)%.c
# 	$(CC) -c $< -o $@ $(CFLAGS)

# $(audio_path_lib): | $(audio_depends_libs_rules)
# $(audio_path_lib): $(audio_objects)
# 	$(CC) -o $@ $^ $(LDFLAGS) $(audio_depends_libs)

# .PHONY: audio_parent_all
# audio_parent_all: $(audio_all_targets) ## build and install all audio library

# .PHONY: audio_parent_clean
# audio_parent_clean: $(audio_clean_targets) ## remove and deinstall all audio library

# .PHONY: audio_parent_strip
# audio_parent_strip: $(audio_strip_targets) ## used during shared library build, removes all symbols that are not needed for relocation processing

# .PHONY: audio_all
# audio_all: $(audio_path_lib) ## build and install audio library

# .PHONY: audio_clean
# audio_clean: ## remove and deinstall audio library
# 	- $(RM) $(audio_path_lib) $(audio_objects) $(audio_depends)

# .PHONY: audio_strip
# audio_strip:
# 	strip --strip-all $(audio_path_lib)

# -include $(audio_depends)
