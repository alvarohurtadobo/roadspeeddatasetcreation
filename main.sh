#! /bin/bash

echo "Staring"


ipcamera=${1:=''}
usb=${2:=0}
duration=${3:=3600}
fps=${4:=8}
output=${5:='/home/alvaro/projects/python'}

today=`date +%Y%m%d_%H%M%S`
echo "source $ipcamera"
echo $usb
echo $duration
echo $fps
echo "path to output: $output"
echo "Today $today"

export FLOW_PATH="$HOME/projects/python"
current_file_name="$output/$today"
mkdir $current_file_name

echo $current_file_name

frames=$(( duration*fps ))
cd "$FLOW_PATH/preview"

echo "RUNNING camera in $FLOW_PATH/preview"
echo "python3 main.py -i $ipcamera -k $duration -s True -o $current_file_name -n $frames "
python3 main.py -i $ipcamera -k $duration -s True -o $current_file_name -n $frames 

cd "$FLOW_PATH/roadspeeddatasetcreation"
echo "RUNNING script in $FLOW_PATH/roadspeeddatasetcreation"
echo "python3 listenUSB.py $usb $current_file_name $duration"
python3 listenUSB.py $usb $current_file_name $duration

