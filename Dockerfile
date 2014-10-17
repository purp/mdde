# Mobile Docker Development Environment (MDDE)
# Source at http://github.com/purp/mdde

# Base image on https://github.com/purp/docker-oracle-java7

FROM purp/docker-oracle-java7
MAINTAINER Jim Meyer <purp@acm.org>

RUN apt-get update && apt-get upgrade -y && apt-get -y install openssh-server

# From http://www.florentflament.com/blog/git-ssh-docker-container.html
# Setting openssh
RUN mkdir /var/run/sshd && sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config

# Adding unprivileged user
RUN adduser purp && chown -R purp:purp /home/purp && mkdir -p -m700 /home/purp/.ssh
RUN echo 'purp ALL=(ALL:ALL) ALL' >> /etc/sudoers

# Clearing and setting authorized ssh keys
RUN echo '' > /home/purp/.ssh/authorized_keys
RUN echo 'ssh-dss AAAAB3NzaC1kc3MAAACAaggxwJu9NJIIRVTTT9sjeNSYnk+jiNKDz/nJogZ58U1EebEOda43HLJp8zJq957WtsTh96P8YtcDV6yoCJ0/uM4g05MAYrmadTg92tF+G+nP/xLpHvSOY7bMM8dkhnf0GoL5MG6jRNNvNV4Cce3G6vHxKPcvqaVIyFIunUbI4D0AAAAVAKpbLkOVxagqVT8M2Ej+JleJfBcrAAAAgGJQq3a6p/3zmn9SN3tlsGPc28163QM3z+9WmGgn0q4BYGyGq1JIR4SH14yTU8gZEKSo47IoVOjs71ZU2fB2ZbGAfHIoOp8lPHGvlKHG6OJGvFkelk2bb+LOhI8rZsFBgp9ADMhjtB9v+x8V0Y3ptJvh5X/oZZ2qrxN6fvo207soAAAAgDV/rO3JxyZIbDyrxUj8adJEiQhOuuAuLCM/EmIY78RFmQNDhnKZw6gLz8Ybm1wUWRd2HTrqwHsWdP8ZY13rIpqSJrwmQV0jaAQR5WxWDqWABlkQ8WyDSBRr1Dwn8TPHfM4/Cv/M1W3e9mmgEJF55SPMuDKsRBmiqgcOBVzKnJGL 32eef11c6a16307c64fa8a47887bdb5055711ef3-iphone-dsa-key-20110531' >> /home/purp/.ssh/authorized_keys

# Updating shell to bash
# RUN sed -i s#/home/git:/bin/false#/home/git:/bin/bash# /etc/passwd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
