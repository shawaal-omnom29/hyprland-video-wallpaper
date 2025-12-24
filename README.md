# 🎥 Hyprland Video Wallpaper

<div align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Fish_shell_logo_ascii.svg/1200px-Fish_shell_logo_ascii.svg.png" width="120" />
  <br/>
  <b><i>Bring your workspaces to life.</i></b>
  <br/>
  <br/>

  ![Language](https://img.shields.io/badge/Language-Fish_Shell-blue?style=for-the-badge&logo=gnu-bash)
  ![WM](https://img.shields.io/badge/WM-Hyprland-important?style=for-the-badge&logo=arch-linux)
  ![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
</div>

---

## ⚡ Features

| Feature | Description |
| :--- | :--- |
| **🚀 Zero Lag** | Uses \`hwdec=no\` to prevent \`libcuda\` crashes on AMD/Nvidia. |
| **🐟 Pure Fish** | Written entirely in Fish. No Bash dependencies. |
| **🧹 Auto-Clean** | Automatically disables conflicting scripts (End-4 dotfiles). |
| **🧠 Smart** | Listens to socket events for instant switching. |

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
Drop your \`.mp4\` files into the config folder.
> **Path:** \`~/.config/hypr/wallpapers/\`

**Naming Convention:**
* Workspace 1 → \`1.mp4\`
* Workspace 2 → \`2.mp4\`

### 3. Restart Hyprland
Logout and log back in.

---
<div align="center">
  <i>Powered by <a href="https://github.com/GhostNaN/mpvpaper">mpvpaper</a></i>
</div>
