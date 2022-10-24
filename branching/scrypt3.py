#!/usr/bin/env python3
from datetime import datetime
import socket
import time

dns_list = ['drive.google.com', 'mail.google.com', 'google.com']
ip_list = [None, None, None]
# счетчик времени для отладки, целевое значение   while True
start_time = time.time()
while int((time.time() - start_time)) < 30:
    # while True:
    print("*******")
    for i in range(0, len(dns_list)):
        time.sleep(1)
        ip = socket.gethostbyname(dns_list[i])
        print(dns_list[i] + ' -> ' + ip)
        if ip_list[i] is None:
            ip_list[i] = ip
        elif ip_list[i] != ip:
            print('[ERROR] ' + dns_list[i] + ' IP mismatch: ' + ip_list[i] + ' ' + ip)
