#!/usr/bin/env python3

#import re
#import os
#import sys

#my_file = open("./neutron-openvswitch-agent.log-20180129-1517214601", "r")
#f = open('/home/alex1/neutron-openvswitch-agent.log-20180129-1517214601', 'r')

from datetime import datetime


inf = 0
num = 0
err = 0
errtrc = 0
war = 0
with open("./neutron-openvswitch-agent.log-20180129-1517214601", "r") as f:
    for line in f.readlines():
        num += 1
        nwar = line.find("WARNING")
        if nwar != -1:
            war += 1

        ninf = line.find("INFO")
        if ninf != -1:
            inf += 1

        nerr = line.find("ERROR")
        if nerr != -1:
            err += 1
        nan = line.find("Traceback")
        nun = line.find("u\'Traceback")
        if (nan != -1 and nun == -1):
            start = num
            start -= 1
            #print(num)
            #print(start)
            #print(line)

        if nun != -1:
            err +=1
            end = num
            end = end + 1
            dif = end - start + 1
            err=err - dif

            #print(dif)
            #print(end)

        #print(line)

print("INFO",inf)
print("ERROR",err)
print("WARNING",war)

num = 0
inf = 0
err = 0
errtrc = 0
war = 0
num2 = 0
line2 = 0


with open("./neutron-openvswitch-agent.log-20180129-1517214601", "r") as f:
    for line in f.readlines():
        num += 1
        if line2 == 0:
            line2 = line
            line3 = line

        nwar = line.find("WARNING")
        if nwar != -1:
            war += 1

        ninf = line.find("INFO")
        if ninf != -1:
            inf += 1

        nerr = line.find("ERROR")
        if nerr != -1:
            err += 1
        nan = line.find("Traceback")
        nun = line.find("u\'Traceback")
        if (nan != -1 and nun == -1):
            start = num
            start -= 1
            #print(num)
            #print(start)
            #print(line)

        if nun != -1:
            err +=1
            end = num
            end = end + 1
            dif = end - start + 1
            err=err - dif

        a = datetime.strptime(line[:19], "%Y-%m-%d %H:%M:%S")
        b = datetime.strptime(line2[:19], "%Y-%m-%d %H:%M:%S")
        c = datetime.strptime(line3[:19], "%Y-%m-%d %H:%M:%S")
        time_diff = a - b

        if time_diff.total_seconds() > 21600:

            nwar = line.find("WARNING")
            if nwar != -1:
                war -= 1

            ninf = line.find("INFO")
            if ninf != -1:
                inf -= 1

            nerr = line.find("ERROR")
            if nerr != -1:
                err -= 1

            print("C",b, "ПО",c)
            print("INFO",inf)
            print("ERROR",err)
            print("WARNING",war)
            inf = 0
            err = 0
            errtrc = 0
            war = 0
            line2 = line3

        line3 = line

        time_diff = datetime.strptime(line[:19], "%Y-%m-%d %H:%M:%S") - datetime.strptime(line2[:19], "%Y-%m-%d %H:%M:%S")
        #print (time_diff.total_seconds())
