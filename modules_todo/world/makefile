DLL_NAME = $(notdir $(CURDIR)).dll

SOURCES = $(wildcard *.c)

OBJECTS = $(patsubst %.c, %.o, $(SOURCES))
DEPENDS = $(patsubst %.c, %.d, $(SOURCES))

CFLAGS = -g -Wall -Wextra -Werror -fPIC
LDFLAGS = -shared

%.o: %.c
	$(CC) $(CFLAGS) -MMD -MP -c $< -o $@

$(DLL_NAME): $(OBJECTS)
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@

.phony: all
all: $(DLL_NAME)

.phony: clean
clean:
	- $(RM) $(DLL_NAME) $(OBJECTS) $(DEPENDS)

-include $(DEPENDS)
