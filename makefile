# Modular Make - top level makefile
PATH_INSTALL	:= lib
PATH_MODULES	:= modules
PATH_TESTS		:= tests
PATH_MK_FILES	:= mk

# preliminary makefiles
include $(wildcard mk/*.mk)

# modules makefiles
include $(wildcard $(PATH_MODULES)/*.mk)

# # tests makefiles
# include $(wildcard $(PATH_TESTS)/*.mk)
