transpiler_path_curdir = $(dir $(lastword $(MAKEFILE_LIST)))
transpiler_src = $(wildcard $(transpiler_path_curdir)*.c)
transpiler_deps = $(patsubst %.c, %.d, $(transpiler_src))
transpiler_obj = $(patsubst %.c, %.o, $(transpiler_src))
transpiler_install_path = $(transpiler_path_curdir)transpiler.exe
transpiler_c_flags = -g -Wall -Wextra -Werror

$(transpiler_path_curdir)%.o: $(transpiler_path_curdir)%.c
	$(CC) -c $< -o $@ -MMD -MP -MF $(<:.c=.d) $(transpiler_c_flags)

$(transpiler_install_path): $(transpiler_obj)
	$(CC) -o $@ $^

.PHONY: transpiler_all
transpiler_all: $(transpiler_install_path)

.PHONY: transpiler_run
transpiler_run:
	$(transpiler_install_path) $(g_file_path) $(out_file_path)

.PHONY: transpiler_clean
transpiler_clean:
	-@rm $(transpiler_deps) $(transpiler_obj) $(transpiler_install_path)

.PHONY: transpiler_re
transpiler_re: transpiler_clean
transpiler_re: transpiler_all

-include $(transpiler_deps)
