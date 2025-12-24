#!/usr/bin/env fish

# Colors
set GREEN (set_color green)
set YELLOW (set_color yellow)
set NC (set_color normal)

echo -e "$GREEN=== Starting Workspace Video Wallpaper Setup ===$NC"

# 1. Install Dependencies
if not type -q socat; sudo pacman -S --noconfirm socat; end
if not type -q mpvpaper; yay -S --noconfirm mpvpaper; end

# 2. Generate Daemon
mkdir -p ~/.config/hypr/scripts ~/.config/hypr/wallpapers
set SCRIPT_PATH "$HOME/.config/hypr/scripts/video_wallpaper.fish"
echo '#!/usr/bin/env fish
set VIDEO_DIR "$HOME/.config/hypr/wallpapers"
set SOCKET "/tmp/mpvpaper_socket"
killall mpvpaper 2>/dev/null; rm -f "$SOCKET"
mpvpaper "*" -o "--no-config hwdec=no --no-audio --loop-playlist --input-ipc-server=$SOCKET" "$VIDEO_DIR/1.mp4" &
sleep 0.5
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -l line
  switch $line
    case "workspace*"
      set ws_id (string split ">>" $line)[2]
      if test -f "$VIDEO_DIR/$ws_id.mp4"
        echo "loadfile "$VIDEO_DIR/$ws_id.mp4"" | socat - "$SOCKET"
      end
  end
end' > $SCRIPT_PATH
chmod +x $SCRIPT_PATH

# 3. Add to Config
if not grep -q "video_wallpaper.fish" ~/.config/hypr/hyprland/execs.conf
  echo "exec-once = $SCRIPT_PATH" >> ~/.config/hypr/hyprland/execs.conf
end
echo -e "$GREEN=== Done! Restart Hyprland. ===$NC"