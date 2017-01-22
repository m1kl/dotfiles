#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_common_tools() {

    install_package "RPM Fusion free repo" "http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
    install_package "RPM Fusion non-free repo" "http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

    install_package "Development tools (aka Build Essential)" "@development-tools"
    install_package "automake" "automake"
    install_package "autoconf" "autoconf"
    install_package "java-openjdk" "java-openjdk"
    install_package "icedtea-web" "icedtea-web"
    install_package "Telnet" "telnet"
    install_package "Vim" "vim"
    install_package "Gnome tweak tool" "gnome-tweak-tool"
    install_package "Simple Scan" "simple-scan"
    install_package "gtk3-devel" "gtk3-devel"

    install_package "Unzip" "unzip"
    install_package "CabExtract" "cabextract"
    install_package "Zip" "zip"
    install_package "p7zip" "p7zip"
    install_package "p7zip plugins" "p7zip-plugins"
    install_package "Unrar" "unrar"

    install_package "gstreamer-plugins-bad" "gstreamer-plugins-bad"
    install_package "gstreamer-plugins-ugly" "gstreamer-plugins-ugly"
    install_package "lame" "lame"
    install_package "faad2" "faad2"
    install_package "ffmpeg" "ffmpeg"
    install_package "ffmpeg-libs" "ffmpeg-libs"
    install_package "gstreamer-ffmpeg" "gstreamer-ffmpeg"
    install_package "libbdplus" "libbdplus"
    install_package "libaacs" "libaacs"      
    install_package "Evolution RSS" "evolution-rss"      
    install_package "PT ASpelling" "aspell-pt_PT"
    install_package "PT HunSpelling" "hunspell-pt"      


    #if ! package_is_installed "evopop-gtk-theme"; then
    #    add_repo "phnxrbrn-evopop.repo" \
    #                "[phnxrbrn-evopop]" \
    #                "name=Copr repo for evopop owned by phnxrbrn" \
    #                "baseurl=https://copr-be.cloud.fedoraproject.org/results/phnxrbrn/evopop/fedora-26-x86_64/" \
    #                "type=rpm-md" \
    #                "skip_if_unavailable=True" \
    #                "gpgcheck=1" \
    #                "gpgkey=https://copr-be.cloud.fedoraproject.org/results/phnxrbrn/evopop/pubkey.gpg" \
    #                "repo_gpgcheck=0" \
    #                "enabled=1" \
    #                "enabled_metadata=1" 
    #fi
    #install_package "Evopop theme" "evopop-gtk-theme"
    
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    if ! package_is_installed "google-chrome-stable"; then
        add_repo "google-chrome.repo" \
                    "[google-chrome]" \
                    "name=google-chrome - \$basearch" \
                    "baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch" \
                    "enabled=1" \
                    "gpgcheck=1" \
                    "gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub" 
    fi
    install_package "Google Chrome" "google-chrome-stable"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "VirtualBox-5.1"; then
        execute "sudo dnf install -y binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms &> /dev/null" \
                "VirtualBox dependencies"
        add_repo_from_url "http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo"
    fi
    install_package "VirtualBox" "VirtualBox-5.1"
    execute "wget -O /tmp/Oracle_VM_VirtualBox_Extension_Pack-5.1.12-112440.vbox-extpack http://download.virtualbox.org/virtualbox/5.1.12/Oracle_VM_VirtualBox_Extension_Pack-5.1.12-112440.vbox-extpack \
            && sudo VBoxManage extpack install --replace /tmp/Oracle_VM_VirtualBox_Extension_Pack-5.1.12-112440.vbox-extpack \
            && rm -rf /tmp/Oracle_VM_VirtualBox_Extension_Pack-5.1.12-112440.vbox-extpack" \
            "VirtualBox extension pack"
    
    
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "insync"; then
        execute "sudo rpm --import https://d2t3ff60b2tol4.cloudfront.net/repomd.xml.key &> /dev/null" \
                "InSync GPG Key"

        add_repo "insync.repo" \
                    "[insync]" \
                    "name=insync repo" \
                    "baseurl=http://yum.insynchq.com/fedora/$releasever/" \
                    "gpgcheck=1" \
                    "gpgkey=https://d2t3ff60b2tol4.cloudfront.net/repomd.xml.key" \
                    "enabled=1" \
                    "metadata_expire=120m" 

    fi
    install_package "Insync" "insync"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    

    if ! package_is_installed "spotify-client"; then
        add_repo_from_url "http://negativo17.org/repos/fedora-spotify.repo"
    fi
    install_package "Spotify" "spotify-client"

    install_package "Transmission" "transmission"
    install_package "Remmina" "remmina"
    install_package "Remmina RDP plugin" "remmina-plugins-rdp"
    install_package "GIMP" "gimp"
    install_package "KODI" "kodi"
    install_package "KODI Event clients" "kodi-eventclients"
    install_package "Skype for linux" "https://repo.skype.com/latest/skypeforlinux-64-alpha.rpm"
    install_package "Sky (Skype for business)" "https://tel.red/linux.php?f=sky-2.1.6428-1.fc25.x86_64.rpm"    
    install_package "Facebook messenger" "https://github.com/Aluxian/Messenger-for-Desktop/releases/download/v2.0.4/messengerfordesktop-2.0.4-linux-x86_64.rpm"


    install_package "MySQL Repo" "https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-6.3.8-1.fc24.x86_64.rpm"
    install_package "MySQL Workbench" ""

}

install_dev_tools() {

    install_package "GIT" "git"
    install_package "GIT Extras" "git-extras"
    install_package "GIT Flow" "gitflow"

    if ! package_is_installed "docker-engine"; then
        add_repo "docker.repo" \
                    "[dockerrepo]" \
                    "name=Docker Repository" \
                    "baseurl=https://yum.dockerproject.org/repo/main/fedora/24/" \
                    "enabled=1" \
                    "gpgcheck=1" \
                    "gpgkey=https://yum.dockerproject.org/gpg" 
    fi
    install_package "Docker" "docker-engine"
    execute "sudo usermod -aG docker $(whoami)" \
            "Configure docker"
    execute "sudo curl -L 'https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)' -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose \
                && sudo curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose" \
            "Docker compose"

    execute "sudo rpm -i --replacepkgs https://go.microsoft.com/fwlink/?LinkID=760867" "VSCode"
}

#install_robomongo() {
#    declare -r TAR_GZ_URL="$1"
#
#    execute \
#        "sudo rm -rf /opt/robomongo && sudo mkdir -p /opt/robomongo && cd /opt/robomongo \
#            && sudo curl -L \"$TAR_GZ_URL\" | sudo tar -xz  --strip-components=1 \
#            && sudo rm -rf /opt/robomongo/bin/robomongo /usr/bin/robomongo \
#            && sudo ln -s /opt/robomongo/bin/robomongo /usr/bin/robomongo" \
#        "Robomongo"
#}


main() {

    print_in_purple "   update system\n\n"
    update
    upgrade
    printf "\n"

    print_in_purple "   common tools\n\n"
    install_common_tools
    printf "\n"

    print_in_purple "   dev tools\n\n"
    install_dev_tools
    printf "\n"

    print_in_purple "   apps\n\n"
    install_apps
    printf "\n"

    print_in_purple "   clean packages\n\n"
    autoremove

}

main
