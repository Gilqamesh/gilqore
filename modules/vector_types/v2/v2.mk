V2_PATH_CURDIR := $(dir $(lastword $(MAKEFILE_LIST)))
V2_NAME_CURDIR := $(notdir $(patsubst %/,%,$(V2_PATH_CURDIR)))
V2_PATH_LIB    := $(PATH_INSTALL)/$(V2_NAME_CURDIR)$(EXT)

V2_SOURCES := $(wildcard $(V2_PATH_CURDIR)*.c)
V2_OBJECTS := $(patsubst %.c, %.o, $(V2_SOURCES))
V2_DEPENDS := $(patsubst %.c, %.d, $(V2_SOURCES))

V2_DEPENDS_MODULES = basic_types
V2_DEPENDS_LIBS := $(foreach module,$(V2_DEPENDS_MODULES),$(PATH_INSTALL)/$(module)$(EXT))
V2_DEPENDS_LIBS_RULES = $(foreach module,$(V2_DEPENDS_MODULES),$(module)_all)

$(V2_PATH_CURDIR)%.o: $(V2_PATH_CURDIR)%.c
	$(CC) -c $< -o $@ $(CFLAGS)

$(V2_PATH_LIB): | $(V2_DEPENDS_LIBS_RULES)
$(V2_PATH_LIB): $(V2_OBJECTS)
	$(CC) -o $@ $^ $(LDFLAGS) $(V2_DEPENDS_LIBS)

.PHONY: v2_all
v2_all: $(V2_PATH_LIB) ## build and install v2 library

.PHONY: v2_clean
v2_clean: ## remove and deinstall v2 library
	- $(RM) $(V2_PATH_LIB) $(V2_OBJECTS) $(V2_DEPENDS)

-include $(V2_DEPENDS)
