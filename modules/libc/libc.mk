LIBC_PATH_CURDIR := $(dir $(lastword $(MAKEFILE_LIST)))
LIBC_NAME_CURDIR := $(notdir $(patsubst %/,%,$(LIBC_PATH_CURDIR)))
LIBC_PATH_LIB    := $(PATH_INSTALL)/$(LIBC_NAME_CURDIR)$(EXT)

LIBC_SOURCES := $(wildcard $(LIBC_PATH_CURDIR)*.c)
LIBC_OBJECTS := $(patsubst %.c, %.o, $(LIBC_SOURCES))
LIBC_DEPENDS := $(patsubst %.c, %.d, $(LIBC_SOURCES))

LIBC_DEPENDS_MODULES =
LIBC_DEPENDS_LIBS := $(foreach module,$(LIBC_DEPENDS_MODULES),$(PATH_INSTALL)/$(module)$(EXT))
LIBC_DEPENDS_LIBS_RULES = $(foreach module,$(LIBC_DEPENDS_MODULES),$(module)_all)

$(LIBC_PATH_CURDIR)%.o: $(LIBC_PATH_CURDIR)%.c
	$(CC) -c $< -o $@ $(CFLAGS)

$(LIBC_PATH_LIB): | $(LIBC_DEPENDS_LIBS_RULES)
$(LIBC_PATH_LIB): $(LIBC_OBJECTS)
	$(CC) -o $@ $^ $(LDFLAGS) $(LIBC_DEPENDS_LIBS)

.PHONY: libc_all
libc_all: $(LIBC_PATH_LIB) ## build and install libc library

.PHONY: libc_clean
libc_clean: ## remove and deinstall libc library
	- $(RM) $(LIBC_PATH_LIB) $(LIBC_OBJECTS) $(LIBC_DEPENDS)

-include $(LIBC_DEPENDS)
