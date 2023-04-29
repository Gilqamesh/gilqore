import os
import sys

platform_specific = 'platform_specific'
target_directory = 'modules'

def traverse_directory(path):
    update_directory(path)
    for item in os.listdir(path):
        full_path = os.path.join(path, item)
        if os.path.isdir(full_path):
            if os.path.basename(full_path) != platform_specific:
                traverse_directory(full_path)

def content_module_config(module_config_path):
    CONSOLE_APP = 'CONSOLE_APP'
    WINDOW_APP = 'WINDOW_APP'
    console_application = '-mconsole'
    window_application = '-mwindows'
    if sys.argv[1] != 'WINDOWS':
        console_application = ''
        window_application = ''

    config_content = ''
    if not os.path.exists(module_config_path):
        with open(module_config_path, 'w') as f:
            # NOTE: assuming gcc compiler, by default console application
            f.write(CONSOLE_APP)
    else:
        with open(module_config_path, 'r+') as f:
            config_content = f.read()
            # TODO: make more options to embed into the template and parse them from the file
            if len(config_content) == 0:
                f.write(CONSOLE_APP)
                config_content = CONSOLE_APP
            config_content = config_content.replace(CONSOLE_APP, console_application)
            config_content = config_content.replace(WINDOW_APP, window_application)
    
    return config_content

def content_module_libdeps(module_libdeps_path):
    libdeps_content = ''
    if not os.path.exists(module_libdeps_path):
        with open(module_libdeps_path, 'w') as f:
            f.write(libdeps_content)
    else:
        with open(module_libdeps_path, 'r') as f:
            libdeps_content = f.read()

    return libdeps_content

def content_makefile(module_name, config_content, libdeps_content):
    makefile_content = ''
    with open('mk/module_template.txt', 'r') as f:
        makefile_content = f.read()
        makefile_content = makefile_content.replace('$(MODULE_NAME)', module_name)
        makefile_content = makefile_content.replace('$(MODULE_LIBDEP_MODULES)', libdeps_content)
    makefile_content = makefile_content.replace('$(LFLAGS_SPECIFIC)', config_content)

    return makefile_content

def update_directory(directory_path):
    module_name = os.path.basename(directory_path)
    module_path_base_name = os.path.join(directory_path, module_name)
    config_suffix = '.config'
    libdeps_suffix = '.libdeps'
    module_config_path = module_path_base_name + config_suffix
    module_libdeps_path = module_path_base_name + libdeps_suffix

    libdeps_content = ''
    config_content = ''

    config_content += content_module_config(module_config_path)

    if directory_path != target_directory:
        # create cross-platform directories for the module
        platform_specific_dir = directory_path + '/' + platform_specific + '/'
        platform_specific_windows_dir = platform_specific_dir + 'windows/'
        platform_specific_linux_dir = platform_specific_dir + 'linux/'
        platform_specific_mac_dir = platform_specific_dir + 'mac/'
        gitkeep = '.gitkeep'
        if not os.path.exists(platform_specific_dir):
            os.makedirs(platform_specific_dir)

        if not os.path.exists(platform_specific_windows_dir):
            os.makedirs(platform_specific_windows_dir)
        windows_libdeps_content = content_module_libdeps(platform_specific_windows_dir + 'windows' + libdeps_suffix)
        if sys.argv[1] == 'WINDOWS':
            libdeps_content += windows_libdeps_content
        if not os.path.exists(platform_specific_windows_dir + gitkeep):
            open(platform_specific_windows_dir + gitkeep, 'w')

        if not os.path.exists(platform_specific_linux_dir):
            os.makedirs(platform_specific_linux_dir)
        linux_libdeps_content = content_module_libdeps(platform_specific_linux_dir + 'linux' + libdeps_suffix)
        if sys.argv[1] == 'LINUX':
            libdeps_content += linux_libdeps_content
        if not os.path.exists(platform_specific_linux_dir + gitkeep):
            open(platform_specific_linux_dir + gitkeep, 'w')

        if not os.path.exists(platform_specific_mac_dir):
            os.makedirs(platform_specific_mac_dir)
        mac_libdeps_content = content_module_libdeps(platform_specific_mac_dir + 'mac' + libdeps_suffix)
        if sys.argv[1] == 'MAC':
            libdeps_content += mac_libdeps_content
        if not os.path.exists(platform_specific_mac_dir + gitkeep):
            open(platform_specific_mac_dir + gitkeep, 'w')

    libdeps_content += ' ' + content_module_libdeps(module_libdeps_path)
    makefile_content = content_makefile(module_name, config_content, libdeps_content)

    # write content to the module's makefile
    with open(module_path_base_name + '.mk', 'w') as f:
        f.write(makefile_content)

if __name__ == '__main__':
    traverse_directory(target_directory)
