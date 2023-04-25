V3_PATH_CURDIR := $(dir $(lastword $(MAKEFILE_LIST)))
V3_NAME_CURDIR := $(notdir $(patsubst %/,%,$(V3_PATH_CURDIR)))
V3_PATH_LIB    := $(PATH_INSTALL)/$(V3_NAME_CURDIR)$(EXT)

V3_SOURCES := $(wildcard $(V3_PATH_CURDIR)*.c)
V3_OBJECTS := $(patsubst %.c, %.o, $(V3_SOURCES))
V3_DEPENDS := $(patsubst %.c, %.d, $(V3_SOURCES))

V3_DEPENDS_MODULES = basic_types
V3_DEPENDS_LIBS := $(foreach module,$(V3_DEPENDS_MODULES),$(PATH_INSTALL)/$(module)$(EXT))
V3_DEPENDS_LIBS_RULES = $(foreach module,$(V3_DEPENDS_MODULES),$(module)_all)

$(V3_PATH_CURDIR)%.o: $(V3_PATH_CURDIR)%.c
	$(CC) -c $< -o $@ $(CFLAGS)

$(V3_PATH_LIB): | $(V3_DEPENDS_LIBS_RULES)
$(V3_PATH_LIB): $(V3_OBJECTS)
	$(CC) -o $@ $^ $(LDFLAGS) $(V3_DEPENDS_LIBS)

.PHONY: v3_all
v3_all: $(V3_PATH_LIB) ## build and install v3 library

.PHONY: v3_clean
v3_clean: ## remove and deinstall v3 library
	- $(RM) $(V3_PATH_LIB) $(V3_OBJECTS) $(V3_DEPENDS)

-include $(V3_DEPENDS)
