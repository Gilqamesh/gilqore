LERP_PATH_CURDIR := $(dir $(lastword $(MAKEFILE_LIST)))
LERP_NAME_CURDIR := $(notdir $(patsubst %/,%,$(LERP_PATH_CURDIR)))
LERP_PATH_LIB    := $(PATH_INSTALL)/$(LERP_NAME_CURDIR)$(EXT)

LERP_SOURCES := $(wildcard $(LERP_PATH_CURDIR)*.c)
LERP_OBJECTS := $(patsubst %.c, %.o, $(LERP_SOURCES))
LERP_DEPENDS := $(patsubst %.c, %.d, $(LERP_SOURCES))

LERP_DEPENDS_MODULES = basic_types color
LERP_DEPENDS_LIBS := $(foreach module,$(LERP_DEPENDS_MODULES),$(PATH_INSTALL)/$(module)$(EXT))
LERP_DEPENDS_LIBS_RULES = $(foreach module,$(LERP_DEPENDS_MODULES),$(module)_all)

$(LERP_PATH_CURDIR)%.o: $(LERP_PATH_CURDIR)%.c
	$(CC) -c $< -o $@ $(CFLAGS)

$(LERP_PATH_LIB): | $(LERP_DEPENDS_LIBS_RULES)
$(LERP_PATH_LIB): $(LERP_OBJECTS)
	$(CC) -o $@ $^ $(LDFLAGS) $(LERP_DEPENDS_LIBS)

.PHONY: lerp_all
lerp_all: $(LERP_PATH_LIB) ## build and install lerp library

.PHONY: lerp_clean
lerp_clean: ## remove and deinstall lerp library
	- $(RM) $(LERP_PATH_LIB) $(LERP_OBJECTS) $(LERP_DEPENDS)

-include $(LERP_DEPENDS)
