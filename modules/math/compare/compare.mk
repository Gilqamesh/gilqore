compare_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
compare_child_makefiles			:= $(wildcard $(compare_path_curdir)*/*mk)
compare_child_module_names		:= $(basename $(notdir $(compare_child_makefiles)))
compare_child_all_targets		:= $(foreach child_module,$(compare_child_module_names),$(child_module)_all)
compare_child_strip_targets		:= $(foreach child_module,$(compare_child_module_names),$(child_module)_strip)
compare_child_clean_targets		:= $(foreach child_module,$(compare_child_module_names),$(child_module)_clean)
compare_install_path_shared		:= $(PATH_INSTALL)/compare$(EXT_LIB_SHARED)
compare_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
compare_install_path_implib		:= $(PATH_INSTALL)/libcomparedll.a
compare_shared_lflags			+= -Wl,--out-implib=$(compare_install_path_implib)
endif
compare_sources					:= $(wildcard $(compare_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
compare_sources					+= $(wildcard $(compare_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
compare_sources					+= $(wildcard $(compare_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
compare_sources					+= $(wildcard $(compare_path_curdir)platform_specific/mac/*.c)
endif
compare_static_objects			:= $(patsubst %.c, %_static.o, $(compare_sources))
compare_shared_objects			:= $(patsubst %.c, %_shared.o, $(compare_sources))
compare_depends					:= $(patsubst %.c, %.d, $(compare_sources))
compare_depends_modules			:=  
compare_depends_libs_shared		:= $(foreach module,$(compare_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
compare_depends_libs_targets		:= $(foreach module,$(compare_depends_modules),$(module)_all)
compare_clean_files				:=
compare_clean_files				+= $(compare_install_path_implib)
compare_clean_files				+= $(compare_install_path_shared)
compare_clean_files				+= $(compare_static_objects)
compare_clean_files				+= $(compare_shared_objects) 
compare_clean_files				+= $(compare_depends)

include $(compare_child_makefiles)

$(compare_path_curdir)%_static.o: $(compare_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(compare_path_curdir)%_shared.o: $(compare_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(compare_install_path_shared): $(compare_depends_libs_shared)
$(compare_install_path_shared): $(compare_static_objects)
$(compare_install_path_shared): $(compare_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(compare_shared_lflags) $(compare_shared_objects) $(compare_depends_libs_shared)

.PHONY: compare_all
compare_all: $(compare_child_all_targets) ## build and install all compare static and shared libraries
ifneq ($(compare_shared_objects),)
compare_all: $(compare_install_path_shared)
endif

.PHONY: compare_clean
compare_clean: $(compare_child_clean_targets) ## remove and deinstall all compare static and shared libraries
compare_clean:
	- $(RM) $(compare_clean_files)

.PHONY: compare_re
compare_re: compare_clean
compare_re: compare_all

.PHONY: compare_strip
compare_strip: $(compare_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
compare_strip:
	- strip --strip-all $(compare_install_path_shared)

-include $(compare_depends)
