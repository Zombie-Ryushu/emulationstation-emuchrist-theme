# Navigate to NES folder
cd ~/ES-DE/themes/emuchrist/nes

# Test command - creates a new file first
convert screenshot-nes.png \
    -fuzz 1% \
    -fill "rgb(255,0,0)" \
    -opaque "rgb(62,45,114)" \
    screenshot-nes-test.png