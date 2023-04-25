COLOR_PATH_CURDIR := $(dir $(lastword $(MAKEFILE_LIST)))
COLOR_NAME_CURDIR := $(notdir $(patsubst %/,%,$(COLOR_PATH_CURDIR)))
COLOR_PATH_LIB    := $(PATH_INSTALL)/$(COLOR_NAME_CURDIR)$(EXT)

COLOR_SOURCES := $(wildcard $(COLOR_PATH_CURDIR)*.c)
COLOR_OBJECTS := $(patsubst %.c, %.o, $(COLOR_SOURCES))
COLOR_DEPENDS := $(patsubst %.c, %.d, $(COLOR_SOURCES))

COLOR_DEPENDS_MODULES = v4
COLOR_DEPENDS_LIBS := $(foreach module,$(COLOR_DEPENDS_MODULES),$(PATH_INSTALL)/$(module)$(EXT))
COLOR_DEPENDS_LIBS_RULES = $(foreach module,$(COLOR_DEPENDS_MODULES),$(module)_all)

$(COLOR_PATH_CURDIR)%.o: $(COLOR_PATH_CURDIR)%.c
	$(CC) -c $< -o $@ $(CFLAGS)

$(COLOR_PATH_LIB): | $(COLOR_DEPENDS_LIBS_RULES)
$(COLOR_PATH_LIB): $(COLOR_OBJECTS)
	$(CC) -o $@ $^ $(LDFLAGS) $(COLOR_DEPENDS_LIBS)

.PHONY: color_all
color_all: $(COLOR_PATH_LIB) ## build and install color library

.PHONY: color_clean
color_clean: ## remove and deinstall color library
	- $(RM) $(COLOR_PATH_LIB) $(COLOR_OBJECTS) $(COLOR_DEPENDS)

-include $(COLOR_DEPENDS)
