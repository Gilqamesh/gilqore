directory_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
directory_child_makefiles			:= $(wildcard $(directory_path_curdir)*/*mk)
directory_child_module_names		:= $(basename $(notdir $(directory_child_makefiles)))
directory_child_all_targets		:= $(foreach child_module,$(directory_child_module_names),$(child_module)_all)
directory_child_strip_targets		:= $(foreach child_module,$(directory_child_module_names),$(child_module)_strip)
directory_child_clean_targets		:= $(foreach child_module,$(directory_child_module_names),$(child_module)_clean)
directory_install_path_shared		:= $(PATH_INSTALL)/directory$(EXT_LIB_SHARED)
directory_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
directory_install_path_implib		:= $(PATH_INSTALL)/libdirectorydll.a
directory_shared_lflags			+= -Wl,--out-implib=$(directory_install_path_implib)
endif
directory_sources					:= $(wildcard $(directory_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
directory_sources					+= $(wildcard $(directory_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
directory_sources					+= $(wildcard $(directory_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
directory_sources					+= $(wildcard $(directory_path_curdir)platform_specific/mac/*.c)
endif
directory_static_objects			:= $(patsubst %.c, %_static.o, $(directory_sources))
directory_shared_objects			:= $(patsubst %.c, %_shared.o, $(directory_sources))
directory_depends					:= $(patsubst %.c, %.d, $(directory_sources))
directory_depends_modules			:= compare libc common file 
directory_depends_libs_shared		:= $(foreach module,$(directory_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
directory_depends_libs_targets		:= $(foreach module,$(directory_depends_modules),$(module)_all)
directory_clean_files				:=
directory_clean_files				+= $(directory_install_path_implib)
directory_clean_files				+= $(directory_install_path_shared)
directory_clean_files				+= $(directory_static_objects)
directory_clean_files				+= $(directory_shared_objects) 
directory_clean_files				+= $(directory_depends)

include $(directory_child_makefiles)

$(directory_path_curdir)%_static.o: $(directory_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(directory_path_curdir)%_shared.o: $(directory_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(directory_install_path_shared): $(directory_depends_libs_shared)
$(directory_install_path_shared): $(directory_static_objects)
$(directory_install_path_shared): $(directory_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(directory_shared_lflags) $(directory_shared_objects) $(directory_depends_libs_shared)

.PHONY: directory_all
directory_all: $(directory_child_all_targets) ## build and install all directory static and shared libraries
ifneq ($(directory_shared_objects),)
directory_all: $(directory_install_path_shared)
endif

.PHONY: directory_clean
directory_clean: $(directory_child_clean_targets) ## remove and deinstall all directory static and shared libraries
directory_clean:
	- $(RM) $(directory_clean_files)

.PHONY: directory_re
directory_re: directory_clean
directory_re: directory_all

.PHONY: directory_strip
directory_strip: $(directory_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
directory_strip:
	- strip --strip-all $(directory_install_path_shared)

-include $(directory_depends)
