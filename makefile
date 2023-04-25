# Modular Make - top level makefile
PATH_PROJECT	:= $(PWD)
NAME_PROJECT	:= $(notdir $(PATH_PROJECT))
PATH_INSTALL	:= lib
PATH_MODULES	:= modules
PATH_TESTS		:= tests
PATH_MK_FILES	:= mk

# preliminary makefiles
include $(wildcard mk/*.mk)

EXT				:= $(EXT_LIB_SHARED)

ifeq ($(EXT), $(EXT_LIB_STATIC))
GIL_LIB_MODE	:=
else ifeq ($(EXT), $(EXT_LIB_SHARED))
GIL_LIB_MODE	:= GIL_LIB_SHARED_EXPORT
endif

# modules makefiles
include $(wildcard $(PATH_MODULES)/*.mk)

# tests makefiles
include $(wildcard $(PATH_TESTS)/*.mk)
