abs_path_curdir				:= $(dir $(lastword $(MAKEFILE_LIST)))
abs_child_makefiles			:= $(wildcard $(abs_path_curdir)*/*mk)
abs_child_module_names		:= $(basename $(notdir $(abs_child_makefiles)))
abs_child_all_targets		:= $(foreach child_module,$(abs_child_module_names),$(child_module)_all)
abs_child_strip_targets		:= $(foreach child_module,$(abs_child_module_names),$(child_module)_strip)
abs_child_clean_targets		:= $(foreach child_module,$(abs_child_module_names),$(child_module)_clean)
abs_install_path_shared		:= $(PATH_INSTALL)/abs$(EXT_LIB_SHARED)
abs_shared_lflags			:= -shared
ifeq ($(PLATFORM), WINDOWS)
abs_install_path_implib		:= $(PATH_INSTALL)/libabsdll.a
abs_shared_lflags			+= -Wl,--out-implib=$(abs_install_path_implib)
endif
abs_sources					:= $(wildcard $(abs_path_curdir)*.c)
ifeq ($(PLATFORM), WINDOWS)
abs_sources					+= $(wildcard $(abs_path_curdir)platform_specific/windows/*.c)
else ifeq ($(PLATFORM), LINUX)
abs_sources					+= $(wildcard $(abs_path_curdir)platform_specific/linux/*.c)
else ifeq ($(PLATFORM), MAC)
abs_sources					+= $(wildcard $(abs_path_curdir)platform_specific/mac/*.c)
endif
abs_static_objects			:= $(patsubst %.c, %_static.o, $(abs_sources))
abs_shared_objects			:= $(patsubst %.c, %_shared.o, $(abs_sources))
abs_depends					:= $(patsubst %.c, %.d, $(abs_sources))
abs_depends_modules			:=  
abs_depends_libs_shared		:= $(foreach module,$(abs_depends_modules),$(PATH_INSTALL)/$(module)$(EXT_LIB_SHARED))
abs_depends_libs_targets		:= $(foreach module,$(abs_depends_modules),$(module)_all)
abs_clean_files				:=
abs_clean_files				+= $(abs_install_path_implib)
abs_clean_files				+= $(abs_install_path_shared)
abs_clean_files				+= $(abs_static_objects)
abs_clean_files				+= $(abs_shared_objects) 
abs_clean_files				+= $(abs_depends)

include $(abs_child_makefiles)

$(abs_path_curdir)%_static.o: $(abs_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -DGIL_LIB_STATIC

$(abs_path_curdir)%_shared.o: $(abs_path_curdir)%.c
	$(CC) -c $< -o $@ $(CFLAGS_COMMON) -MMD -MP -MF $(<:.c=.d) -fPIC -DGIL_LIB_SHARED_EXPORT

$(abs_install_path_shared): $(abs_depends_libs_shared)
$(abs_install_path_shared): $(abs_static_objects)
$(abs_install_path_shared): $(abs_shared_objects)
	$(CC) -o $@ $(LFLAGS_COMMON) -mconsole $(abs_shared_lflags) $(abs_shared_objects) $(abs_depends_libs_shared)

.PHONY: abs_all
abs_all: $(abs_child_all_targets) ## build and install all abs static and shared libraries
ifneq ($(abs_shared_objects),)
abs_all: $(abs_install_path_shared)
endif

.PHONY: abs_clean
abs_clean: $(abs_child_clean_targets) ## remove and deinstall all abs static and shared libraries
abs_clean:
	- $(RM) $(abs_clean_files)

.PHONY: abs_re
abs_re: abs_clean
abs_re: abs_all

.PHONY: abs_strip
abs_strip: $(abs_child_strip_targets) ## removes all symbols that are not needed from all the $(MODULES_NAME) shared libraries for relocation processing
abs_strip:
	- strip --strip-all $(abs_install_path_shared)

-include $(abs_depends)
