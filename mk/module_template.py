import os

def traverse_directory(path):
    update_directory(path)
    for item in os.listdir(path):
        full_path = os.path.join(path, item)
        if os.path.isdir(full_path):
            traverse_directory(full_path)

def update_directory(directory_path):
    module_name = os.path.basename(directory_path)
    module_path_base_name = os.path.join(directory_path, module_name)
    module_libdeps_path = module_path_base_name + '.libdeps'
    template_path = 'mk/module_template.txt'

    content = ''
    with open(template_path, 'r') as f:
        content = f.read()
        content = content.replace('$(MODULE_NAME)', module_name)
    if not os.path.exists(module_libdeps_path):
        with open(module_libdeps_path, 'w') as f:
            f.write('')
        content = content.replace('$(MODULE_LIBDEP_MODULES)', '')
    else:
        with open(module_libdeps_path, 'r') as f:
            content_libdeps = f.read()
            content = content.replace('$(MODULE_LIBDEP_MODULES)', content_libdeps)

    with open(module_path_base_name + '.mk', 'w') as f:
        f.write(content)

if __name__ == '__main__':
    traverse_directory('modules')
