#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_vscode_extension() {

    execute \
        "code --install-extension $2" \
        "$1"

}

install_images_extensions() {
    install_vscode_extension "SVG Viewer"     "cssho.vscode-svgviewer"
}

install_php_extensions() {
    install_vscode_extension "PHP Intellisense - Crane"     "HvyIndustries.crane"
    install_vscode_extension "PHP Formatter (PSR2)"         "Sophisticode.php-formatter"
    install_vscode_extension "PHP Debug (XDEBUG)"           "felixfbecker.php-debug"
    install_vscode_extension "PHP Code Sniffer"             "ikappas.phpcs"
    install_vscode_extension "Composer"                     "ikappas.composer"
}

install_typescript_extensions() {
    install_vscode_extension "Typescript linter"        "eg2.tslint"
    install_vscode_extension "Typescript auto import"   "steoates.autoimport"
    install_vscode_extension "Angular 2 Snippets"       "johnpapa.Angular2"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   vscode extensions\n\n"
    install_images_extensions
    install_php_extensions
    install_typescript_extensions
    printf "\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    
    
}

main
