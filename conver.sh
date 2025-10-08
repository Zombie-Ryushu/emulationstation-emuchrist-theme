#!/bin/bash

# Source color (dark blue from original)
SOURCE_R=62
SOURCE_G=45
SOURCE_B=114

# System colors from logos
declare -A SYSTEM_COLORS=(
    ["nes"]="255,0,0"            # Pure red (completed)
    ["snes"]="255,255,255"       # SNES white (updated)
    ["3do"]="116,207,68"         # 3DO green
    ["amiga"]="255,255,255"      # Amiga white
    ["amigacd32"]="255,0,31"     # Amiga CD32 red
    ["amstradcpc"]="184,38,101"  # Amstrad CPC pink/magenta
    ["apple2gs"]="199,165,39"    # Apple IIGS gold/orange
    ["arcade"]="29,50,201"       # Arcade blue
    ["atari2600"]="128,226,55"   # Atari 2600 green
    ["atari5200"]="127,225,54"   # Atari 5200 green (almost same)
    ["atari7800"]="128,226,55"   # Atari 7800 green
    ["atari800"]="93,54,21"      # Atari 800 brown
    ["atarifalcon"]="114,114,126"# Atari Falcon gray
    ["atarijaguar"]="221,25,3"   # Atari Jaguar red
    ["atarilynx"]="240,196,47"   # Atari Lynx yellow/gold
    ["atarist"]="90,119,195"     # Atari ST blue
    ["c128"]="61,60,140"         # Commodore 128 purple
    ["c64"]="61,60,140"          # Commodore 64 purple
    ["colecovision"]="221,77,126"# Colecovision pink
    ["desktop"]="252,93,28"      # Linux Desktop shortcuts orange
    ["dos"]="13,236,0"           # DOS green
    ["dreamcast"]="221,63,62"    # Dreamcast red/orange
    ["gb"]="255,255,255"         # Game Boy white
    ["gbc"]="90,65,131"          # Game Boy Color purple
    ["gba"]="74,20,160"          # Game Boy Advance purple
    ["gc"]="102,82,169"          # GameCube purple
    ["genesis"]="255,255,255"    # Genesis/Mega Drive white
    ["intellivision"]="101,101,251" # Intellivision blue
    ["kodi"]="94,176,232"        # Kodi light blue
    ["gamegear"]="255,255,255"   # Game Gear white
    ["mastersystem"]="50,53,134" # Master System blue
    ["megadriveplus"]="255,255,255" # Mega Drive Plus white
    ["msx"]="93,164,252"         # MSX light blue
    ["msx2"]="92,163,251"        # MSX2 light blue
    ["n64"]="100,175,168"        # N64 teal/aqua
    ["nds"]="185,185,185"        # Nintendo DS gray
    ["ngp"]="255,255,255"        # Neo Geo Pocket white
    ["ngpc"]="220,59,90"         # Neo Geo Pocket Color red/pink
    ["openbor"]="255,19,29"      # OpenBOR red
    ["pc88"]="255,255,255"       # NEC PC-8801 white
    ["pc98"]="254,31,32"         # NEC PC-9801 red
    ["pcengine"]="221,65,14"     # PC Engine orange
    ["pcenginecd"]="255,64,0"    # PC Engine CD orange
    ["pcfx"]="0,0,90"            # PC-FX dark blue
    ["ps2"]="22,118,156"         # PlayStation 2 blue
    ["ps3"]="93,93,93"           # PlayStation 3 gray
    ["psx"]="219,9,46"           # PlayStation red
    ["psp"]="157,157,157"        # PSP gray
    ["quake"]="107,33,37"        # Quake dark red/brown
    ["saturn"]="54,95,159"       # Saturn blue
    ["sega32x"]="54,95,159"      # Sega 32X blue
    ["segacd"]="121,121,121"     # Sega CD gray
    ["sg-1000"]="34,41,171"      # SG-1000 blue
    ["sgb"]="89,67,132"          # Super Game Boy purple
    ["supergrafx"]="0,144,170"   # SuperGrafx cyan
    ["wii"]="79,195,255"         # Wii light blue
    ["windows"]="156,5,0"        # Windows red
    ["wonderswan"]="119,119,119" # WonderSwan gray
    ["wonderswancolor"]="218,11,17" # WonderSwanColor red
    ["x68000"]="179,132,40"      # X68000 brown/gold
    # Still missing (if you have them)
    ["megadrive"]=""         # 
    ["neogeo"]=""            #
)

BASE_DIR=~/ES-DE/themes/emuchrist

# Counter for processed systems
processed=0

# Process only systems with defined colors
for system in "${!SYSTEM_COLORS[@]}"; do
    if [[ -n "${SYSTEM_COLORS[$system]}" ]]; then  # Only process if color is defined
        IFS=',' read -r r g b <<< "${SYSTEM_COLORS[$system]}"
        cd "$BASE_DIR/$system" 2>/dev/null || continue
        
        for file in screenshot-*.png gamelist-*.png; do
            if [ -f "$file" ]; then
                convert "$file" \
                    -fuzz 0% \
                    -fill "rgb($r,$g,$b)" \
                    -opaque "rgb($SOURCE_R,$SOURCE_G,$SOURCE_B)" \
                    "$file.new" && mv "$file.new" "$file"
                echo "Changed $system/$file to RGB($r,$g,$b)"
            fi
        done
        ((processed++))
    fi
done

echo "Processed $processed systems with defined colors"
