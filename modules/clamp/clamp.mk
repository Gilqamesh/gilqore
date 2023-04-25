CLAMP_PATH_CURDIR := $(dir $(lastword $(MAKEFILE_LIST)))
CLAMP_NAME_CURDIR := $(notdir $(patsubst %/,%,$(CLAMP_PATH_CURDIR)))
CLAMP_PATH_LIB    := $(PATH_INSTALL)/$(CLAMP_NAME_CURDIR)$(EXT)

CLAMP_SOURCES := $(wildcard $(CLAMP_PATH_CURDIR)*.c)
CLAMP_OBJECTS := $(patsubst %.c, %.o, $(CLAMP_SOURCES))
CLAMP_DEPENDS := $(patsubst %.c, %.d, $(CLAMP_SOURCES))

CLAMP_DEPENDS_MODULES = basic_types
CLAMP_DEPENDS_LIBS := $(foreach module,$(CLAMP_DEPENDS_MODULES),$(PATH_INSTALL)/$(module)$(EXT))
CLAMP_DEPENDS_LIBS_RULES = $(foreach module,$(CLAMP_DEPENDS_MODULES),$(module)_all)

$(CLAMP_PATH_CURDIR)%.o: $(CLAMP_PATH_CURDIR)%.c
	$(CC) -c $< -o $@ $(CFLAGS)

$(CLAMP_PATH_LIB): | $(CLAMP_DEPENDS_LIBS_RULES)
$(CLAMP_PATH_LIB): $(CLAMP_OBJECTS)
	$(CC) -o $@ $^ $(LDFLAGS) $(CLAMP_DEPENDS_LIBS)

.PHONY: clamp_all
clamp_all: $(CLAMP_PATH_LIB) ## build and install clamp library

.PHONY: clamp_clean
clamp_clean: ## remove and deinstall clamp library
	- $(RM) $(CLAMP_PATH_LIB) $(CLAMP_OBJECTS) $(CLAMP_DEPENDS)

-include $(CLAMP_DEPENDS)
