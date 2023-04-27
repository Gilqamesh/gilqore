import sys
import subprocess
from termcolor import colored

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

test_program_path = sys.argv[1]
test_program_args = ''
try:
    print('test_program_path: ')
    subprocess.check_call([test_program_path, test_program_args])
    print(bcolors.OKGREEN + "SUCCESS" + bcolors.ENDC)
except subprocess.CalledProcessError as err:
    print(bcolors.FAIL + "FAILURE, error code: " + str(err.returncode) + bcolors.ENDC)
