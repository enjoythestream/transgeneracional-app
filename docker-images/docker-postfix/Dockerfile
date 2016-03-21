FROM phusion/baseimage:0.9.17

# Ensure UTF-8
RUN locale-gen es_US.UTF-8
ENV LANG       es_US.UTF-8
ENV LC_ALL     es_US.UTF-8

ENV HOME /root

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]

## Install an SSH Key
#RUN /usr/sbin/enable_insecure_key
RUN rm -f /etc/service/sshd/down
ADD id_tapp.pub /tmp/id_tapp.pub
RUN cat /tmp/id_tapp.pub >> /root/.ssh/authorized_keys && rm -f /tmp/id_tapp.pub

# Update OS
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# Install tools
RUN apt-get install telnet

# Postfix Installation
#RUN DEBIAN_FRONTEND="noninteractive" apt-get install postfix -y
#RUN echo "# Reenvio del correo hacia transgeneracional.app@gmail.com" >> /etc/postfix/main.cf
#RUN echo "virtual_alias_maps = hash:/etc/postfix/virtual" >> /etc/postfix/main.cf

RUN mkdir           	/etc/service/postfix
ADD build/postfix.sh  	/etc/service/postfix/run
RUN chmod +x        	/etc/service/postfix/run

EXPOSE 25 
# End Postfix 

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
