import os

platform_specific = 'platform_specific'
target_directory = 'modules'

def traverse_directory(path):
    update_directory(path)
    for item in os.listdir(path):
        full_path = os.path.join(path, item)
        if os.path.isdir(full_path):
            if os.path.basename(full_path) != platform_specific:
                traverse_directory(full_path)

def update_directory(directory_path):
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

if __name__ == '__main__':
    traverse_directory(target_directory)
