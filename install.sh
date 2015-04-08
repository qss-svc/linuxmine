# install.sh
# Script to install and begin configuration of MineOS on Debian-based (ubuntu, mint, etc) systems
# You can use straight from the web via: sudo wget http://git.io/ve1Cb -O - | sh
#
# ===> Install pre-requisites
sudo apt-get update
sudo apt-get -y install git openjdk-7-jre-headless python-cherrypy3 rdiff-backup screen
# ===> Install MineOS scripts
sudo mkdir -p /usr/games
cd /usr/games
sudo git clone git://github.com/hexparrot/mineos minecraft
cd minecraft
sudo git config core.filemode false
sudo chmod +x server.py mineos_console.py generate-sslcert.sh
sudo ln -s /usr/games/minecraft/mineos_console.py /usr/local/bin/mineos
# ===> Set up MineOS service to run at boot
sudo cp /usr/games/minecraft/init/mineos /etc/init.d/
sudo chmod 744 /etc/init.d/mineos
sudo update-rc.d mineos defaults
sudo cp /usr/games/minecraft/init/minecraft /etc/init.d/
sudo chmod 744 /etc/init.d/minecraft
sudo update-rc.d minecraft defaults
sudo cp /usr/games/minecraft/mineos.conf /etc/
# ===> Secure HTTPS operation - Generate a self-signed HTTPS certificate
### cd /usr/games/minecraft
sudo ./generate-sslcert.sh
# ===> Restart MineOS scripts
sudo service mineos start
sudo service mineos stop
sudo service mineos start
# ===> Set owner of minecraft profile directories
sudo chown -R mineadmin:mineadmin /var/games/minecraft/profiles/
sudo chown -R mineadmin:mineadmin /var/games/minecraft/profiles/profile.config
