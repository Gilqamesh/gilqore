# top level makefile for modules
MODULES_PATH_CURDIR := $(dir $(lastword $(MAKEFILE_LIST)))
MODULES_MAKEFILES := $(wildcard $(MODULES_PATH_CURDIR)*/*mk)
MODULES_NAMES := $(basename $(notdir $(MODULES_MAKEFILES)))
MODULES_ALL_TARGETS := $(foreach MODULES,$(MODULES_NAMES),$(MODULES)_all)
MODULES_CLEAN_TARGETS := $(foreach MODULES,$(MODULES_NAMES),$(MODULES)_clean)

CFLAGS		:=
CFLAGS		+= -g -Wall -Wextra -Werror -MMD -MP -I$(MODULES_PATH_CURDIR)

LDFLAGS		:=

ifeq ($(GIL_LIB_MODE), GIL_LIB_SHARED_EXPORT)
CFLAGS      += -fPIC
LDFLAGS		+= -shared
else ifeq ($(GIL_LIB_MODE), GIL_LIB_SHARED_IMPORT)
endif

include $(MODULES_MAKEFILES)

.PHONY: modules_all
modules_all: $(MODULES_ALL_TARGETS) ## build and install all modules library

.PHONY: modules_clean
modules_clean: $(MODULES_CLEAN_TARGETS) ## remove and deinstall all modules library
