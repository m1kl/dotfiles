#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" 

install_font_family() {
    declare -r FONT_NAME="$1"
    declare -r FONT_ZIP_URL="$2"

    execute \
        "mkdir -p ~/.fonts && rm -rf ~/.fonts/$FONT_NAME && cd ~/.fonts \
            && curl -sS $FONT_ZIP_URL > $FONT_NAME.zip \
            && unzip $FONT_NAME.zip \
            && rm $FONT_NAME.zip" \
        "$FONT_NAME"
}



install_font_family "ubuntu-font-family-0.83" "http://font.ubuntu.com/download/ubuntu-font-family-0.83.zip"