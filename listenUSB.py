import os
import csv

"""
Run
    python3 listenUSB.py n output_path time_seconds
where n is the number of the USB port desired
The progam will access the serial:
    /dev/ttyUSBn
"""

import os
import sys
import serial
from time import time 
from datetime import datetime 

ser = serial.Serial('/dev/ttyUSB{}'.format(sys.argv[1]),9600)
if not os.path.exists(sys.argv[2]):
    os.mkdir(sys.argv[2])
file_name_path = sys.argv[2] + '/data.csv'

time_seconds = int(sys.argv[3])

init_time = time()

with open(file_name_path,'w') as export_file:
    writer = csv.writer(export_file, delimiter = ',')
    while time() - init_time < time_seconds:
        line = ser.readline()
        if len(line)!=0:
            line = line.decode('utf-8')
            line.replace('\n','').replace('\r','').rstrip('\r\n')
            line = line[:-2]
            writer.writerow([line,datetime.now().strftime('%Y%m%d_%H%M%S_%f')])
    export_file.close()
