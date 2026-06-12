<div align="center">

<img src="https://files.facepunch.com/lewis/1b2911b1/rust-marque.svg" width="50"/>
&nbsp;
<img src="https://ren.animex.net.tr/emoji/3194-steamhappy.png" width="50"/>

## Rust Server Installers For Windows 10+ and Linux

<img src="https://avatars.githubusercontent.com/0-renn" width="60"/>  <img src="https://avatars.githubusercontent.com/ErcanDinsel" width="60"/>

&nbsp;&nbsp; **Me** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **Buddy**

&nbsp;&nbsp;[![Discord](https://img.shields.io/badge/Discord-Profile-5865F2?logo=discord&logoColor=white)](https://discord.com/users/822045780499628042)  &
[![Discord](https://img.shields.io/badge/Discord-Join-5865F2?logo=discord&logoColor=white)](https://discord.gg/erGHBeFxAm)

</div>
            
## English

### Overview
These scripts install a **Rust dedicated server** on either **Windows 10+** or **Linux** using a single file. They automate SteamCMD deployment, server configuration, plugin frameworks, and management scripts.

### Windows Version

#### System Requirements (Windows)
- Windows 10 / Windows 11 / Windows Server 2016 or later.  
- Windows Defender is fine; some antivirus may block the script – temporarily disable if issues occur.  
- **Not for Linux** – use the Linux version below.

#### Installation (Windows)
1. Download `rustserverinstaller.bat` from **[rustserverinstaller.bat](https://github.com/0-renn/rustserverinstaller/releases/download/V1/rust_server_setup_windows.bat)**.
2. Run the file **as Administrator**.
3. Follow the on‑screen prompts (branch, plugins, map options, etc.).
4. After installation, start the server using `StartServer.bat`.

#### Features (Windows)
- ✅ SteamCMD automatic installation  
- ✅ Official or staging branch  
- ✅ Custom maps (RustEdit.dll support)  
- ✅ Oxide or Carbon plugin framework (Oxide not for staging)  
- ✅ Admin user setup  
- ✅ Generates `StartServer.bat`, `UpdateServer.bat`, `WipeServer.bat`

---

### Linux Version

#### System Requirements (Linux)
- Ubuntu 20.04 / Debian 11 / CentOS 8 or newer (other distros may work).  
- Dependencies: `wget`, `unzip`, `screen` or `tmux` (script installs them automatically).  
- **Not for Windows** – use the Windows version above.

#### Installation (Linux)
1. Download `rustserverinstaller.sh` from **[rustserverinstaller.sh](https://github.com/0-renn/rustserverinstaller/releases/download/V1/rust_server_setup_linux.sh)**.
2. Make it executable: `chmod +x rustserverinstaller.sh`
3. Run as **root** or with `sudo`: `sudo ./rustserverinstaller.sh`
4. Follow the on‑screen prompts (branch, plugins, map options, etc.).
5. After installation, start the server using `./start_server.sh`

#### Features (Linux)
- ✅ SteamCMD automatic installation  
- ✅ Official or staging branch  
- ✅ Custom maps (RustEdit.dll via Wine if needed)  
- ✅ Oxide or Carbon plugin framework (Oxide not for staging)  
- ✅ Admin user setup  
- ✅ Generates `start_server.sh`, `update_server.sh`, `wipe_server.sh`

---

### How to Join (Both OS)
- **Same machine**: open Rust, press `F1`, type `connect localhost`.  
- **Another machine on same network**: `client.connect [SERVER_IP]:[SERVER_PORT]`  
  *Example (default port 28015):* `client.connect 192.168.1.1:28015`

---
<div align="center">
Love This Project?
If this library made your first rust server, give it a star! <img src="https://ren.animex.net.tr/emoji/3194-steamhappy.png" width="30"/>

<img src="https://img.shields.io/badge/⭐-Star_This_Repository-24292e?style=for-the-badge&logo=github" alt="Star Repository">
</div>
[GitHub Repository](https://github.com/0-renn/rustserverinstaller/)
