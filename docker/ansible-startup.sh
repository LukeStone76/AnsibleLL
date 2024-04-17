#!/bin/bash

# Create SSH keys
ssh-keygen -t rsa -b 4096 -N "" -f /root/.ssh/id_rsa
cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# Start SSH server in foreground
/usr/sbin/sshd -D
