#!/usr/bin/env bash
# exit 0
set -ex

echo '##########################################################################'
echo '############### About to run samba_client_setup.sh script ##################'
echo '##########################################################################'

yum -y install samba samba-client cifs-utils

mkdir -p /mnt/editors-team-folder

groupadd --gid 2000 editors
useradd -u 3334 tom
useradd -u 3335 jerry 

usermod -aG editors tom
usermod -aG editors jerry


# this checks for available shares
#smbclient -L //samba-storage.local -U tom  <<EOF
#passowrd123
#EOF

# mount -t cifs -o user=tom,password=tompassword,rw,soft,_netdev //samba-storage.local/export_rw /mnt/editors-team-folder


echo 'username=tom' > /etc/toms-samba-creds
echo 'password=tompassword' >> /etc/toms-samba-creds
chmod 600 /etc/toms-samba-creds

echo '//samba-storage.local/editors_collab_folder /mnt/editors-team-folder  cifs  credentials=/etc/toms-samba-creds,soft,rw,_netdev  0 0' >> /etc/fstab
mount -a

exit 0