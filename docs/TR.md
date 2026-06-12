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
            
## Türkçe

### Genel Bakış
Bu betikler, **Windows 10+** veya **Linux** üzerinde tek bir dosya ile **Rust sunucusu** kurar. SteamCMD dağıtımından sunucu yapılandırmasına, eklenti çatılarına ve yönetim betiklerine kadar her şeyi otomatikleştirir.

### Windows Sürümü

#### Sistem Gereksinimleri (Windows)
- Windows 10 / Windows 11 / Windows Server 2016 ve üzeri.  
- Windows Defender sorunsuzdur; bazı virüs programları engelleyebilir – sorun olursa geçici olarak devre dışı bırakın.  
- **Linux için değil** – aşağıdaki Linux sürümünü kullanın.

#### Kurulum (Windows)
1. `rustserverinstaller.bat` dosyasını **[rustserverinstaller.bat](https://github.com/0-renn/rustserverinstaller/releases/download/V1/rust_server_setup_windows.bat)** adresinden indirin.
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
1. `rustserverinstaller.sh` dosyasını **[rustserverinstaller.sh](https://github.com/0-renn/rustserverinstaller/releases/download/V1/rust_server_setup_linux.sh)** adresinden indirin.
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
<div align="center">
Love This Project?
If this library made your first rust server, give it a star! <img src="https://ren.animex.net.tr/emoji/3194-steamhappy.png" width="30"/>

<img src="https://img.shields.io/badge/⭐-Star_This_Repository-24292e?style=for-the-badge&logo=github" alt="Star Repository">
</div>
