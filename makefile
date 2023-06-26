# Modular Make - top level makefile
PATH_INSTALL				:= lib
PATH_MODULES				:= modules
PATH_MK_FILES				:= mk

# preliminary makefiles
include $(wildcard mk/*.mk)

# modules makefiles
include $(wildcard $(PATH_MODULES)/*.mk)

%.o: %.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
