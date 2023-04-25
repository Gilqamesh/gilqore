V4_PATH_CURDIR := $(dir $(lastword $(MAKEFILE_LIST)))
V4_NAME_CURDIR := $(notdir $(patsubst %/,%,$(V4_PATH_CURDIR)))
V4_PATH_LIB    := $(PATH_INSTALL)/$(V4_NAME_CURDIR)$(EXT)

V4_SOURCES := $(wildcard $(V4_PATH_CURDIR)*.c)
V4_OBJECTS := $(patsubst %.c, %.o, $(V4_SOURCES))
V4_DEPENDS := $(patsubst %.c, %.d, $(V4_SOURCES))

V4_DEPENDS_MODULES = basic_types
V4_DEPENDS_LIBS := $(foreach module,$(V4_DEPENDS_MODULES),$(PATH_INSTALL)/$(module)$(EXT))
V4_DEPENDS_LIBS_RULES = $(foreach module,$(V4_DEPENDS_MODULES),$(module)_all)

$(V4_PATH_CURDIR)%.o: $(V4_PATH_CURDIR)%.c
	$(CC) -c $< -o $@ $(CFLAGS)

$(V4_PATH_LIB): | $(V4_DEPENDS_LIBS_RULES)
$(V4_PATH_LIB): $(V4_OBJECTS)
	$(CC) -o $@ $^ $(LDFLAGS) $(V4_DEPENDS_LIBS)

.PHONY: v4_all
v4_all: $(V4_PATH_LIB) ## build and install v4 library

.PHONY: v4_clean
v4_clean: ## remove and deinstall v4 library
	- $(RM) $(V4_PATH_LIB) $(V4_OBJECTS) $(V4_DEPENDS)

-include $(V4_DEPENDS)
