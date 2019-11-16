#/usr/bin/env bash 

# readme more: https://fedoraproject.org/wiki/Common_F31_bugs#Other_software_issues

sudo dnf -y install grubby
sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0" # need reboot
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io

# for mount qcow2 disks
sudo dnf install -y qemu-img
echo "for mount run command:"
echo ""

# vdi -> img -> qcow2
# VBoxManage clonehd --format RAW vm.vdi vm.img
# qemu-img convert -f raw vm.img -O qcow2 vm.qcow2

# How to mount a qcow2 disk image
# 
# This is a quick guide to mounting a qcow2 disk images on your host server. This is useful to reset passwords, edit files, or recover something without the virtual machine running.
# 
# Step 1 - Enable NBD on the Host
# 
# modprobe nbd max_part=8
# 
# Step 2 - Connect the QCOW2 as network block device
# 
# qemu-nbd --connect=/dev/nbd0 /var/lib/vz/images/100/vm-100-disk-1.qcow2
# 
# Step 3 - Find The Virtual Machine Partitions
# 
# fdisk /dev/nbd0 -l
# 
# Step 4 - Mount the partition from the VM
# 
# mount /dev/nbd0p1 /mnt/somepoint/
# 
# Step 5 - After you done, unmount and disconnect
# 
# umount /mnt/somepoint/
# qemu-nbd --disconnect /dev/nbd0
# rmmod nbd
