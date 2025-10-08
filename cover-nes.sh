#!/bin/bash

# Function to convert RGB to hex
rgb_to_hex() {
    printf "%02X%02X%02X" $1 $2 $3
}

# Test with NES first
system="nes"
r=255; g=0; b=0
hex_color=$(rgb_to_hex $r $g $b)  # Results in FF0000

BASE_DIR=~/ES-DE/themes/emuchrist

# Copy solarus theme.xml as template
cp "$BASE_DIR/solarus/theme.xml" "$BASE_DIR/$system/theme.xml.new"

# Determine logo file for NES
system_dir="$BASE_DIR/$system"
if [ -f "$system_dir/${system}.svg" ]; then
    logo_file="${system}.svg"
elif [ -f "$system_dir/logo.png" ]; then
    logo_file="logo.png"
elif [ -f "$system_dir/${system}.png" ]; then
    logo_file="${system}.png"
else
    logo_file="${system}.svg"  # Default fallback
fi

# Update the new theme.xml
sed -i "s/<themeColor>.*<\/themeColor>/<themeColor>$hex_color<\/themeColor>/" "$BASE_DIR/$system/theme.xml.new"
sed -i "s|<path>\.\/solarus\.svg</path>|<path>./$logo_file</path>|g" "$BASE_DIR/$system/theme.xml.new"
sed -i "s/gamelist-solarus\.png/gamelist-${system}.png/g" "$BASE_DIR/$system/theme.xml.new"
sed -i "s/screenshot-solarus\.png/screenshot-${system}.png/g" "$BASE_DIR/$system/theme.xml.new"

echo "Created new theme.xml for $system"
echo "Compare the files:"
echo "  Original: $BASE_DIR/$system/theme.xml"
echo "  New:      $BASE_DIR/$system/theme.xml.new"
echo ""
echo "If it looks good, run:"
echo "  mv $BASE_DIR/$system/theme.xml $BASE_DIR/$system/theme.xml.old"
echo "  mv $BASE_DIR/$system/theme.xml.new $BASE_DIR/$system/theme.xml"