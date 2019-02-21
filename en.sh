#!/bin/bash

z="1"
for i in /home/yudhis/Documents/nature-1/nature/*.jpg
do
  base64 -d $i | xxd -r >> /home/yudhis/Documents/Foto/$z.jpg
z=$(($z+1))
done 
