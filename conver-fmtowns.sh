#!/bin/bash

# Function to convert RGB to hex
rgb_to_hex() {
    printf "%02X%02X%02X" $1 $2 $3
}

# FM Towns specific settings
system="fmtowns"
r=0; g=156; b=115
hex_color=$(rgb_to_hex $r $g $b)  # Results in 009C73

BASE_DIR=~/ES-DE/themes/emuchrist

# Create system directory if it doesn't exist
mkdir -p "$BASE_DIR/$system"

# Copy solarus theme.xml as template
cp "$BASE_DIR/solarus/theme.xml" "$BASE_DIR/$system/theme.xml"

# Determine logo file for FM Towns
system_dir="$BASE_DIR/$system"
if [ -f "$system_dir/${system}.svg" ]; then
    logo_file="${system}.svg"
elif [ -f "$system_dir/logo.png" ]; then
    logo_file="logo.png"
elif [ -f "$system_dir/${system}.png" ]; then
    logo_file="${system}.png"
else
    logo_file="${system}.svg"  # Default fallback
    echo "Warning: No logo file found for $system"
fi

# Update the theme.xml with all replacements
sed -i "s/<themeColor>.*<\/themeColor>/<themeColor>$hex_color<\/themeColor>/" "$system_dir/theme.xml"
sed -i "s|<path>\.\/solarus\.svg</path>|<path>./$logo_file</path>|g" "$system_dir/theme.xml"
sed -i "s|<path>\.\/main\.png</path>|<path>../art/system_background.png</path>|" "$system_dir/theme.xml"
sed -i "s/gamelist-solarus\.png/gamelist-${system}.png/g" "$system_dir/theme.xml"
sed -i "s/screenshot-solarus\.png/screenshot-${system}.png/g" "$system_dir/theme.xml"
sed -i "s/favorites-solarus\.png/favorites-${system}.png/g" "$system_dir/theme.xml"

echo "Created theme.xml for FM Towns with color #$hex_color"
echo "Logo file: $logo_file"

# Also create the colored overlay images if they don't exist
if [ -f "$BASE_DIR/solarus/gamelist-solarus.png" ]; then
    cp "$BASE_DIR/solarus/gamelist-solarus.png" "$system_dir/gamelist-${system}.png"
    cp "$BASE_DIR/solarus/screenshot-solarus.png" "$system_dir/screenshot-${system}.png"
    cp "$BASE_DIR/solarus/favorites-solarus.png" "$system_dir/favorites-${system}.png"
    
    # Apply color transformation
    for file in gamelist-${system}.png screenshot-${system}.png favorites-${system}.png; do
        if [ -f "$system_dir/$file" ]; then
            convert "$system_dir/$file" \
                -fuzz 0% \
                -fill "rgb($r,$g,$b)" \
                -opaque "rgb(62,45,114)" \
                "$system_dir/$file"
            echo "Colorized $file"
        fi
    done
fi

echo "FM Towns theme setup complete!"