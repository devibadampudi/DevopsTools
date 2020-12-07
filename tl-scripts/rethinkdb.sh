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
pip install rethinkdb
pip install --upgrade pip
