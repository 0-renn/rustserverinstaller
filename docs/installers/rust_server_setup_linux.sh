#!/bin/bash
# ************************************
# Rust Server Setup Assistant
# Rust Sunucu Kurulum Asistanı
# ************************************

STEAMCMD_DIR="/opt/steamcmd"
FORCEINSTALL=""
LANG_CHOICE=""

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

clear

# ══════════════════════════════════════════════════
# DİL / LANGUAGE SEÇİMİ
# ══════════════════════════════════════════════════
echo -e "${CYAN}${BOLD}"
echo "  ╔══════════════════════════════════════╗"
echo "  ║     Rust Server Setup Assistant      ║"
echo "  ║     Rust Sunucu Kurulum Asistanı     ║"
echo "  ╚══════════════════════════════════════╝"
echo -e "${NC}"
echo "  1: Türkçe"
echo "  2: English"
echo ""

while true; do
  read -rp "  Dil seçin / Select language (1/2): " LANG_CHOICE
  case "$LANG_CHOICE" in
    1|2) break ;;
    *) echo "  Lütfen 1 veya 2 girin / Please enter 1 or 2." ;;
  esac
done

clear

# ══════════════════════════════════════════════════
# METİN FONKSİYONLARI (TR / EN)
# ══════════════════════════════════════════════════
msg() {
  # msg "TR metni" "EN text"
  if [[ "$LANG_CHOICE" == "1" ]]; then
    echo -e "$1"
  else
    echo -e "$2"
  fi
}

prompt() {
  # prompt VAR "TR soru" "EN question"
  local _var="$1"
  local _tr="$2"
  local _en="$3"
  if [[ "$LANG_CHOICE" == "1" ]]; then
    read -rp "$_tr" "$_var"
  else
    read -rp "$_en" "$_var"
  fi
}

yn_prompt() {
  # yn_prompt VAR "TR soru" "EN question"
  # Returns: "y" or "n"
  local _var="$1"
  local _tr="$2"
  local _en="$3"
  local _input
  while true; do
    if [[ "$LANG_CHOICE" == "1" ]]; then
      read -rp "$_tr (e/h): " _input
      case "$_input" in
        e|E) eval "$_var=y"; return ;;
        h|H) eval "$_var=n"; return ;;
        *) echo "  Lütfen e veya h girin." ;;
      esac
    else
      read -rp "$_en (y/n): " _input
      case "$_input" in
        y|Y) eval "$_var=y"; return ;;
        n|N) eval "$_var=n"; return ;;
        *) echo "  Please enter y or n." ;;
      esac
    fi
  done
}

# ══════════════════════════════════════════════════
# INTRO
# ══════════════════════════════════════════════════
msg "${CYAN}${BOLD}  Rust Sunucu Kurulum Asistanına Hoş Geldiniz!${NC}" \
    "${CYAN}${BOLD}  Welcome to the Rust Server Setup Assistant!${NC}"
echo ""
msg "  Devam etmek için Enter'a basın..." \
    "  Press Enter to continue..."
read -r
clear

# ══════════════════════════════════════════════════
# STEAMCMD KURULUMU
# ══════════════════════════════════════════════════
msg "${YELLOW}  SteamCMD kuruluyor...${NC}" \
    "${YELLOW}  Installing SteamCMD...${NC}"
echo ""
msg "  SteamCMD'yi nereye kurmak istiyorsunuz? (Varsayılan: /opt/steamcmd)" \
    "  Where would you like to install SteamCMD? (Default: /opt/steamcmd)"
prompt INPUT_STEAMCMD "  Konum: " "  Location: "
STEAMCMD_DIR="${INPUT_STEAMCMD:-/opt/steamcmd}"

mkdir -p "$STEAMCMD_DIR"
cd "$STEAMCMD_DIR"

msg "  SteamCMD indiriliyor..." "  Downloading SteamCMD..."
curl -SL -A "Mozilla/5.0" "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
  --output "$STEAMCMD_DIR/steamcmd_linux.tar.gz"

tar -xzf "$STEAMCMD_DIR/steamcmd_linux.tar.gz" -C "$STEAMCMD_DIR"
rm -f "$STEAMCMD_DIR/steamcmd_linux.tar.gz"

clear
msg "${GREEN}  SteamCMD başarıyla kuruldu!${NC}" \
    "${GREEN}  SteamCMD installed successfully!${NC}"
echo ""

# ══════════════════════════════════════════════════
# BRANCH SEÇİMİ
# ══════════════════════════════════════════════════
branch_choice() {
  msg "  Sunucu Dalı Seçin:" "  Choose Your Server Branch:"
  echo ""
  echo "    1: $(msg_inline "Ana Dal (Resmi Sürüm)" "Main Branch (Official Version)")"
  echo "    2: $(msg_inline "Staging Dal (Test Sürümü)" "Staging Branch (Testing Version)")"
  echo ""
  msg "  ${YELLOW}Not: Staging dalında Oxide desteği yerleşik değildir.${NC}" \
      "  ${YELLOW}Note: Staging Branch does not have built-in Oxide support.${NC}"
  echo ""
  while true; do
    prompt BRANCH "  1 veya 2 girin: " "  Enter 1 or 2: "
    case "$BRANCH" in
      1) install_rust_main; return ;;
      2) install_rust_staging; return ;;
      *) msg "  Lütfen 1 veya 2 girin." "  Please enter 1 or 2." ;;
    esac
  done
}

msg_inline() {
  if [[ "$LANG_CHOICE" == "1" ]]; then echo "$1"; else echo "$2"; fi
}

# ══════════════════════════════════════════════════
# RUST MAIN KURULUMU
# ══════════════════════════════════════════════════
install_rust_main() {
  FORCEINSTALL="/opt/RustServer"
  echo ""
  msg "  ${RED}UYARI: Bu dizinde mevcut bir kurulum olmadığından emin olun.${NC}" \
      "  ${RED}WARNING: Ensure there is no existing installation in this directory.${NC}"
  msg "  Klasör boş veya mevcut olmamalıdır." \
      "  The folder should be empty or nonexistent."
  echo ""
  msg "  Rust Sunucusunu nereye kurmak istiyorsunuz? (Varsayılan: /opt/RustServer)" \
      "  Where would you like to install the Rust Server? (Default: /opt/RustServer)"
  prompt INPUT_DIR "  Konum: " "  Location: "
  FORCEINSTALL="${INPUT_DIR:-/opt/RustServer}"

  mkdir -p "$FORCEINSTALL"
  cd "$FORCEINSTALL"

  msg "  Rust Sunucusu kuruluyor, lütfen bekleyin..." \
      "  Installing Rust Server, please wait..."
  "$STEAMCMD_DIR/steamcmd.sh" \
    +force_install_dir "$FORCEINSTALL" \
    +login anonymous \
    +app_update 258550 \
    +quit

  write_update_script_main
  clear
  msg "${GREEN}  Rust Sunucusu kuruldu!${NC}" "${GREEN}  Rust Server installed!${NC}"
  echo "  ----------------------"
  echo ""
  mod_choice
}

# ══════════════════════════════════════════════════
# RUST STAGING KURULUMU
# ══════════════════════════════════════════════════
install_rust_staging() {
  FORCEINSTALL="/opt/RustStagingServer"
  echo ""
  msg "  ${RED}UYARI: Bu dizinde mevcut bir kurulum olmadığından emin olun.${NC}" \
      "  ${RED}WARNING: Ensure there is no existing installation in this directory.${NC}"
  echo ""
  msg "  Rust Staging Sunucusunu nereye kurmak istiyorsunuz? (Varsayılan: /opt/RustStagingServer)" \
      "  Where would you like to install the Rust Staging Server? (Default: /opt/RustStagingServer)"
  prompt INPUT_DIR "  Konum: " "  Location: "
  FORCEINSTALL="${INPUT_DIR:-/opt/RustStagingServer}"

  mkdir -p "$FORCEINSTALL"
  cd "$FORCEINSTALL"

  msg "  Rust Staging Sunucusu kuruluyor..." \
      "  Installing Rust Staging Server..."
  "$STEAMCMD_DIR/steamcmd.sh" \
    +force_install_dir "$FORCEINSTALL" \
    +login anonymous \
    +app_update 258550 \
    -beta staging \
    +quit

  write_update_script_staging
  clear
  msg "${GREEN}  Rust Staging Sunucusu kuruldu!${NC}" "${GREEN}  Rust Staging Server installed!${NC}"
  echo "  ------------------------------"
  echo ""
  mod_choice_staging
}

# ══════════════════════════════════════════════════
# UPDATE SCRIPT YAZICI - MAIN
# ══════════════════════════════════════════════════
write_update_script_main() {
  if [[ "$LANG_CHOICE" == "1" ]]; then
    cat > "$FORCEINSTALL/UpdateServer.sh" << 'UPDEOF'
#!/bin/bash
echo "Sunucu güncelleniyor..."
UPDEOF
  else
    cat > "$FORCEINSTALL/UpdateServer.sh" << 'UPDEOF'
#!/bin/bash
echo "Updating server..."
UPDEOF
  fi

  cat >> "$FORCEINSTALL/UpdateServer.sh" << UPDEOF
"$STEAMCMD_DIR/steamcmd.sh" +force_install_dir "$FORCEINSTALL" +login anonymous +app_update 258550 +quit
echo ""
UPDEOF

  if [[ "$LANG_CHOICE" == "1" ]]; then
    cat >> "$FORCEINSTALL/UpdateServer.sh" << UPDEOF
echo "Rust güncellendi!"
echo ""
read -rp "Sunucuyu şimdi başlatmak istiyor musunuz? (e/h): " RUN
if [[ "\$RUN" == "e" || "\$RUN" == "E" ]]; then
  bash "$FORCEINSTALL/StartServer.sh"
fi
UPDEOF
  else
    cat >> "$FORCEINSTALL/UpdateServer.sh" << UPDEOF
echo "Rust updated!"
echo ""
read -rp "Do you want to run your server now? (y/n): " RUN
if [[ "\$RUN" == "y" || "\$RUN" == "Y" ]]; then
  bash "$FORCEINSTALL/StartServer.sh"
fi
UPDEOF
  fi
  chmod +x "$FORCEINSTALL/UpdateServer.sh"
}

# ══════════════════════════════════════════════════
# UPDATE SCRIPT YAZICI - STAGING
# ══════════════════════════════════════════════════
write_update_script_staging() {
  cat > "$FORCEINSTALL/UpdateServer.sh" << UPDEOF
#!/bin/bash
UPDEOF

  if [[ "$LANG_CHOICE" == "1" ]]; then
    cat >> "$FORCEINSTALL/UpdateServer.sh" << UPDEOF
echo "Sunucu güncelleniyor..."
"$STEAMCMD_DIR/steamcmd.sh" +force_install_dir "$FORCEINSTALL" +login anonymous +app_update 258550 -beta staging +quit
echo "Rust Staging güncellendi!"
echo ""
read -rp "Sunucuyu şimdi başlatmak istiyor musunuz? (e/h): " RUN
if [[ "\$RUN" == "e" || "\$RUN" == "E" ]]; then
  bash "$FORCEINSTALL/StartServer.sh"
fi
UPDEOF
  else
    cat >> "$FORCEINSTALL/UpdateServer.sh" << UPDEOF
echo "Updating server..."
"$STEAMCMD_DIR/steamcmd.sh" +force_install_dir "$FORCEINSTALL" +login anonymous +app_update 258550 -beta staging +quit
echo "Rust Staging updated!"
echo ""
read -rp "Do you want to run your server now? (y/n): " RUN
if [[ "\$RUN" == "y" || "\$RUN" == "Y" ]]; then
  bash "$FORCEINSTALL/StartServer.sh"
fi
UPDEOF
  fi
  chmod +x "$FORCEINSTALL/UpdateServer.sh"
}

# ══════════════════════════════════════════════════
# MOD SEÇİMİ - MAIN
# ══════════════════════════════════════════════════
mod_choice() {
  msg "  Mod seçenekleri:" "  Mod options:"
  echo ""
  echo "    1: Oxide"
  echo "    2: Carbon"
  echo "    3: Vanilla ($(msg_inline "Modsuz" "No Mods"))"
  echo ""
  while true; do
    prompt MOD \
      "  Oxide, Carbon veya Vanilla? (1/2/3): " \
      "  Install Oxide, Carbon or Vanilla? (1/2/3): "
    case "$MOD" in
      1) install_oxide; return ;;
      2) install_carbon; return ;;
      3) map_choice; return ;;
      *) msg "  Lütfen 1, 2 veya 3 girin." "  Please enter 1, 2 or 3." ;;
    esac
  done
}

# ══════════════════════════════════════════════════
# MOD SEÇİMİ - STAGING
# ══════════════════════════════════════════════════
mod_choice_staging() {
  msg "  Mod seçenekleri:" "  Mod options:"
  echo ""
  echo "    1: Carbon"
  echo "    2: Vanilla ($(msg_inline "Modsuz" "No Mods"))"
  echo ""
  while true; do
    prompt MOD \
      "  Carbon veya Vanilla? (1/2): " \
      "  Install Carbon or Vanilla? (1/2): "
    case "$MOD" in
      1) install_carbon_staging; return ;;
      2) map_choice; return ;;
      *) msg "  Lütfen 1 veya 2 girin." "  Please enter 1 or 2." ;;
    esac
  done
}

# ══════════════════════════════════════════════════
# OXIDE KURULUMU
# ══════════════════════════════════════════════════
install_oxide() {
  msg "  Oxide kuruluyor..." "  Installing Oxide..."
  curl -SL -A "Mozilla/5.0" "https://umod.org/games/rust/download" \
    --output "$FORCEINSTALL/OxideMod.zip"
  cd "$FORCEINSTALL"
  unzip -o OxideMod.zip -d "$FORCEINSTALL"
  rm -f OxideMod.zip

  cat > "$FORCEINSTALL/UpdateServer.sh" << UPDEOF
#!/bin/bash
UPDEOF
  if [[ "$LANG_CHOICE" == "1" ]]; then
    cat >> "$FORCEINSTALL/UpdateServer.sh" << UPDEOF
echo "Sunucu güncelleniyor..."
"$STEAMCMD_DIR/steamcmd.sh" +force_install_dir "$FORCEINSTALL" +login anonymous +app_update 258550 +quit
echo "Rust güncellendi!"
read -rp "Devam etmek için Enter'a basın..."
echo "Oxide güncelleniyor..."
curl -SL -A "Mozilla/5.0" "https://umod.org/games/rust/download" --output "$FORCEINSTALL/OxideMod.zip"
cd "$FORCEINSTALL"
unzip -o OxideMod.zip -d "$FORCEINSTALL"
rm -f OxideMod.zip
echo "Oxide güncellendi!"
echo ""
read -rp "Sunucuyu şimdi başlatmak istiyor musunuz? (e/h): " RUN
if [[ "\$RUN" == "e" || "\$RUN" == "E" ]]; then
  bash "$FORCEINSTALL/StartServer.sh"
fi
UPDEOF
  else
    cat >> "$FORCEINSTALL/UpdateServer.sh" << UPDEOF
echo "Updating server..."
"$STEAMCMD_DIR/steamcmd.sh" +force_install_dir "$FORCEINSTALL" +login anonymous +app_update 258550 +quit
echo "Rust updated!"
read -rp "Press Enter to continue..."
echo "Updating Oxide..."
curl -SL -A "Mozilla/5.0" "https://umod.org/games/rust/download" --output "$FORCEINSTALL/OxideMod.zip"
cd "$FORCEINSTALL"
unzip -o OxideMod.zip -d "$FORCEINSTALL"
rm -f OxideMod.zip
echo "Oxide updated!"
echo ""
read -rp "Do you want to run your server now? (y/n): " RUN
if [[ "\$RUN" == "y" || "\$RUN" == "Y" ]]; then
  bash "$FORCEINSTALL/StartServer.sh"
fi
UPDEOF
  fi
  chmod +x "$FORCEINSTALL/UpdateServer.sh"

  clear
  msg "${GREEN}  Oxide kuruldu!${NC}" "${GREEN}  Oxide installed!${NC}"
  echo ""
  map_choice
}

# ══════════════════════════════════════════════════
# CARBON KURULUMU (MAIN)
# ══════════════════════════════════════════════════
install_carbon() {
  msg "  Carbon kuruluyor..." "  Installing Carbon..."
  curl -SL -A "Mozilla/5.0" \
    "https://github.com/CarbonCommunity/Carbon.Core/releases/download/production_build/Carbon.Linux.Release.zip" \
    --output "$FORCEINSTALL/CarbonMod.zip"
  cd "$FORCEINSTALL"
  unzip -o CarbonMod.zip -d "$FORCEINSTALL"
  rm -f CarbonMod.zip

  cat > "$FORCEINSTALL/UpdateServer.sh" << UPDEOF
#!/bin/bash
UPDEOF
  if [[ "$LANG_CHOICE" == "1" ]]; then
    cat >> "$FORCEINSTALL/UpdateServer.sh" << UPDEOF
echo "Sunucu güncelleniyor..."
"$STEAMCMD_DIR/steamcmd.sh" +force_install_dir "$FORCEINSTALL" +login anonymous +app_update 258550 +quit
echo "Rust güncellendi!"
echo ""
read -rp "Carbon'u da güncellemek istiyor musunuz? (e/h): " CARBONUPDATE
if [[ "\$CARBONUPDATE" == "e" || "\$CARBONUPDATE" == "E" ]]; then
  curl -SL -A "Mozilla/5.0" "https://github.com/CarbonCommunity/Carbon.Core/releases/download/production_build/Carbon.Linux.Release.zip" \
    --output "$FORCEINSTALL/CarbonMod.zip"
  cd "$FORCEINSTALL" && unzip -o CarbonMod.zip -d "$FORCEINSTALL" && rm -f CarbonMod.zip
  echo "Carbon güncellendi!"
fi
echo ""
read -rp "Sunucuyu şimdi başlatmak istiyor musunuz? (e/h): " RUN
if [[ "\$RUN" == "e" || "\$RUN" == "E" ]]; then
  bash "$FORCEINSTALL/StartServer.sh"
fi
UPDEOF
  else
    cat >> "$FORCEINSTALL/UpdateServer.sh" << UPDEOF
echo "Updating server..."
"$STEAMCMD_DIR/steamcmd.sh" +force_install_dir "$FORCEINSTALL" +login anonymous +app_update 258550 +quit
echo "Rust updated!"
echo ""
read -rp "Do you want to update Carbon now? (y/n): " CARBONUPDATE
if [[ "\$CARBONUPDATE" == "y" || "\$CARBONUPDATE" == "Y" ]]; then
  curl -SL -A "Mozilla/5.0" "https://github.com/CarbonCommunity/Carbon.Core/releases/download/production_build/Carbon.Linux.Release.zip" \
    --output "$FORCEINSTALL/CarbonMod.zip"
  cd "$FORCEINSTALL" && unzip -o CarbonMod.zip -d "$FORCEINSTALL" && rm -f CarbonMod.zip
  echo "Carbon updated!"
fi
echo ""
read -rp "Do you want to run your server now? (y/n): " RUN
if [[ "\$RUN" == "y" || "\$RUN" == "Y" ]]; then
  bash "$FORCEINSTALL/StartServer.sh"
fi
UPDEOF
  fi
  chmod +x "$FORCEINSTALL/UpdateServer.sh"

  clear
  msg "${GREEN}  Carbon kuruldu!${NC}" "${GREEN}  Carbon installed!${NC}"
  echo ""
  map_choice
}

# ══════════════════════════════════════════════════
# CARBON KURULUMU (STAGING)
# ══════════════════════════════════════════════════
install_carbon_staging() {
  msg "  Carbon kuruluyor..." "  Installing Carbon..."
  curl -SL -A "Mozilla/5.0" \
    "https://github.com/CarbonCommunity/Carbon.Core/releases/download/production_build/Carbon.Linux.Release.zip" \
    --output "$FORCEINSTALL/CarbonMod.zip"
  cd "$FORCEINSTALL"
  unzip -o CarbonMod.zip -d "$FORCEINSTALL"
  rm -f CarbonMod.zip

  cat > "$FORCEINSTALL/UpdateServer.sh" << UPDEOF
#!/bin/bash
UPDEOF
  if [[ "$LANG_CHOICE" == "1" ]]; then
    cat >> "$FORCEINSTALL/UpdateServer.sh" << UPDEOF
echo "Sunucu güncelleniyor..."
"$STEAMCMD_DIR/steamcmd.sh" +force_install_dir "$FORCEINSTALL" +login anonymous +app_update 258550 -beta staging +quit
echo "Rust Staging güncellendi!"
read -rp "Carbon'u da güncellemek istiyor musunuz? (e/h): " CARBONUPDATE
if [[ "\$CARBONUPDATE" == "e" || "\$CARBONUPDATE" == "E" ]]; then
  curl -SL -A "Mozilla/5.0" "https://github.com/CarbonCommunity/Carbon.Core/releases/download/production_build/Carbon.Linux.Release.zip" \
    --output "$FORCEINSTALL/CarbonMod.zip"
  cd "$FORCEINSTALL" && unzip -o CarbonMod.zip -d "$FORCEINSTALL" && rm -f CarbonMod.zip
  echo "Carbon güncellendi!"
fi
read -rp "Sunucuyu şimdi başlatmak istiyor musunuz? (e/h): " RUN
if [[ "\$RUN" == "e" || "\$RUN" == "E" ]]; then
  bash "$FORCEINSTALL/StartServer.sh"
fi
UPDEOF
  else
    cat >> "$FORCEINSTALL/UpdateServer.sh" << UPDEOF
echo "Updating server..."
"$STEAMCMD_DIR/steamcmd.sh" +force_install_dir "$FORCEINSTALL" +login anonymous +app_update 258550 -beta staging +quit
echo "Rust Staging updated!"
read -rp "Do you want to update Carbon now? (y/n): " CARBONUPDATE
if [[ "\$CARBONUPDATE" == "y" || "\$CARBONUPDATE" == "Y" ]]; then
  curl -SL -A "Mozilla/5.0" "https://github.com/CarbonCommunity/Carbon.Core/releases/download/production_build/Carbon.Linux.Release.zip" \
    --output "$FORCEINSTALL/CarbonMod.zip"
  cd "$FORCEINSTALL" && unzip -o CarbonMod.zip -d "$FORCEINSTALL" && rm -f CarbonMod.zip
  echo "Carbon updated!"
fi
read -rp "Do you want to run your server now? (y/n): " RUN
if [[ "\$RUN" == "y" || "\$RUN" == "Y" ]]; then
  bash "$FORCEINSTALL/StartServer.sh"
fi
UPDEOF
  fi
  chmod +x "$FORCEINSTALL/UpdateServer.sh"

  clear
  msg "${GREEN}  Carbon kuruldu!${NC}" "${GREEN}  Carbon installed!${NC}"
  echo ""
  map_choice
}

# ══════════════════════════════════════════════════
# HARİTA / MAP SEÇİMİ
# ══════════════════════════════════════════════════
map_choice() {
  echo ""
  yn_prompt USE_CUSTOM_MAP \
    "  Özel harita dosyası kullanmak istiyor musunuz?" \
    "  Do you want to use a custom map file?"
  if [[ "$USE_CUSTOM_MAP" == "y" ]]; then
    rustedit_choice
  else
    setup_server_proc
  fi
}

# ══════════════════════════════════════════════════
# RUSTEDIT SEÇİMİ
# ══════════════════════════════════════════════════
rustedit_choice() {
  echo ""
  yn_prompt INSTALL_RUSTEDIT \
    "  RustEdit DLL kurmak istiyor musunuz? (özel haritalar için genellikle gereklidir)" \
    "  Do you want to install the RustEdit DLL? (usually required for custom maps)"
  if [[ "$INSTALL_RUSTEDIT" == "y" ]]; then
    install_rustedit
  fi
  setup_server_custom
}

install_rustedit() {
  msg "  RustEdit DLL kuruluyor..." "  Installing RustEdit DLL..."
  mkdir -p "$FORCEINSTALL/RustDedicated_Data/Managed"
  curl -SL \
    "https://github.com/k1lly0u/Oxide.Ext.RustEdit/raw/master/Oxide.Ext.RustEdit.dll" \
    --output "$FORCEINSTALL/RustDedicated_Data/Managed/Oxide.Ext.RustEdit.dll"
  clear
  msg "${GREEN}  RustEdit DLL kuruldu!${NC}" "${GREEN}  RustEdit DLL installed!${NC}"
  echo ""
}

# ══════════════════════════════════════════════════
# SUNUCU YAPILANDIRMASI - PROSEDÜREL
# ══════════════════════════════════════════════════
setup_server_proc() {
  cd "$FORCEINSTALL"

  prompt SERVERPORT \
    "  Sunucu portu (Varsayılan: 28015): " \
    "  Server port (Default: 28015): "
  SERVERPORT="${SERVERPORT:-28015}"

  prompt RCONPORT \
    "  RCON portu (Varsayılan: 28016): " \
    "  RCON port (Default: 28016): "
  RCONPORT="${RCONPORT:-28016}"

  prompt QUERYPORT \
    "  Query portu (Varsayılan: 28017): " \
    "  Query port (Default: 28017): "
  QUERYPORT="${QUERYPORT:-28017}"

  msg "  Kimlik adında boşluk kullanmayın!" \
      "  Do not use spaces in the identity name!"
  prompt IDENTITY \
    "  Sunucu kimliği (Varsayılan: RustServer): " \
    "  Server identity (Default: RustServer): "
  IDENTITY="${IDENTITY:-RustServer}"

  prompt SEED \
    "  Harita tohumu (Varsayılan: 1337): " \
    "  Map seed (Default: 1337): "
  SEED="${SEED:-1337}"

  prompt WORLDSIZE \
    "  Dünya boyutu (Varsayılan: 4500): " \
    "  World size (Default: 4500): "
  WORLDSIZE="${WORLDSIZE:-4500}"

  prompt MAXPLAYERS \
    "  Maksimum oyuncu (Varsayılan: 150): " \
    "  Max players (Default: 150): "
  MAXPLAYERS="${MAXPLAYERS:-150}"

  prompt HOSTNAME \
    "  Sunucu adı (Sunucu listesinde görünecek isim): " \
    "  Server hostname (How it appears on the server browser): "
  HOSTNAME="${HOSTNAME:-A Simple Rust Server}"

  prompt DESCRIPTION \
    "  Sunucu açıklaması: " \
    "  Server description: "
  DESCRIPTION="${DESCRIPTION:-An unconfigured Rust server.}"

  prompt RCONPW \
    "  RCON şifresi (güvenli bir şifre seçin!): " \
    "  RCON password (make it secure!): "
  RCONPW="${RCONPW:-ChangeThisPlease}"

  prompt SERVERURL \
    "  Sunucu URL'si (Discord daveti vb. boş bırakılabilir): " \
    "  Server URL (e.g. Discord invite, can be blank): "

  msg "  Header resim linki SADECE resmi içermeli, 1024x512 boyutunda olmalı" \
      "  Header image link MUST contain ONLY the picture, at 1024x512 size"
  prompt HEADERIMAGE \
    "  Sunucu header resmi (boş bırakılabilir): " \
    "  Server header image (can be blank): "

  cat > "$FORCEINSTALL/StartServer.sh" << STARTEOF
#!/bin/bash
while true; do
  ./RustDedicated -batchmode \\
    -logFile "${IDENTITY}_logs.txt" \\
    +server.queryport $QUERYPORT \\
    +server.port $SERVERPORT \\
    +server.level "Procedural Map" \\
    +server.seed $SEED \\
    +server.worldsize $WORLDSIZE \\
    +server.maxplayers $MAXPLAYERS \\
    +server.hostname "$HOSTNAME" \\
    +server.description "$DESCRIPTION" \\
    +server.headerimage "$HEADERIMAGE" \\
    +server.url "$SERVERURL" \\
    +server.identity "$IDENTITY" \\
    +rcon.port $RCONPORT \\
    +rcon.password "$RCONPW" \\
    +rcon.web 1
  sleep 5
done
STARTEOF
  chmod +x "$FORCEINSTALL/StartServer.sh"

  mkdir -p "$FORCEINSTALL/server/$IDENTITY/cfg"
  echo 'fps.limit "60"' > "$FORCEINSTALL/server/$IDENTITY/cfg/server.cfg"

  write_wipe_script "$IDENTITY"
  finish_setup
}

# ══════════════════════════════════════════════════
# SUNUCU YAPILANDIRMASI - ÖZEL HARİTA
# ══════════════════════════════════════════════════
setup_server_custom() {
  cd "$FORCEINSTALL"

  prompt SERVERPORT \
    "  Sunucu portu (Varsayılan: 28015): " \
    "  Server port (Default: 28015): "
  SERVERPORT="${SERVERPORT:-28015}"

  prompt RCONPORT \
    "  RCON portu (Varsayılan: 28016): " \
    "  RCON port (Default: 28016): "
  RCONPORT="${RCONPORT:-28016}"

  prompt QUERYPORT \
    "  Query portu (Varsayılan: 28017): " \
    "  Query port (Default: 28017): "
  QUERYPORT="${QUERYPORT:-28017}"

  msg "  Kimlik adında boşluk kullanmayın!" \
      "  Do not use spaces in the identity name!"
  prompt IDENTITY \
    "  Sunucu kimliği (Varsayılan: RustServer): " \
    "  Server identity (Default: RustServer): "
  IDENTITY="${IDENTITY:-RustServer}"

  prompt LEVELURL \
    "  Özel harita URL'si (Direkt indirme linki olmalı!): " \
    "  Custom map URL (Must be a direct download link!): "
  LEVELURL="${LEVELURL:-https://www.dropbox.com/s/ig1ds1m3q5hnflj/proc_install_1.0.map?dl=1}"

  prompt MAXPLAYERS \
    "  Maksimum oyuncu (Varsayılan: 150): " \
    "  Max players (Default: 150): "
  MAXPLAYERS="${MAXPLAYERS:-150}"

  prompt HOSTNAME \
    "  Sunucu adı: " \
    "  Server hostname: "
  HOSTNAME="${HOSTNAME:-A Simple Rust Server}"

  prompt DESCRIPTION \
    "  Sunucu açıklaması: " \
    "  Server description: "
  DESCRIPTION="${DESCRIPTION:-An unconfigured Rust server.}"

  prompt RCONPW \
    "  RCON şifresi: " \
    "  RCON password: "
  RCONPW="${RCONPW:-ChangeThisPlease}"

  prompt SERVERURL \
    "  Sunucu URL'si (boş bırakılabilir): " \
    "  Server URL (can be blank): "

  msg "  Header resim linki SADECE resmi içermeli, 1024x512 boyutunda olmalı" \
      "  Header image link MUST contain ONLY the picture, at 1024x512 size"
  prompt HEADERIMAGE \
    "  Sunucu header resmi (boş bırakılabilir): " \
    "  Server header image (can be blank): "

  cat > "$FORCEINSTALL/StartServer.sh" << STARTEOF
#!/bin/bash
while true; do
  ./RustDedicated -batchmode \\
    -logFile "${IDENTITY}_logs.txt" \\
    -levelurl "$LEVELURL" \\
    +server.queryport $QUERYPORT \\
    +server.port $SERVERPORT \\
    +server.maxplayers $MAXPLAYERS \\
    +server.hostname "$HOSTNAME" \\
    +server.description "$DESCRIPTION" \\
    +server.headerimage "$HEADERIMAGE" \\
    +server.url "$SERVERURL" \\
    +server.identity "$IDENTITY" \\
    +rcon.port $RCONPORT \\
    +rcon.password "$RCONPW" \\
    +rcon.web 1
  sleep 5
done
STARTEOF
  chmod +x "$FORCEINSTALL/StartServer.sh"

  mkdir -p "$FORCEINSTALL/server/$IDENTITY/cfg"
  echo 'fps.limit "60"' > "$FORCEINSTALL/server/$IDENTITY/cfg/server.cfg"

  write_wipe_script "$IDENTITY"
  finish_setup
}

# ══════════════════════════════════════════════════
# WIPE SCRİPTİ
# ══════════════════════════════════════════════════
write_wipe_script() {
  local IDENT="$1"
  cat > "$FORCEINSTALL/WipeServer.sh" << WIPEEOF
#!/bin/bash
WIPEEOF

  if [[ "$LANG_CHOICE" == "1" ]]; then
    cat >> "$FORCEINSTALL/WipeServer.sh" << WIPEEOF
echo "Bu araç sunucunuzu silecektir. Devam etmek istediğinizden emin olun."
echo ""
read -rp "Devam etmek için Enter'a basın..."
echo ""
read -rp "Blueprint'leri de silmek istiyor musunuz? (e/h): " WIPE_BP
if [[ "\$WIPE_BP" == "e" || "\$WIPE_BP" == "E" ]]; then
  echo ""
  echo "UYARI: HARİTA, OYUNCU VE BLUEPRINT VERİLERİ SİLİNECEK!"
  read -rp "Devam etmek için Enter'a basın..."
  cd "$FORCEINSTALL/server/$IDENT"
  rm -f *.sav *.sav.* *.map *.db *.db-journal *.db-wal
  echo "Sunucu Harita ve BP Silindi!"
  echo "Harita tohumunu başlangıç dosyasında güncellemeyi unutmayın!"
  echo "Gerekli eklenti verilerini silmeyi unutmayın!"
else
  echo ""
  echo "UYARI: HARİTA VE OYUNCU VERİLERİ SİLİNECEK!"
  read -rp "Devam etmek için Enter'a basın..."
  cd "$FORCEINSTALL/server/$IDENT"
  rm -f *.sav *.sav.* *.map
  rm -f player.deaths.* player.identities.* player.states.* player.tokens.* sv.files.*
  echo "Sunucu Harita Silindi!"
  echo "Harita tohumunu başlangıç dosyasında güncellemeyi unutmayın!"
  echo "Gerekli eklenti verilerini silmeyi unutmayın!"
fi
WIPEEOF
  else
    cat >> "$FORCEINSTALL/WipeServer.sh" << WIPEEOF
echo "This will wipe your server. Make sure you want to continue."
echo ""
read -rp "Press Enter to continue..."
echo ""
read -rp "Do you want to wipe Blueprints too? (y/n): " WIPE_BP
if [[ "\$WIPE_BP" == "y" || "\$WIPE_BP" == "Y" ]]; then
  echo ""
  echo "WARNING: THIS WILL WIPE MAP, PLAYER AND BLUEPRINT DATA!"
  read -rp "Press Enter to continue..."
  cd "$FORCEINSTALL/server/$IDENT"
  rm -f *.sav *.sav.* *.map *.db *.db-journal *.db-wal
  echo "Server has been Map and BP Wiped!"
  echo "Be sure to change your map seed in your startup file!"
  echo "Don't forget to delete any necessary plugin data!"
else
  echo ""
  echo "WARNING: THIS WILL WIPE MAP AND PLAYER DATA!"
  read -rp "Press Enter to continue..."
  cd "$FORCEINSTALL/server/$IDENT"
  rm -f *.sav *.sav.* *.map
  rm -f player.deaths.* player.identities.* player.states.* player.tokens.* sv.files.*
  echo "Server has been Map Wiped!"
  echo "Be sure to change your map seed in your startup file!"
  echo "Don't forget to delete any necessary plugin data!"
fi
WIPEEOF
  fi
  chmod +x "$FORCEINSTALL/WipeServer.sh"
}

# ══════════════════════════════════════════════════
# ADMİN EKLEME
# ══════════════════════════════════════════════════
add_admin() {
  msg "  Steam ID'nizi bilmiyorsanız: https://www.businessinsider.com/how-to-find-steam-id" \
      "  If you don't know your SteamID, visit: https://www.businessinsider.com/how-to-find-steam-id"
  echo ""
  prompt STEAMID \
    "  Steam64 ID'nizi girin: " \
    "  Enter your Steam64 ID: "
  STEAMID="${STEAMID:-12345678901234567}"
  mkdir -p "$FORCEINSTALL/server/$IDENTITY/cfg"
  echo "ownerid $STEAMID \"unknown\" \"no reason\"" > "$FORCEINSTALL/server/$IDENTITY/cfg/users.cfg"
  clear
}

# ══════════════════════════════════════════════════
# BİTİŞ / FINISH
# ══════════════════════════════════════════════════
finish_setup() {
  clear
  echo ""
  yn_prompt DO_ADMIN \
    "  Kendinizi sunucuya admin olarak eklemek istiyor musunuz?" \
    "  Do you want to add yourself as an admin on the server?"
  [[ "$DO_ADMIN" == "y" ]] && add_admin

  clear
  msg "${GREEN}${BOLD}  Her şey hazır!${NC}" "${GREEN}${BOLD}  All done!${NC}"
  echo ""
  msg "  Aşağıdaki dosyalar ${CYAN}$FORCEINSTALL${NC} dizininde oluşturuldu:" \
      "  The following files were created in ${CYAN}$FORCEINSTALL${NC}:"
  echo ""
  msg "  ${CYAN}StartServer.sh${NC}   → Sunucuyu başlatır" \
      "  ${CYAN}StartServer.sh${NC}   → Launch your server"
  msg "  ${CYAN}UpdateServer.sh${NC}  → Sunucuyu günceller" \
      "  ${CYAN}UpdateServer.sh${NC}  → Update your server"
  msg "  ${CYAN}WipeServer.sh${NC}    → Sunucuyu siler (harita veya BP+harita)" \
      "  ${CYAN}WipeServer.sh${NC}    → Wipe your server (map or full BP wipe)"
  echo ""
  yn_prompt START_NOW \
    "  Sunucuyu şimdi başlatmak istiyor musunuz?" \
    "  Do you want to run your server now?"
  if [[ "$START_NOW" == "y" ]]; then
    cd "$FORCEINSTALL"
    bash StartServer.sh
  fi
}

# ══════════════════════════════════════════════════
# BAŞLAT / START
# ══════════════════════════════════════════════════
branch_choice
