io_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
io_child_makefiles			:= $(wildcard $(io_path_curdir)*/*mk)
io_child_module_names		:= $(basename $(notdir $(io_child_makefiles)))
io_child_all_targets		:= $(foreach child_module,$(io_child_module_names),$(child_module)_all)
io_child_strip_targets		:= $(foreach child_module,$(io_child_module_names),$(child_module)_strip)
io_child_clean_targets		:= $(foreach child_module,$(io_child_module_names),$(child_module)_clean)
io_install_path_shared		:= $(PATH_INSTALL)/io$(EXT_LIB_SHARED)
io_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
io_install_path_implib		:= $(PATH_INSTALL)/libiodll.a
io_shared_lflags			+= -Wl,--out-implib=$(io_install_path_implib)
endif
io_sources					:= $(wildcard $(io_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
io_sources					+= $(wildcard $(io_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
io_sources					+= $(wildcard $(io_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
io_sources					+= $(wildcard $(io_path_curdir)platform_specific/mac/*.c)
endif
io_static_objects			:= $(patsubst %.c, %_static.o, $(io_sources))
io_shared_objects			:= $(patsubst %.c, %_shared.o, $(io_sources))
io_depends					:= $(patsubst %.c, %.d, $(io_sources))
io_depends_modules			:=  
io_depends_libs_shared		:= $(foreach module,$(io_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
io_depends_libs_targets		:= $(foreach module,$(io_depends_modules),$(module)_all)
io_clean_files				:=
io_clean_files				+= $(io_install_path_implib)
io_clean_files				+= $(io_install_path_shared)
io_clean_files				+= $(io_static_objects)
io_clean_files				+= $(io_shared_objects) 
io_clean_files				+= $(io_depends)

include $(io_child_makefiles)

$(io_path_curdir)%_static.o: $(io_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(io_path_curdir)%_shared.o: $(io_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(io_install_path_shared): $(io_depends_libs_shared)
$(io_install_path_shared): $(io_static_objects)
$(io_install_path_shared): $(io_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(io_shared_lflags) $(io_shared_objects) $(io_depends_libs_shared)

.PHONY: io_all
io_all: $(io_child_all_targets) ## build and install all io static and shared libraries
ifneq ($(io_shared_objects),)
io_all: $(io_install_path_shared)
endif

.PHONY: io_clean
io_clean: $(io_child_clean_targets) ## remove and deinstall all io static and shared libraries
io_clean:
	- $(RM) $(io_clean_files)

.PHONY: io_re
io_re: io_clean
io_re: io_all

.PHONY: io_strip
io_strip: $(io_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
io_strip:
	- strip --strip-all $(io_install_path_shared)

-include $(io_depends)
