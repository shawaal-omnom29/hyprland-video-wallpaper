# 🎥 Hyprland Video Wallpaper

![Shell Script](https://img.shields.io/badge/Language-Fish_Shell-blue?style=for-the-badge&logo=gnu-bash)
![Hyprland](https://img.shields.io/badge/WM-Hyprland-important?style=for-the-badge&logo=arch-linux)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

> **Ditch the static images.** Bring your workspaces to life with performance-optimized video wallpapers that switch automatically as you navigate.

## ⚡ Why this rocks
* **🚀 Zero Lag:** Uses \`mpvpaper\` with hardware-safe flags (\`hwdec=no\`) so your GPU doesn't melt or crash \`libcuda\`.
* **🐟 Pure Fish:** Written entirely in native Fish shell. No Bash wrappers.
* **🧠 Smart Switching:** Detects workspace changes instantly via socket listening.
* **🧹 Auto-Cleanup:** Automatically nukes conflicting wallpaper scripts (like those found in End-4 dotfiles).

---

## 🛠️ Installation

### 1. Clone & Install
\`\`\`fish
git clone https://github.com/shawaal-omnom29/hyprland-video-wallpaper.git
cd hyprland-video-wallpaper
chmod +x install.fish
./install.fish
\`\`\`

### 2. Add your Videos
Drop your \`.mp4\` files into \`~/.config/hypr/wallpapers/\`.
**Naming matters:**
* Workspace 1 -> \`1.mp4\`
* Workspace 2 -> \`2.mp4\`
* ...and so on.

### 3. Restart & Enjoy
Logout of Hyprland and log back in. Your desktop is now alive.

---
*Created by [Shawaal](https://github.com/shawaal-omnom29)*
