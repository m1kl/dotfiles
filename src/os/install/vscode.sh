#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_vscode_extension() {

    execute \
        "code --install-extension $2" \
        "$1"

}

install_common_extensions() {
    install_vscode_extension "Docker support" "PeterJausovec.vscode-docker"
    install_vscode_extension "Gitflow support" "vector-of-bool.gitflow"
    install_vscode_extension "Colors" "anseki.vscode-color"
    install_vscode_extension "Prettify json" "mohsen1.prettify-json"
    install_vscode_extension "Editor config" "EditorConfig.EditorConfig"
    install_vscode_extension "Trailing spaces" "shardulm94.trailing-spaces"
    install_vscode_extension "VScode icons" "robertohuertasm.vscode-icons"
}

install_php_extensions() {
    install_vscode_extension "PHP Intellisense - Crane"     "HvyIndustries.crane"
    install_vscode_extension "PHP Formatter (PSR2)"         "Sophisticode.php-formatter"
    install_vscode_extension "PHP Debug (XDEBUG)"           "felixfbecker.php-debug"
    install_vscode_extension "PHP Code Sniffer"             "ikappas.phpcs"
    install_vscode_extension "Composer"                     "ikappas.composer"
}

install_web_extensions() {
    install_vscode_extension "SVG Viewer"     "cssho.vscode-svgviewer"
    install_vscode_extension "Typescript linter"        "eg2.tslint"
    install_vscode_extension "Typescript auto import"   "steoates.autoimport"
    install_vscode_extension "Angular 2 Snippets"       "johnpapa.Angular2"
    install_vscode_extension "Document this" "joelday.docthis"
    install_vscode_extension "SASS Indented" "robinbentley.sass-indented"
    install_vscode_extension "NPM Commands" "fknop.vscode-npm"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   vscode extensions\n\n"
    install_common_extensions
    install_php_extensions
    install_web_extensions
    printf "\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



}

main
