FROM phusion/baseimage:0.9.17

# Ensure UTF-8
RUN locale-gen es_US.UTF-8
ENV LANG       es_US.UTF-8
ENV LC_ALL     es_US.UTF-8

ENV HOME /root

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]

## Install an SSH of your choice.
RUN rm -f /etc/service/sshd/down
ADD id_tapp.pub /tmp/id_tapp.pub
RUN cat /tmp/id_tapp.pub >> /root/.ssh/authorized_keys && rm -f /tmp/id_tapp.pub

# Nginx-PHP Installation
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y telnet git git-flow vim curl wget build-essential python-software-properties
RUN add-apt-repository -y ppa:ondrej/php5
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y --force-yes php5-cli php5-fpm php5-mysql php5-pgsql php5-sqlite php5-curl\
		       php5-gd php5-mcrypt php5-intl php5-imap php5-tidy

RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php5/fpm/php.ini
RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php5/cli/php.ini

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y nginx

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini

VOLUME /var/www 

# Add configuration App
ADD build/transgeneracional-app.com /etc/nginx/sites-available/transgeneracional-app.com
RUN mkdir -p 						/etc/my_init.d
ADD etc/my_init.d/98_nginx_conf.sh  /etc/my_init.d/98_nginx_conf.sh
RUN chmod +x						/etc/my_init.d/98_nginx_conf.sh
# End configuration App

RUN mkdir           				/etc/service/nginx
ADD build/nginx.sh  				/etc/service/nginx/run
RUN chmod +x        				/etc/service/nginx/run
RUN mkdir           				/etc/service/phpfpm
ADD build/phpfpm.sh 				/etc/service/phpfpm/run
RUN chmod +x        				/etc/service/phpfpm/run

EXPOSE 80
# End Nginx-PHP

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
