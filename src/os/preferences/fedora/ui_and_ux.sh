#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_evopop_theme() {
    execute \
        "mkdir -p ~/.themes && rm -rf ~/.themes/EvoPop \
            && git clone https://github.com/solus-project/evopop-gtk-theme.git /tmp/evopop-icons \
            && mv /tmp/evopop-icons/EvoPop ~/.themes \
            && rm -rf /tmp/evopop-icons" \
        "Install EvoPop theme"    
}

install_pocillo_icons() {
    execute \
        "sudo dnf config-manager -y --add-repo http://download.opensuse.org/repositories/home:snwh:moka/Fedora_25/home:snwh:moka.repo \
            && sudo dnf -y install moka-icon-theme" \
        "Install Moka icons"    

    execute \
        "mkdir -p ~/.icons && rm -rf ~/.icons/Pocillo \
            && git clone https://github.com/UbuntuBudgie/pocillo.git /tmp/pocillo-icons \
            && mv /tmp/pocillo-icons/Pocillo ~/.icons \
            && rm -rf /tmp/pocillo-icons" \
        "Install Pocillo icons"    
}

install_dmz_white_cursors() {
    execute \
        "mkdir -p ~/.icons && rm -rf ~/.icons/DMZ-* && cd ~/.icons \
            && curl https://dl.opendesktop.org/api/files/download/id/1460733789/159847-DMZ-White.tar.gz | tar xvz" \
        "Install DMZ White cursor theme"    
}


install_ubuntu_font_family() {
    declare -r FONT_NAME="ubuntu-font-family-0.83"
    declare -r FONT_ZIP_URL="http://font.ubuntu.com/download/ubuntu-font-family-0.83.zip"

    execute \
        "mkdir -p ~/.fonts && rm -rf ~/.fonts/$FONT_NAME && cd ~/.fonts \
            && curl -sS $FONT_ZIP_URL > $FONT_NAME.zip \
            && unzip $FONT_NAME.zip \
            && rm $FONT_NAME.zip" \
        "Install ubuntu font family"
}

install_gnome_shell_extension() {
    declare -r GNOME_VERSION="$1"
    declare -r EXT_ID="$2"
    declare -r EXT_NAME="$3"
    
    EXT_UUID=$(curl -s -L "https://extensions.gnome.org/extension-info/?pk=$EXT_ID&shell_version=$GNOME_VERSION" | grep -Po '(?<="uuid": ")[^"]*')
    EXT_DOWNLOAD_URL=$(curl -s -L "https://extensions.gnome.org/extension-info/?pk=$EXT_ID&shell_version=$GNOME_VERSION" | grep -Po '(?<="download_url": ")[^"]*')

    execute " \
        wget -O /tmp/extension.zip https://extensions.gnome.org$EXT_DOWNLOAD_URL \
        && rm -rf $HOME/.local/share/gnome-shell/extensions/$EXT_UUID \
        && mkdir -p $HOME/.local/share/gnome-shell/extensions/$EXT_UUID \
        && unzip /tmp/extension.zip -d $HOME/.local/share/gnome-shell/extensions/$EXT_UUID \
        && sudo cp $HOME/.local/share/gnome-shell/extensions/$EXT_UUID/schemas/*.xml 2>/dev/null || : \
            /usr/share/glib-2.0/schemas/ \
        && sudo glib-compile-schemas /usr/share/glib-2.0/schemas/" \
        "$EXT_NAME"
}

setup_personalization() {

    # Themes
    execute "gsettings set org.gnome.shell.extensions.user-theme name EvoPop" "Setup shell theme"
    execute "gsettings set org.gnome.desktop.interface gtk-theme EvoPop" "Setup gtk theme"
    execute "gsettings set org.gnome.desktop.interface cursor-theme DMZ-White" "Setup cursor theme"
    execute "gsettings set org.gnome.desktop.interface icon-theme Pocillo" "Setup icon theme"
    execute "gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'" "Setup button layout"
    execute "gsettings set org.gnome.desktop.wm.preferences theme 'EvoPop'" "Setup preferences theme"
    
    # Fonts
    execute "gsettings set org.gnome.desktop.interface font-name 'Ubuntu 11'" "Setup interface font"
    execute "gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace 12'" "Setup monospace font"
    execute "gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Ubuntu Medium 13'" "Setup title bar font"

    # Dates
    execute "gsettings set org.gnome.desktop.interface clock-show-date true" "Enable date on clock"
    execute "gsettings set org.gnome.desktop.calendar show-weekdate true" "Enable date on clock"

    # Keyboard shortcuts
    execute "gsettings set org.gnome.settings-daemon.plugins.media-keys www 'HomePage'" "Setup browser shortcut"
    execute "gsettings set org.gnome.settings-daemon.plugins.media-keys home '<Super>e'" "Setup explorer shortcut"
    execute "gsettings set org.gnome.desktop.wm.keybindings close \"['<Primary>q']\"" "Setup close window shortcut"
    execute "gsettings set org.gnome.desktop.wm.keybindings show-desktop \"['<Super>d']\"" "Setup show/hide desktop shortcut"
    execute "gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen \"['<Alt><Meta>Return']\"" "Setup toggle fullscreen shortcut"
    execute "gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ reset-and-clear '<Primary><Shift>r'" "Setup reset terminal shortcut"

    # Dash to dock extension
    execute "gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true"  "Setup dash to dock custom theme"
    execute "gsettings set org.gnome.shell.extensions.dash-to-dock preferred-monitor 0"   "Setup dash to dock preferred monitor"
    execute "gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'"  "Setup dash to dock position"
    execute "gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 56"  "Setup dash to dock icon size"
    execute "gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false"  "Setup dash to dock extend height"

    # Panel OSD extension
    execute "gsettings set org.gnome.shell.extensions.panel-osd x-pos 100.0" "Setup notfication position"
    
    # Clipboard indicator extension
    execute "gsettings set org.gnome.shell.extensions.clipboard-indicator notify-on-copy false" "Disable notify on copy"

    # Wallpapers
    execute "gsettings set org.gnome.desktop.screensaver picture-uri 'file:///$HOME/dotfiles/src/assets/screensaver-wallpaper.jpg'" "Setup screensaver wallpaper"
    execute "gsettings set org.gnome.desktop.background picture-uri 'file:///$HOME/dotfiles/src/assets/desktop-wallpaper.jpg'" "Setup desktop wallpaper"
    execute "gsettings set org.gnome.desktop.background show-desktop-icons false" "Hide desktop icons"
    execute "gsettings set org.gnome.desktop.background picture-options 'stretched'" "Set desktop background image options"

    # Touchpad
    execute "gsettings set org.gnome.desktop.peripherals.touchpad click-method 'default'" "Setup touchpad click method"
    execute "gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true" "Setup natural scrolling"
    execute "gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true" "Setup touchpad tap to click"

    # Terminal
# [org/gnome/terminal/legacy/profiles:]
# list=['6dfeaf59-8026-414f-b489-3b2161b6c24d', '767ea6a3-edb1-4a3d-87c4-26232bfa3e20', 'c09e39de-fd1f-4673-89c3-eb3be9dcd3fc', 'c03facda-6560-4f08-9b20-2f71b4aa1794']
# default='6dfeaf59-8026-414f-b489-3b2161b6c24d'

# [org/gnome/terminal/legacy/profiles:/:6dfeaf59-8026-414f-b489-3b2161b6c24d]
# foreground-color='#f2f2f2f2f2f2'
# visible-name='Default'
# palette=['rgb(0,0,0)', 'rgb(205,0,0)', 'rgb(0,205,0)', 'rgb(205,205,0)', 'rgb(0,0,238)', 'rgb(205,0,205)', 'rgb(0,205,205)', 'rgb(229,229,229)', 'rgb(127,127,127)', 'rgb(255,0,0)', 'rgb(0,255,0)', 'rgb(255,255,0)', 'rgb(92,92,255)', 'rgb(255,0,255)', 'rgb(0,255,255)', 'rgb(255,255,255)']
# use-transparent-background=true
# use-theme-colors=false
# use-theme-background=false
# bold-color-same-as-fg=true
# bold-color='#f2f2f2f2f2f2'
# background-color='rgb(49,54,61)'
# background-transparency-percent=4

# [org/gnome/terminal/legacy]
# schema-version=uint32 3
# default-show-menubar=false

}


print_in_purple "\n   UI & UX\n\n"

ask_for_sudo
print_in_purple "\n • Install themes\n\n"
install_evopop_theme
install_pocillo_icons
install_dmz_white_cursors
install_ubuntu_font_family

print_in_purple "\n • Install shell extensions\n\n"
install_gnome_shell_extension 3.22 "779" "Clipboard indicator"
install_gnome_shell_extension 3.22 "307" "Dash to Dock"
install_gnome_shell_extension 3.22 "1011" "Dynamic Panel Transparency"
install_gnome_shell_extension 3.22 "690" "Easy Screen Cast"
install_gnome_shell_extension 3.22 "708" "Panel OSD"
install_gnome_shell_extension 3.22 "7" "Removable Drive Menu"
install_gnome_shell_extension 3.22 "1031" "TopIcons Plus"

execute "gsettings set org.gnome.shell enabled-extensions \
    \"[ \
        'background-logo@fedorahosted.org', \
        'dash-to-dock@micxgx.gmail.com', \
        'clipboard-indicator@tudmotu.com', \
        'user-theme@gnome-shell-extensions.gcampax.github.com', \
        'EasyScreenCast@iacopodeenosee.gmail.com', \
        'drive-menu@gnome-shell-extensions.gcampax.github.com', \
        'dynamic-panel-transparency@rockon999.github.io', \
        'panel-osd@berend.de.schouwer.gmail.com', \
        'TopIcons@phocean.net' \
    \"]" \
    "Enable extensions"



print_in_purple "\n • Setup personalization\n\n"
setup_personalization

