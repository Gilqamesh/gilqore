VECTOR_TYPE_PATH_CURDIR := $(dir $(lastword $(MAKEFILE_LIST)))
VECTOR_TYPE_MAKEFILES := $(wildcard $(VECTOR_TYPE_PATH_CURDIR)*/*mk)
VECTOR_TYPE_NAMES := $(basename $(notdir $(VECTOR_TYPE_MAKEFILES)))
VECTOR_TYPE_ALL_TARGETS := $(foreach VECTOR_TYPE,$(VECTOR_TYPE_NAMES),$(VECTOR_TYPE)_all)
VECTOR_TYPE_CLEAN_TARGETS := $(foreach VECTOR_TYPE,$(VECTOR_TYPE_NAMES),$(VECTOR_TYPE)_clean)

include $(VECTOR_TYPE_MAKEFILES)

.PHONY: vector_type_all
vector_type_all: $(VECTOR_TYPE_ALL_TARGETS) ## build and install all vector_type library

.PHONY: vector_type_clean
vector_type_clean: $(VECTOR_TYPE_CLEAN_TARGETS) ## remove and deinstall all vector_type library
