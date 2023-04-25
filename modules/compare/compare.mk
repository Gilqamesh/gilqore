COMPARE_PATH_CURDIR := $(dir $(lastword $(MAKEFILE_LIST)))
COMPARE_NAME_CURDIR := $(notdir $(patsubst %/,%,$(COMPARE_PATH_CURDIR)))
COMPARE_PATH_LIB    := $(PATH_INSTALL)/$(COMPARE_NAME_CURDIR)$(EXT)

COMPARE_SOURCES := $(wildcard $(COMPARE_PATH_CURDIR)*.c)
COMPARE_OBJECTS := $(patsubst %.c, %.o, $(COMPARE_SOURCES))
COMPARE_DEPENDS := $(patsubst %.c, %.d, $(COMPARE_SOURCES))

COMPARE_DEPENDS_MODULES = basic_types
COMPARE_DEPENDS_LIBS := $(foreach module,$(COMPARE_DEPENDS_MODULES),$(PATH_INSTALL)/$(module)$(EXT))
COMPARE_DEPENDS_LIBS_RULES = $(foreach module,$(COMPARE_DEPENDS_MODULES),$(module)_all)

$(COMPARE_PATH_CURDIR)%.o: $(COMPARE_PATH_CURDIR)%.c
	$(CC) -c $< -o $@ $(CFLAGS)

$(COMPARE_PATH_LIB): | $(COMPARE_DEPENDS_LIBS_RULES)
$(COMPARE_PATH_LIB): $(COMPARE_OBJECTS)
	$(CC) -o $@ $^ $(LDFLAGS) $(COMPARE_DEPENDS_LIBS)

.PHONY: compare_all
compare_all: $(COMPARE_PATH_LIB) ## build and install compare library

.PHONY: compare_clean
compare_clean: ## remove and deinstall compare library
	- $(RM) $(COMPARE_PATH_LIB) $(COMPARE_OBJECTS) $(COMPARE_DEPENDS)

-include $(COMPARE_DEPENDS)
