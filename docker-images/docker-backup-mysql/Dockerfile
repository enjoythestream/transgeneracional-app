FROM phusion/baseimage:0.9.17

# Ensure UTF-8
RUN locale-gen es_US.UTF-8
ENV LANG       es_US.UTF-8
ENV LC_ALL     es_US.UTF-8

ENV HOME /root

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]

# Some Environment Variables
ENV DEBIAN_FRONTEND noninteractive

RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d

## Install an SSH of your choice.
RUN rm -f /etc/service/sshd/down
ADD id_tapp.pub /tmp/id_tapp.pub
RUN cat /tmp/id_tapp.pub >> /root/.ssh/authorized_keys && rm -f /tmp/id_tapp.pub

# MySQL client Installation
RUN apt-get update
RUN apt-get install -y mysql-client-5.6

VOLUME /var/lib/mysql

#ADD etc/my_init.d/99_mysql_setup.sh /etc/my_init.d/99_mysql_setup.sh
#RUN chmod +x /etc/my_init.d/99_mysql_setup.sh

#EXPOSE 3306
# END MySQL Installation

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
