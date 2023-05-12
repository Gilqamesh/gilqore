thread_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
thread_child_makefiles			:= $(wildcard $(thread_path_curdir)*/*mk)
thread_child_module_names		:= $(basename $(notdir $(thread_child_makefiles)))
thread_child_all_targets		:= $(foreach child_module,$(thread_child_module_names),$(child_module)_all)
thread_child_strip_targets		:= $(foreach child_module,$(thread_child_module_names),$(child_module)_strip)
thread_child_clean_targets		:= $(foreach child_module,$(thread_child_module_names),$(child_module)_clean)
thread_install_path_shared		:= $(PATH_INSTALL)/thread$(EXT_LIB_SHARED)
thread_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
thread_install_path_implib		:= $(PATH_INSTALL)/libthreaddll.a
thread_shared_lflags			+= -Wl,--out-implib=$(thread_install_path_implib)
endif
thread_sources					:= $(wildcard $(thread_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
thread_sources					+= $(wildcard $(thread_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
thread_sources					+= $(wildcard $(thread_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
thread_sources					+= $(wildcard $(thread_path_curdir)platform_specific/mac/*.c)
endif
thread_static_objects			:= $(patsubst %.c, %_static.o, $(thread_sources))
thread_shared_objects			:= $(patsubst %.c, %_shared.o, $(thread_sources))
thread_depends					:= $(patsubst %.c, %.d, $(thread_sources))
thread_depends_modules			:= 
thread_depends_libs_shared		:= $(foreach module,$(thread_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# thread_depends_libs_targets		:= $(foreach module,$(thread_depends_modules),$(module)_all)
thread_clean_files				:=
thread_clean_files				+= $(thread_install_path_implib)
thread_clean_files				+= $(thread_install_path_shared)
thread_clean_files				+= $(thread_static_objects)
thread_clean_files				+= $(thread_shared_objects) 
thread_clean_files				+= $(thread_depends)

include $(thread_child_makefiles)

$(thread_path_curdir)%_static.o: $(thread_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(thread_path_curdir)%_shared.o: $(thread_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(thread_install_path_shared): $(thread_depends_libs_shared) $(thread_static_objects) $(thread_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON)  $(thread_shared_lflags) $(thread_shared_objects) $(thread_depends_libs_shared)

.PHONY: thread_all
thread_all: $(thread_child_all_targets) ## build and install all thread static and shared libraries
ifneq ($(thread_shared_objects),)
thread_all: $(thread_install_path_shared)
endif

.PHONY: thread_clean
thread_clean: $(thread_child_clean_targets) ## remove and deinstall all thread static and shared libraries
thread_clean:
	- $(RM) $(thread_clean_files)

.PHONY: thread_re
thread_re: thread_clean
thread_re: thread_all

.PHONY: thread_strip
thread_strip: $(thread_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
thread_strip:
	- strip --strip-all $(thread_install_path_shared)

-include $(thread_depends)
