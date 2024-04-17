FROM quay.io/centos/centos:stream9

# Install packages
RUN dnf install -y epel-release
RUN dnf install -y openssh-clients openssh-server make ansible

# Prepare startup script
COPY docker/ansible-startup.sh /root/run.sh
RUN chmod 774 /root/run.sh

# Create host keys
RUN ssh-keygen -A

# Allow SSH port
EXPOSE 22

CMD [ "/root/run.sh" ]
