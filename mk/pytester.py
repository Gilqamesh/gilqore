import sys
import subprocess
from termcolor import cprint

if __name__ == '__main__':
    command_line_args = sys.argv[1:]
    try:
        print(command_line_args[0])
        subprocess.check_call(['cmd', '/c'] + command_line_args)
        cprint("SUCCESS", "white", "on_green")
    except subprocess.CalledProcessError as err:
        cprint("FAILURE, error code: " + str(err.returncode), "white", "on_red")
