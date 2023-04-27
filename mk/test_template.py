import os
import shutil

def update_directory(directory_path):
    module_name = os.path.basename(directory_path)
    module_path_base_name = os.path.join(directory_path, module_name)
    test_module_path_base_name = module_path_base_name + '_test'
    module_libdeps_path = module_path_base_name + '.libdeps'
    template_path = 'mk/test_template.txt'

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

    with open(test_module_path_base_name + '.mk', 'w') as f:
        f.write(content)

def mimic_directory_structure(source_dir, target_dir):
    update_directory(target_dir)
    for root, dirs, files in os.walk(source_dir):
        # create directory structure in target directory
        for dir in dirs:
            dir_path = os.path.join(root.replace(source_dir, target_dir), dir)
            if os.path.isdir(os.path.join(root, dir)):
                if not os.path.exists(dir_path):
                    os.makedirs(dir_path)
                mimic_directory_structure(os.path.join(root, dir), dir_path)

if __name__ == '__main__':
    source_dir = 'modules'
    target_dir = 'tests'
    mimic_directory_structure(source_dir, target_dir)
