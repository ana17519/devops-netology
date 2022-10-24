#!/usr/bin/env python3
import json
import os
import socket
import time

import yaml

dns_list = ['drive.google.com', 'mail.google.com', 'google.com']
current_directory = os.getcwd()
ip_list = [None, None, None]
# счетчик времени для отладки, целевое значение   while True
start_time = time.time()
while int((time.time() - start_time)) < 30:
    # while True:
    print("*******")
    d1 = dict()
    for i in range(0, len(dns_list)):
        time.sleep(1)
        ip = socket.gethostbyname(dns_list[i])
        print(dns_list[i] + ' -> ' + ip)
        d1[dns_list[i]] = ip
        if ip_list[i] is None:
            ip_list[i] = ip
        elif ip_list[i] != ip:
            print('[ERROR] ' + dns_list[i] + ' IP mismatch: ' + ip_list[i] + ' ' + ip)
    with open(os.path.join(current_directory, "service.json"), 'w') as file_json:
        file_json.write(json.dumps(d1))
    with open(os.path.join(current_directory, "service.yaml"), 'w') as file_yaml:
        file_yaml.write(yaml.dump(d1, explicit_start=True, explicit_end=True))
