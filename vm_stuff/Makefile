BIN = a.out
SRC = \
	app.c \
	buffer.c \
	compiler.c \
	debug.c \
	hash_map.c \
	hash_set.c \
	ins.c \
	shared_lib.c \
	state.c \
	types.c \
	scanner.c \
	libc.c
HDR = $(SRC:.c=.h)
OBJ = $(SRC:.c=.o)
DPS = $(SRC:.c=.d)
CFLAGS = -g -Wall -Werror -Wextra -Wno-unused-function
LFLAGS = -lffi -lm

.PHONY: all
all: $(BIN)

%.o: %.c
	gcc -c $< -o $@ -MMD -MP -MF $(<:.c=.d) $(CFLAGS)

$(BIN): $(OBJ)
	gcc -o $(BIN) $^ $(LFLAGS)

-include $(DPS)

.PHONY: run
run: $(BIN)
	export LD_LIBRARY_PATH=/home/gilqamesh/Projects/gilqore/vm_stuff/lib && ./$(BIN)

.PHONY: clean
clean:
	- rm -f $(OBJ) $(BIN) $(DPS)

.PHONY: re
re: clean
re: all
