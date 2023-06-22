# Modular Make - top level makefile
PATH_INSTALL				:= lib
PATH_MODULES				:= modules
PATH_MK_FILES				:= mk
PATH_TCC_INCLUDE			:= tcc/include
PATH_TCC_INCLUDE_PLATFORM	:= tcc/include/winapi

# preliminary makefiles
include $(wildcard mk/*.mk)

# modules makefiles
include $(wildcard $(PATH_MODULES)/*.mk)

%.o: %.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON)
# %.o: %.c
# 	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d)
