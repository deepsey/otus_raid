# !/bin/bash

mdadm --zero-superblock --force /dev/sd{i,j}

# Create RAID 6

mdadm --create --verbose /dev/md/raid6 -l 6 -n 5 /dev/sd{b,c,d,e,f}

# Adding spare

mdadm --add /dev/md/raid6 /dev/sdg

# Create mdadm.conf

if ! [ -e /etc/mdadm ] 
then 
mkdir /etc/mdadm 
fi

if ! [ -e /etc/mdadm/mdadm.conf ]
then
touch /etc/mdadm/mdadm.conf
echo "DEVICE partitions" > /etc/mdadm/mdadm.conf
fi

mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf   
