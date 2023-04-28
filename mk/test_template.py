import os
import sys

platform_specific = 'platform_specific'

def update_config_file(module_config_path, makefile_content):
    CONSOLE_APP = 'CONSOLE_APP'
    WINDOW_APP = 'WINDOW_APP'
    console_application = '-mconsole'
    window_application = '-mwindows'
    if sys.argv[1] != 'WINDOWS':
        console_application = ''
        window_application = ''

    if not os.path.exists(module_config_path):
        with open(module_config_path, 'w') as f:
            # NOTE: assuming gcc compiler, by default console application
            f.write(CONSOLE_APP)
            makefile_content = makefile_content.replace('$(LFLAGS_SPECIFIC)', console_application)
    else:
        with open(module_config_path, 'r') as f:
            config_content = f.read()
            # TODO: make more options to embed into the template and parse them from the file
            if len(config_content) == 0:
                config_content = CONSOLE_APP
            config_content = config_content.replace(CONSOLE_APP, console_application)
            config_content = config_content.replace(WINDOW_APP, window_application)
            makefile_content = makefile_content.replace('$(LFLAGS_SPECIFIC)', config_content)
    
    return makefile_content

def update_directory(directory_path):
    module_name = os.path.basename(directory_path)
    module_path_base_name = os.path.join(directory_path, module_name)
    test_module_path_base_name = module_path_base_name + '_test'
    template_path = 'mk/test_template.txt'

    # get content from the test_template.txt
    content = ''
    with open(template_path, 'r') as f:
        content = f.read()
        content = content.replace('$(MODULE_NAME)', module_name)
    content = update_config_file(module_path_base_name + '.config', content)

    # write content to the test module's makefile
    with open(test_module_path_base_name + '.mk', 'w') as f:
        f.write(content)

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

# if __name__ == '__main__':
source = 'modules'
target = 'tests'
mimic_directory_structure(source, target)
