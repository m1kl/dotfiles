#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_evopop_theme() {
    execute \
        "mkdir -p ~/.themes && rm -rf ~/.themes/EvoPop \
            && git clone https://github.com/solus-project/evopop-gtk-theme.git ~/.themes/EvoPop" \
        "EvoPop theme"    
}

install_moka_icons() {
    execute \
        "sudo dnf config-manager -y --add-repo http://download.opensuse.org/repositories/home:snwh:moka/Fedora_25/home:snwh:moka.repo \
            && sudo dnf -y install moka-icon-theme" \
        "Moka icons"    
}

install_pocillo_icons() {
    execute \
        "mkdir -p ~/.icons && rm -rf ~/.icons/Pocillo \
            && git clone https://github.com/UbuntuBudgie/pocillo.git /tmp/pocillo-icons \
            && mv /tmp/pocillo-icons/Pocillo ~/.icons \
            && rm -rf /tmp/pocillo-icons" \
        "Pocillo icons"    
}

install_dmz_white_cursors() {
    execute \
        "mkdir -p ~/.icons && rm -rf ~/.icons/DMZ-White \
            && git clone https://github.com/GalliumOS/dmz-cursor-theme.git /tmp/dmz-theme \
            && mv /tmp/dmz-theme/DMZ-White ~/.icons \
            && rm -rf /tmp/dmz-theme" \
        "DMZ White cursor theme"    
}


print_in_purple "\n   UI & UX\n\n"

install_evopop_theme
#install_moka_icons
install_pocillo_icons
install_dmz_white_cursors



# Install Moka+Pocillo Icons
# Install DMZ White icon theme
# Install Evopop gtk and shell theme




# Install gnome extensions:
# - Dash to icons
# - ....




#execute "gsettings set com.canonical.indicator.bluetooth visible false" \
 #   "Hide bluetooth icon from the menu bar"

#execute "gsettings set com.canonical.indicator.sound visible false" \
 #   "Hide volume icon from the menu bar"

#execute "gsettings set com.canonical.indicator.power icon-policy 'charge' && \
 #        gsettings set com.canonical.indicator.power show-time false" \
#    "Hide battery icon from the menu bar when the battery is not in use"

#execute "gsettings set com.canonical.indicator.datetime custom-time-format '%l:%M %p' && \
 #        gsettings set com.canonical.indicator.datetime time-format 'custom'" \
  #  "Use custom date format in the menu bar"

execute "gsettings set org.gnome.desktop.background picture-options 'stretched'" \
    "Set desktop background image options"

#execute "gsettings set org.gnome.libgnomekbd.keyboard layouts \"[ 'us', 'ro' ]\"" \
 #   "Set keyboard languages"

#execute "gsettings set com.canonical.Unity.Launcher favorites \"[
 #           'ubiquity-gtkui.desktop',
  #          'nautilus-home.desktop'
   #      ]\"" \
   # "Set Launcher favorites"
