#! /bin/bash
cd /var/www/html/
sudo rm -rf index.html
cd $HOME
sudo apt install -y git
sudo git clone -b https://github.com/AnnaConda007/testForAlex.git
cd testForAlex
mv * /var/www/html/
