#!/bin/bash

BASE_DIR=~/ES-DE/themes/emuchrist
cd "$BASE_DIR" || exit 1

for dir in */; do
    if [ "$dir" != "solarus/" ]; then
        # Remove trailing slash from directory name
        system_name="${dir%/}"
        
        # Copy and rename files
        if [ -f "solarus/screenshot-solarus.png" ]; then
            cp "solarus/screenshot-solarus.png" "${dir}screenshot-${system_name}.png"
            echo "Created screenshot-${system_name}.png in $dir"
        fi
        
        if [ -f "solarus/gamelist-solarus.png" ]; then
            cp "solarus/gamelist-solarus.png" "${dir}gamelist-${system_name}.png"
            echo "Created gamelist-${system_name}.png in $dir"
        fi
    fi
done