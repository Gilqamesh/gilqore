test_framework_depends_static_objs = $(test_framework_static_objects)
test_framework_depends_static_objs += $(foreach dep_module,$(foreach m,$(test_framework_depends_modules),$($(m)_depends_modules)),$($(dep_module)_static_objects))
test_framework_depends_static_objs += $(foreach dep_module,$(test_framework_depends_modules),$($(dep_module)_static_objects))

$(PATH_INSTALL)/test_framework$(EXT_EXE): $(test_framework_depends_static_objs) ## build and install test_framework executable to test other modules
	$(CC) -o $@ -Wl,--allow-multiple-definition $(test_framework_depends_static_objs) $(LFLAGS_COMMON)
