import os
import shutil

platform_specific = 'platform_specific'

def update_directory(directory_path):
    module_name = os.path.basename(directory_path)
    module_path_base_name = os.path.join(directory_path, module_name)
    test_module_path_base_name = module_path_base_name + '_test'
    module_libdeps_path = module_path_base_name + '.libdeps'
    template_path = 'mk/test_template.txt'

    # get content from the test_template.txt
    content = ''
    with open(template_path, 'r') as f:
        content = f.read()
        content = content.replace('$(MODULE_NAME)', module_name)
    if not os.path.exists(module_libdeps_path):
        with open(module_libdeps_path, 'w') as f:
            f.write(module_name)
        content = content.replace('$(MODULE_LIBDEP_MODULES)', module_name)
    else:
        with open(module_libdeps_path, 'r') as f:
            content_libdeps = f.read()
            content = content.replace('$(MODULE_LIBDEP_MODULES)', content_libdeps)

    # write content to the test module's makefile
    with open(test_module_path_base_name + '.mk', 'w') as f:
        f.write(content)
    
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
    if not os.path.exists(platform_specific_windows_dir + gitkeep):
        open(platform_specific_windows_dir + gitkeep, 'w')

    if not os.path.exists(platform_specific_linux_dir):
        os.makedirs(platform_specific_linux_dir)
    if not os.path.exists(platform_specific_linux_dir + gitkeep):
        open(platform_specific_linux_dir + gitkeep, 'w')

    if not os.path.exists(platform_specific_mac_dir):
        os.makedirs(platform_specific_mac_dir)
    if not os.path.exists(platform_specific_mac_dir + gitkeep):
        open(platform_specific_mac_dir + gitkeep, 'w')

def get_subdirectories(directory):
    subdirectories = []
    entries = os.listdir(directory)
    for entry in entries:
        full_path = os.path.join(directory, entry)
        if os.path.isdir(full_path):
            if os.path.basename(full_path) != platform_specific:
                subdirectories.append(full_path)
                subdirectories += get_subdirectories(full_path)
    return subdirectories

def mimic_directory_structure(source, target):
    src_dirs = get_subdirectories(source)

    for dir in src_dirs:
        target_dir = dir.replace(source, target)
        if not os.path.exists(target_dir):
            os.makedirs(target_dir)
        update_directory(target_dir)

if __name__ == '__main__':
    source = 'modules'
    target = 'tests'
    mimic_directory_structure(source, target)
