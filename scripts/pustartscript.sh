#! /bin/bash
apt -y install dirmngr gnupg apt-transport-https software-properties-common ca-certificates curl
curl -fsSL https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
add-apt-repository 'deb https://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main'
apt update sudo
apt -y install mongodb-org
systemctl enable mongod --now
apt install -y ruby-full ruby-bundler build-essential
apt -y install git
cd /home/admin/
git init
git clone -b monolith https://github.com/express42/reddit.git
cd reddit/
bundle install
bundle update --bundler
gem -y install bundler:1.16.1
puma -d