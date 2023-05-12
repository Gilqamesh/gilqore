time_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
time_child_makefiles			:= $(wildcard $(time_path_curdir)*/*mk)
time_child_module_names		:= $(basename $(notdir $(time_child_makefiles)))
time_child_all_targets		:= $(foreach child_module,$(time_child_module_names),$(child_module)_all)
time_child_strip_targets		:= $(foreach child_module,$(time_child_module_names),$(child_module)_strip)
time_child_clean_targets		:= $(foreach child_module,$(time_child_module_names),$(child_module)_clean)
time_install_path_shared		:= $(PATH_INSTALL)/time$(EXT_LIB_SHARED)
time_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
time_install_path_implib		:= $(PATH_INSTALL)/libtimedll.a
time_shared_lflags			+= -Wl,--out-implib=$(time_install_path_implib)
endif
time_sources					:= $(wildcard $(time_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
time_sources					+= $(wildcard $(time_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
time_sources					+= $(wildcard $(time_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
time_sources					+= $(wildcard $(time_path_curdir)platform_specific/mac/*.c)
endif
time_static_objects			:= $(patsubst %.c, %_static.o, $(time_sources))
time_shared_objects			:= $(patsubst %.c, %_shared.o, $(time_sources))
time_depends					:= $(patsubst %.c, %.d, $(time_sources))
time_depends_modules			:= common 
time_depends_libs_shared		:= $(foreach module,$(time_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
# time_depends_libs_targets		:= $(foreach module,$(time_depends_modules),$(module)_all)
time_clean_files				:=
time_clean_files				+= $(time_install_path_implib)
time_clean_files				+= $(time_install_path_shared)
time_clean_files				+= $(time_static_objects)
time_clean_files				+= $(time_shared_objects) 
time_clean_files				+= $(time_depends)

include $(time_child_makefiles)

$(time_path_curdir)%_static.o: $(time_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(time_path_curdir)%_shared.o: $(time_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(time_install_path_shared): $(time_depends_libs_shared) $(time_static_objects) $(time_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON)  $(time_shared_lflags) $(time_shared_objects) $(time_depends_libs_shared)

.PHONY: time_all
time_all: $(time_child_all_targets) ## build and install all time static and shared libraries
ifneq ($(time_shared_objects),)
time_all: $(time_install_path_shared)
endif

.PHONY: time_clean
time_clean: $(time_child_clean_targets) ## remove and deinstall all time static and shared libraries
time_clean:
	- $(RM) $(time_clean_files)

.PHONY: time_re
time_re: time_clean
time_re: time_all

.PHONY: time_strip
time_strip: $(time_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
time_strip:
	- strip --strip-all $(time_install_path_shared)

-include $(time_depends)
