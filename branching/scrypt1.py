#!/usr/bin/env python3

import os
import sys

bash_command = ["cd "+sys.argv[1], "pwd", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
cwd=result_os.split('\n')
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = cwd[0]+'/'+result.replace('\tmodified:   ', '')
        print(prepare_result)