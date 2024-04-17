FROM quay.io/centos/centos:stream9

# Install packages
RUN dnf install -y openssh-clients openssh-server

# Create host keys
RUN ssh-keygen -A

# Allow SSH port
EXPOSE 22

# Start SSH server in foreground
CMD [ "/usr/sbin/sshd", "-D" ]
