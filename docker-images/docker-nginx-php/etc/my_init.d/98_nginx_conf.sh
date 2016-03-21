#!/bin/bash
cd /etc/nginx/sites-enabled
rm -rf default
ln -s ../sites-available/transgeneracional-app.com