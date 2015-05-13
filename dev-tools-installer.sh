# 00 - Elevate privileges
TMP_DIR=/tmp/ubuntu-dev-tools-installer
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"
mkdir -p $TMP_DIR

# 01 - Update your system
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade

# 02 - Git tools
apt-get -y install git git-core bash-completion git-flow vim
wget https://raw.githubusercontent.com/bobthecow/git-flow-completion/master/git-flow-completion.bash -qO /etc/bash_completion.d/git-flow-completion.bash
#echo "deb http://debian.sourcegear.com/ubuntu trusty main" > /etc/apt/sources.list.d/sourcegear.list
#wget -O - http://debian.sourcegear.com/SOURCEGEAR-GPG-KEY | sudo apt-key add -
wget http://download-us.sourcegear.com/DiffMerge/4.2.0/diffmerge_4.2.0.697.stable_amd64.deb -P $TMP_DIR
dpkg -i $TMP_DIR/diffmerge_4.2.0.697.stable_amd64.deb
#apt-get -y update
#apt-get -y install diffmerge
git config --global diff.tool diffmerge
git config --global difftool.diffmerge.cmd 'diffmerge "$LOCAL" "$REMOTE"'
git config --global merge.tool diffmerge
git config --global mergetool.diffmerge.cmd 'diffmerge --merge --result="$MERGED" "$LOCAL" "$(if test -f "$BASE"; then echo "$BASE"; else echo "$LOCAL"; fi)" "$REMOTE"'
git config --global mergetool.diffmerge.trustExitCode true

# 03 - PHP Stack
add-apt-repository -y ppa:ondrej/php5-5.6
apt-get update
apt-get install -y php5 php5-mcrypt php5-xdebug php5-mysql phpunit php5-curl php5-gd php5-sybase
php5enmod mcrypt
php5enmod xdebug
php5enmod mysql
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# 04 - Javascript Stack
apt-get install -y nodejs npm
update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10
npm install -g httpster
npm install -g jscs
npm install -g jshint
npm install -g bower
npm install -g yo
npm install -g grunt-cli
npm install -g gulp
npm install -g generator-ng-factory
npm install -g generator-gulp-angular
npm install -g generator-angularjs-library
npm install -g ionic

# 05 - Install MySQL Server + MySQL Workbench
wget https://dev.mysql.com/get/mysql-apt-config_0.3.5-1ubuntu14.04_all.deb -P $TMP_DIR
dpkg -i $TMP_DIR/mysql-apt-config_0.3.5-1ubuntu14.04_all.deb
apt-get -y update
apt-get -y install mysql-server
apt-get -y install mysql-workbench-community

# 05 - Install mongodb + robomongo
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
apt-get -y update
apt-get -y install mongodb-org
wget http://robomongo.org/files/linux/robomongo-0.8.5-x86_64.deb -P $TMP_DIR
dpkg -i $TMP_DIR/robomongo-0.8.5-x86_64.deb

# 06 - Install nginx+passenger
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
apt-get -y install apt-transport-https ca-certificates
echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list.d/nginx.list
echo "deb-src http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list.d/nginx.list
echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main" > /etc/apt/sources.list.d/passenger.list
apt-get -y update
apt-get -y install nginx-full passenger
service nginx restart

echo "INFO: Dont't forget to configure FreeTDS (https://laracasts.com/discuss/channels/general-discussion/sqlsrv-driver-on-linux/replies/14216)"
echo "INFO: Dont't forget to configure XDEBUG max nesting level (https://laracasts.com/discuss/channels/general-discussion/xdebug-max-nesting-level-reached)"

