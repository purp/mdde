# Mobile Docker Development Environment (MDDE)
# Source at http://github.com/purp/mdde

# Base image on https://github.com/purp/docker-oracle-java7

FROM purp/docker-oracle-java7
MAINTAINER Jim Meyer <purp@acm.org>

RUN apt-get install git openssh-server

# From http://www.florentflament.com/blog/git-ssh-docker-container.html
# Setting openssh
RUN mkdir /var/run/sshd && sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config

# Adding unprivileged user
RUN adduser purp && mkdir -p -m755 /home/purp/.ssh
RUN echo 'purp ALL=(ALL:ALL) ALL' >> /etc/sudoers

# Clearing and setting authorized ssh keys
RUN echo '' > /home/purp/.ssh/authorized_keys
RUN echo 'First SSH public key' >> /home/purp/.ssh/authorized_keys
RUN echo 'Second SSH public key' >> /home/purp/.ssh/authorized_keys

# Updating shell to bash
# RUN sed -i s#/home/git:/bin/false#/home/git:/bin/bash# /etc/passwd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
