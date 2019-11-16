#/usr/bin/env bash 

# readme more: https://fedoraproject.org/wiki/Common_F31_bugs#Other_software_issues

sudo dnf -y install grubby
sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0" # need reboot
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io
