MODULE_COMPILER_EXE=module_compiler.exe
SRC=$(wildcard *.c)
OBJ=$(patsubst %.c,%.o,$(SRC))
DPS=$(patsubst %.c,%.d,$(SRC))
LIBDPS=file libc system
LIBLNK=$(foreach libdps,$(LIBDPS),../lib/$(libdps))

%.o: %.c
	cc -c $< -o $@ -I../modules -MMD -MP -MF $(<:.c=.d)

$(MODULE_COMPILER_EXE): $(OBJ)
	cc -o $@ $(OBJ) $(LIBLNK)

.PHONY: module_compiler
module_compiler: $(MODULE_COMPILER_EXE)

-include $(DPS)
