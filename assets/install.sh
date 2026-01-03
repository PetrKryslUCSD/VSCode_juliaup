#

# Installation script for portable Julia with VS Code
# version 1.1 (C) 2022-2024, Petr Krysl

# Further configuration options for VS Code:
# {
#    "key": "ctrl+c",
#    "command": "workbench.action.terminal.copySelection",
#    "when": "terminalFocus && terminalProcessSupported && terminalTextSelected"
# },
# {
#    "key": "ctrl+v",
#    "command": "workbench.action.terminal.paste",
#    "when": "terminalFocus && terminalProcessSupported"
# },
# and make sure that this setting is an effect
# {
#     "terminal.integrated.allowChords": false
# }
# To set the window title:
# "window.title": "${activeEditorShort}${separator}${rootName}${separator}${profileName}${separator}focus:[${focusedView}]",

set -o errexit 
set -o nounset

# Add the Git binary
export PATH="$(pwd)"/assets/PortableGit/bin:$PATH

if [ ! -x "$(pwd)"/assets/VSCode/Code ] ; then
    VSCodeVersion="VSCode.zip"
    if [ ! -d assets/VSCode ] ; then
        mkdir assets/VSCode
    fi
    if [ ! -f assets/"$VSCodeVersion" ] ; then
        echo "Downloading VSCode "
        curl "https://update.code.visualstudio.com/latest/win32-x64-archive/stable" --output assets/vscode.redirect
        download_link=$(cat assets/vscode.redirect | cut -d" " -f4)
        curl "$download_link" --output assets/"$VSCodeVersion"
    fi
    echo "Expanding $VSCodeVersion"
    unzip -q "assets/$VSCodeVersion" -d assets/VSCode
    # unzip -q "assets/data.zip" -d assets/
    # mv assets/data assets/VSCode
else
    echo "Found VSCode"
fi

# Install required extensions
if [ ! -f assets/firsttimedone ] ; then
    if [ ! -d assets/VSCode/data ] ; then
	mkdir assets/VSCode/data
    fi
    assets/VSCode/bin/code --install-extension alefragnani.Bookmarks --force
    assets/VSCode/bin/code --install-extension julialang.language-julia --force
    assets/VSCode/bin/code --install-extension kaiwood.center-editor-window --force
    #assets/VSCode/bin/code --install-extension stkb.rewrap --force
    assets/VSCode/bin/code --install-extension yeannylam.recenter-top-bottom --force
    assets/VSCode/bin/code --install-extension nemesv.copy-file-name --force
    assets/VSCode/bin/code --install-extension PKief.material-icon-theme --force
    assets/VSCode/bin/code --install-extension johnpapa.vscode-peacock --force
    assets/VSCode/bin/code --install-extension chunsen.bracket-select --force
    touch assets/firsttimedone
fi

# Start VS Code
echo "Starting editor"
assets/VSCode/Code 
