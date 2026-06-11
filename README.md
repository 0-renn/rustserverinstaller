<div align="center">

<img src="https://files.facepunch.com/lewis/1b2911b1/rust-marque.svg" width="50"/>

## Rust Server Installers For Windows 10+ and Linux

<img src="https://avatars.githubusercontent.com/0-renn" width="60"/>  <img src="https://avatars.githubusercontent.com/ErcanDinsel" width="60"/>

&nbsp;&nbsp; **Me** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **Buddy**

</div>

<br/>

> [**English**](#english) | [**Türkçe**](#türkçe)

---

## English <a name="english"></a>

### Overview
These scripts install a **Rust dedicated server** on either **Windows 10+** or **Linux** using a single file. They automate SteamCMD deployment, server configuration, plugin frameworks, and management scripts.

### Windows Version

#### System Requirements (Windows)
- Windows 10 / Windows 11 / Windows Server 2016 or later.  
- Windows Defender is fine; some antivirus may block the script – temporarily disable if issues occur.  
- **Not for Linux** – use the Linux version below.

#### Installation (Windows)
1. Download `rustserverinstaller.bat` from **[rustserverinstaller.bat](https://github.com/0-renn/rustserverinstaller/releases/download/V1/rust_server_setup_Windows.bat)**.
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
1. Download `rustserverinstaller.sh` from **[rustserverinstaller.sh](https://github.com/0-renn/rustserverinstaller/releases/download/V1/rust_server_setup_Windows.sh)**.
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

## Türkçe <a name="türkçe"></a>

### Genel Bakış
Bu betikler, **Windows 10+** veya **Linux** üzerinde tek bir dosya ile **Rust sunucusu** kurar. SteamCMD dağıtımından sunucu yapılandırmasına, eklenti çatılarına ve yönetim betiklerine kadar her şeyi otomatikleştirir.

### Windows Sürümü

#### Sistem Gereksinimleri (Windows)
- Windows 10 / Windows 11 / Windows Server 2016 ve üzeri.  
- Windows Defender sorunsuzdur; bazı virüs programları engelleyebilir – sorun olursa geçici olarak devre dışı bırakın.  
- **Linux için değil** – aşağıdaki Linux sürümünü kullanın.

#### Kurulum (Windows)
1. `rustserverinstaller.bat` dosyasını **[rustserverinstaller.bat](https://github.com/0-renn/rustserverinstaller/releases/download/V1/rust_server_setup_Windows.bat)** adresinden indirin.
2. Dosyayı **Yönetici olarak çalıştırın**.
3. Ekrandaki yönergeleri izleyin (sürüm, eklenti, harita seçenekleri vb.).
4. Kurulum bittikten sonra sunucuyu `StartServer.bat` ile başlatın.

#### Özellikler (Windows)
- ✅ SteamCMD otomatik kurulumu  
- ✅ Kararlı veya staging sürümü  
- ✅ Özel haritalar (RustEdit.dll desteği)  
- ✅ Oxide veya Carbon eklenti çatısı (Oxide staging ile çalışmaz)  
- ✅ Admin kullanıcı ayarı  
- ✅ `StartServer.bat`, `UpdateServer.bat`, `WipeServer.bat` oluşturur

---

### Linux Sürümü

#### Sistem Gereksinimleri (Linux)
- Ubuntu 20.04 / Debian 11 / CentOS 8 veya daha yeni (diğer dağıtımlar da çalışabilir).  
- Bağımlılıklar: `wget`, `unzip`, `screen` veya `tmux` (betik otomatik kurar).  
- **Windows için değil** – yukarıdaki Windows sürümünü kullanın.

#### Kurulum (Linux)
1. `rustserverinstaller.sh` dosyasını **[rustserverinstaller.sh](https://github.com/0-renn/rustserverinstaller/releases/download/V1/rust_server_setup_Windows.sh)** adresinden indirin.
2. Çalıştırılabilir yapın: `chmod +x rustserverinstaller.sh`
3. **root** veya `sudo` ile çalıştırın: `sudo ./rustserverinstaller.sh`
4. Ekrandaki yönergeleri izleyin (sürüm, eklenti, harita seçenekleri vb.).
5. Kurulum bittikten sonra sunucuyu `./start_server.sh` ile başlatın.

#### Özellikler (Linux)
- ✅ SteamCMD otomatik kurulumu  
- ✅ Kararlı veya staging sürümü  
- ✅ Özel haritalar (gerekirse Wine ile RustEdit.dll)  
- ✅ Oxide veya Carbon eklenti çatısı (Oxide staging ile çalışmaz)  
- ✅ Admin kullanıcı ayarı  
- ✅ `start_server.sh`, `update_server.sh`, `wipe_server.sh` oluşturur

---

### Sunucuya Bağlanma (Her İki İS)
- **Aynı makineden**: Rust oyununu açın, `F1` tuşuna basın, `connect localhost` yazın.  
- **Aynı ağdaki başka bir makineden**: `client.connect [SUNUCU_IP]:[SUNUCU_PORT]`  
  *Örnek (varsayılan port 28015):* `client.connect 192.168.1.1:28015`

---

[GitHub Repository](https://github.com/0-renn/rustserverinstaller/)
