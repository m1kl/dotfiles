# 00 - Elevate privileges
TMP_DIR=/tmp/ubuntu-apps-installer
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"
mkdir -p $TMP_DIR

# 01 - Update your system
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade

# 02 - Install essential tools
apt-get -y install nano wget curl tree grsync

# 03 - Install Multimedia Codecs and Enable DVD Playback
apt-add-repository -y ppa:mc3man/trusty-media
apt-get -y update
apt-get -y install ubuntu-restricted-extras ffmpeg gstreamer0.10-plugins-ugly libavcodec-extra-54 libvdpau-va-gl1 libmad0 mpg321 gstreamer1.0-libav
/usr/share/doc/libdvdread4/install-css.sÂ­h

# 04 - Install VLC Media Player
apt-get -y install vlc

# 05 - Install Plugin Flash Player and Pepper Flash
apt-get -y install flashplugin-installer pepperflashplugin-nonfree

# 06 - Install JAVA
add-apt-repository -y ppa:webupd8team/java
apt-get -y update
apt-get -y install oracle-java7-installer

# 07 - Install Support for Archive Formats and Restricted Extras
apt-get -y install unace rar unrar p7zip-rar p7zip sharutils uudeview mpack arj cabextract lzip lunzip

# 08 - Install LibreOffice Suites with PT Dictionary
apt-get -y install libreoffice libreoffice-gtk libreoffice-style-sifr libreoffice-l10n-pt
wget http://natura.di.uminho.pt/download/sources/Dictionaries/libreoffice/oo3x-pt_PT.oxt -P $TMP_DIR
unopkg add --force --suppress-license --shared $TMP_DIR/oo3x-pt_PT.oxt

# 09 - Install Additional Web Browser
cp apt-sources/google-chrome.list /etc/apt/sources.list.d/google-chrome.list
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
apt-get -y update
apt-get install -y google-chrome-stable

# 10 - Install Torrent Client
apt-get -y install transmission

# 11 - Install Graphic Editor
apt-get -y install gimp inkscape

# 13 - Install Indicator Synapse
apt-get -y install indicator-synapse

# 14 - Install Elementary Tweak
apt-add-repository -y ppa:mpstark/elementary-tweaks-daily
apt-get -y install elementary-tweak

# 15 - Install Skype
apt-get -y install skype

# 16 - Install Bleachbit System Cleaner
apt-get -y install bleachbit

# 17 - Install SSH Server
apt-get -y install openssh-server

# 18 - Install remote desktop app
apt-get -y install remmina

# 19 - Install virtualbox
apt-get -y install virtualbox

# 20 - Install thunderbird
apt-get -y install thunderbird

# 21 - Install spotify
echo "deb http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 94558F59
apt-get -y update
apt-get -y install spotify-client

# Install sublime text 3
add-apt-repository -y ppa:webupd8team/sublime-text-3
apt-get -y update
apt-get -y install sublime-text

# 22 - For Laptop : Install TLP for Improve Battery Life and Reduce Overheating
add-apt-repository -y ppa:linrunner/tlp
apt-get -y update
apt-get -y install tlp tlp-rdw
tlp start


echo "INFO: Don't forget to install additional drivers (http://www.elementarynow.com/graphic-drivers-for-elementary-os/)"
echo "INFO: Don't forget to install Checkpoint VPN SNX (http://kenfallon.com/check-point-ssl-network-extender/)"
echo "INFO: Don't forget to install thunderbird extensions and theme (https://gist.github.com/mickael83/450fa000c61c139c725a)"

echo "TEST: Check Vocal Podcast for Elementary OS (http://www.webupd8.org/2015/04/try-vocal-podcast-manager-designed-for.html)"
echo "TEST: Check Guake (http://www.webupd8.org/2015/05/drop-down-terminal-guake-070-released.html)"
echo "TEST Check Pushbullet (http://www.webupd8.org/2015/03/pushbullet-indicator-gets-option-to.html)"

# XX - Install Cloud Storage
# Download DropBox : https://www.dropbox.com/install?os=lnx
# Install Google Drive :
# add-apt-repository ppa:alessandro-strada/ppa
# apt-get update
# apt-get install google-drive-ocamlfuse
