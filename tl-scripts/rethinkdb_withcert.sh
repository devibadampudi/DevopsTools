##To install the server, you have to add the RethinkDB repository to your list of repositories and install via apt-get.
sudo -s source /etc/lsb-release && echo "deb http://download.rethinkdb.com/apt xenial main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
wget -qO- https://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -
sudo apt-get update
##
##Install rethinkdb using apt-get
sudo apt-get install rethinkdb -y
##
##Install the dependencies
sudo apt-get install build-essential protobuf-compiler python -y 
sudo apt-get install libprotobuf-dev libcurl4-openssl-dev -y
sudo apt-get install libboost-all-dev libncurses5-dev -y
sudo apt-get install libjemalloc-dev wget m4 -y
sudo apt install python-pip -y
#pip install rethinkdb
 pip install rethinkdb==2.3.0.post6
pip install --upgrade pip


sudo cp /etc/rethinkdb/default.conf.sample /etc/rethinkdb/instances.d/instance1.conf
sudo su -c "echo 'runuser=rethinkdb' >> /etc/rethinkdb/instances.d/instance1.conf" sudo su -c "echo 'rungroup=rethinkdb' >> /etc/rethinkdb/instances.d/instance1.conf" sudo su -c "echo 'pid-file=/var/run/rethinkdb/rethinkdb.pid' >> /etc/rethinkdb/instances.d/instance1.conf" sudo su -c "echo 'directory=/var/lib/rethinkdb/default' >> /etc/rethinkdb/instances.d/instance1.conf" sudo su -c "echo 'log-file=/var/log/rethinkdb' >> /etc/rethinkdb/instances.d/instance1.conf" sudo su -c "echo 'bind=all' >> /etc/rethinkdb/instances.d/instance1.conf" sudo su -c "echo 'join=:29015' >> /etc/rethinkdb/instances.d/instance1.conf" sudo su -c "echo 'driver-port=28015' >> /etc/rethinkdb/instances.d/instance1.conf" sudo su -c "echo 'cluster-port=29015' >> /etc/rethinkdb/instances.d/instance1.conf" sudo su -c "echo 'server-name=' >> /etc/rethinkdb/instances.d/instance1.conf" sudo su -c "echo 'http-tls-key =/etc/rethinkdb/instances.d/rethinkdb_data/key.pem' >> /etc/rethinkdb/instances.d/instance1.conf" sudo su -c "echo 'http-tls-cert =/etc/rethinkdb/instances.d/rethinkdb_data/cert.pem' >> /etc/rethinkdb/instances.d/instance1.conf" sudo su -c "echo 'tls-min-protocol=TLSv1' >> /etc/rethinkdb/instances.d/instance1.conf"
cd /var/log
sudo touch rethinkdb
sudo chown -R rethinkdb:rethinkdb rethinkdb
sudo chmod 775 rethinkdb
cd /var/lib
sudo chown -R rethinkdb:rethinkdb rethinkdb
sudo chmod 775 rethinkdb
sudo systemctl enable rethinkdb
sudo systemctl start rethinkdb
sudo update-rc.d rethinkdb enable
cd /etc/rethinkdb/instances.d
sudo mkdir rethinkdb_data
sudo chmod 775 rethinkdb_data
#cd rethinkdb_data
#sudo openssl genrsa -out key.pem 2048
#sudo openssl req -new -x509 -key key.pem -out cert.pem -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=example.com"
#sudo chmod 775 key.pem
#sudo chmod 775 cert.pem
#sudo rethinkdb --http-tls-key key.pem --http-tls-cert cert.pem
