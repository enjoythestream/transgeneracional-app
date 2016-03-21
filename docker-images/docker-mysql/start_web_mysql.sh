docker run -p 3306:3306 --name mysqld -d davidmoya/mysqltest /sbin/my_init
docker run -v /home/stream/containers/test/docker-nginx-php/www:/var/www:rw -p 80:80 --link mysqld -d davidmoya/transapp:0.1 /sbin/my_init

