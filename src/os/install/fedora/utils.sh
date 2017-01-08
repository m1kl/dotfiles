#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_key() {
    # wget -qO - "$1" | sudo apt-key add - &> /dev/null
    #     │└─ write output to file
    #     └─ don't show output
    true
}

add_key_by_param() {
    #sudo apt-key adv --keyserver "$1" --recv-keys "$2" &> /dev/null
    true
}


add_repo() {
    declare -r REPO_NAME="$1"
    sudo sh -c "rm -rf '/etc/yum.repos.d/$REPO_NAME'"
    for ARG in "${@:2}"; do
        sudo sh -c "echo '$ARG' >> '/etc/yum.repos.d/$REPO_NAME'"
    done        
}

add_repo_from_url() {
    declare -r REPO_URL="$1"
    sudo sh -c "dnf -y config-manager --add-repo=$REPO_URL &> /dev/null"
    #sudo wget "$REPO_URL" -O "/etc/yum.repos.d/$REPO_NAME"  &> /dev/null
}

autoremove() {

    # Remove packages that were automatically installed to satisfy
    # dependencies for other packages and are no longer needed.

    execute \
        "sudo dnf autoremove -y" \
        "DNF (autoremove)"

}

install_package() {

    declare -r PACKAGE="$2"
    declare -r PACKAGE_READABLE_NAME="$1"

    if ! package_is_installed "$PACKAGE"; then
        execute "sudo dnf -y  --nogpgcheck  install $PACKAGE" "$PACKAGE_READABLE_NAME"
    else
        print_success "$PACKAGE_READABLE_NAME"
    fi

}

install_from_remote_rpm() {
    declare -r URL="$2"
    declare -r PACKAGE_READABLE_NAME="$1"
    declare -r FILE="$(mktemp)"
    #execute "wget \"$URL\" -qO \"$FILE\" && sudo dpkg -i \"$FILE\"; rm \"$FILE\"" "$PACKAGE_READABLE_NAME"
}

package_is_installed() {
    if dnf -y list installed "$1" >/dev/null 2>&1; then
        true
    else
        false
    fi
}

update() {

    # Resynchronize the package index files from their sources.

    # execute \
      #  "sudo dnf check-update" \
       #  "DNF (check-update)"
    true

}

upgrade() {

    # Install the newest versions of all packages installed.

    execute \
        "sudo dnf -y upgrade" \
        "DNF (upgrade)"
}
