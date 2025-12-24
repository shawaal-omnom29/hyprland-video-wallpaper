#!/usr/bin/env fish

# Colors
set GREEN (set_color green)
set YELLOW (set_color yellow)
set RED (set_color red)
set NC (set_color normal)

echo -e "$GREEN=== Starting Workspace Video Wallpaper Setup (Fish Edition) ===$NC"

# --- 1. INSTALL DEPENDENCIES ---
echo -e "$YELLOW[1/5] Checking dependencies...$NC"

if not type -q socat
    echo "Installing socat..."
    sudo pacman -S --noconfirm socat
end

if not type -q mpvpaper
    echo "mpvpaper not found. Installing via AUR helper..."
    if type -q yay
        yay -S --noconfirm mpvpaper
    else if type -q paru
        paru -S --noconfirm mpvpaper
    else
        echo -e "$REDError: Neither 'yay' nor 'paru' found. Install 'mpvpaper' manually.$NC"
        exit 1
    end
else
    echo "mpvpaper is already installed."
end

# --- 2. CLEAN UP OLD CONFIGS ---
echo -e "$YELLOW[2/5] Disabling conflicting wallpaper scripts...$NC"

set CONFLICT_SCRIPT "$HOME/.config/hypr/scripts/workspacewall.sh"
if test -f "$CONFLICT_SCRIPT"
    echo "Backing up workspacewall.sh..."
    mv "$CONFLICT_SCRIPT" "$CONFLICT_SCRIPT.bak_"(date +%s)
end

killall swww-daemon 2>/dev/null
killall mpvpaper 2>/dev/null

set EXECS_CONF "$HOME/.config/hypr/hyprland/execs.conf"
if test -f "$EXECS_CONF"
    # Comment out old bash scripts and swww
    sed -i 's|^exec-once = ~/.config/hypr/custom/scripts/__restore_video_wallpaper.sh|# exec-once = ...|g' "$EXECS_CONF"
    sed -i 's|^exec-once = swww|# exec-once = swww|g' "$EXECS_CONF"
else
    echo -e "$REDWarning: Could not find $EXECS_CONF.$NC"
end

# --- 3. CREATE DIRECTORIES ---
echo -e "$YELLOW[3/5] Creating directories...$NC"
mkdir -p "$HOME/.config/hypr/wallpapers"
mkdir -p "$HOME/.config/hypr/scripts"

# --- 4. GENERATE THE WALLPAPER SCRIPT (IN FISH) ---
echo -e "$YELLOW[4/5] Generating video_wallpaper.fish...$NC"
set SCRIPT_PATH "$HOME/.config/hypr/scripts/video_wallpaper.fish"

# We write the inner script content
echo '#!/usr/bin/env fish

# --- CONFIGURATION ---
set VIDEO_DIR "$HOME/.config/hypr/wallpapers"
set SOCKET "/tmp/mpvpaper_socket"

# 1. Cleanup
killall mpvpaper 2>/dev/null
rm -f "$SOCKET"

# 2. Start mpvpaper (Safe Mode: CPU decoding)
# The "&" in fish sends to background
mpvpaper "*" -o "--no-config hwdec=no --no-audio --loop-playlist --input-ipc-server=$SOCKET" "$VIDEO_DIR/1.mp4" &

sleep 0.5

# 3. Handle Workspace Changes
function handle_event
    switch $argv[1]
        case "workspace*"
            # Extract workspace ID (e.g. "workspace>>1" -> "1")
            set ws_id (string split ">>" $argv[1])[2]
            set next_video "$VIDEO_DIR/$ws_id.mp4"
            
            if test -f "$next_video"
                echo "loadfile \"$next_video\"" | socat - "$SOCKET"
            end
    end
end

# Listen to socket
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -l line
    handle_event "$line"
end
' > "$SCRIPT_PATH"

chmod +x "$SCRIPT_PATH"

# --- 5. UPDATE HYPRLAND CONFIG ---
echo -e "$YELLOW[5/5] Adding to startup config...$NC"

if not grep -q "video_wallpaper.fish" "$EXECS_CONF"
    echo "" >> "$EXECS_CONF"
    echo "# Custom Video Wallpaper (Fish)" >> "$EXECS_CONF"
    echo "exec-once = $SCRIPT_PATH" >> "$EXECS_CONF"
end

echo -e "$GREEN=== Installation Complete! ===$NC"
echo "Please restart Hyprland to finish."
