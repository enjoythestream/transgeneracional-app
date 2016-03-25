FROM phusion/baseimage:0.9.17

ENV HOME /root

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]

# Some Environment Variables
ENV DEBIAN_FRONTEND noninteractive

RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d

## Install an SSH of your choice.
#RUN /usr/sbin/enable_insecure_key
RUN rm -f /etc/service/sshd/down
ADD id_tapp.pub /tmp/id_tapp.pub
RUN cat /tmp/id_tapp.pub >> /root/.ssh/authorized_keys && rm -f /tmp/id_tapp.pub

# MySQL Installation
RUN apt-get update
RUN echo "mysql-server mysql-server/root_password password 12345" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password 12345" | debconf-set-selections
RUN apt-get install -y mysql-server

ADD build/my.cnf    /etc/mysql/my.cnf

RUN mkdir           /etc/service/mysql
ADD build/mysql.sh  /etc/service/mysql/run
RUN chmod +x        /etc/service/mysql/run

VOLUME /var/lib/mysql

#RUN mkdir -p        /var/lib/mysql/
RUN chmod -R 755    /var/lib/mysql/

#ADD etc/my_init.d/99_mysql_setup.sh /etc/my_init.d/99_mysql_setup.sh
#RUN chmod +x /etc/my_init.d/99_mysql_setup.sh

EXPOSE 3306
# END MySQL Installation

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
