$(PATH_INSTALL)/test_framework$(EXT_EXE): $(test_framework_test_objects) $(test_framework_test_libdepend_objs) ## build and install test_framework executable to test other modules
	$(CC) -o $@ $(test_framework_test_objects) $(test_framework_test_libdepend_objs) $(LFLAGS_COMMON)
