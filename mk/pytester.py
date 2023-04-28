import sys
import subprocess
from termcolor import cprint

if __name__ == '__main__':
    test_program_path = sys.argv[1]
    test_program_args = ''
    try:
        print('test_program_path: ')
        subprocess.check_call([test_program_path, test_program_args])
        cprint("SUCCESS", "white", "on_green")
    except subprocess.CalledProcessError as err:
        cprint("FAILURE, error code: " + str(err.returncode), "white", "on_red")
