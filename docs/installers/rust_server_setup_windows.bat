@echo off
:: ************************************
:: Rust Server Setup Assistant
:: Rust Sunucu Kurulum Asistanı
:: ************************************

title Rust Server Setup Assistant

set STEAMCMD=C:\SteamCMD
set FORCEINSTALL=
set LANG=

cls

:: ══════════════════════════════════════════════════
:: DİL / LANGUAGE SEÇİMİ
:: ══════════════════════════════════════════════════
echo.
echo  ==========================================
echo   Rust Server Setup Assistant
echo   Rust Sunucu Kurulum Asistani
echo  ==========================================
echo.
echo   1: Turkce
echo   2: English
echo.

:langselect
set /p LANG="  Dil secin / Select language (1/2): "
if not '%LANG%'=='' set LANG=%LANG:~0,1%
if '%LANG%'=='1' goto langset
if '%LANG%'=='2' goto langset
echo   Lutfen 1 veya 2 girin / Please enter 1 or 2.
goto langselect

:langset
cls

:: ══════════════════════════════════════════════════
:: INTRO
:: ══════════════════════════════════════════════════
if '%LANG%'=='1' (
  echo  Rust Sunucu Kurulum Asistanina Hos Geldiniz!
  echo.
  pause
) else (
  echo  Welcome to the Rust Server Setup Assistant!
  echo.
  pause
)
cls

:: ══════════════════════════════════════════════════
:: STEAMCMD KURULUMU / INSTALLATION
:: ══════════════════════════════════════════════════
:steamcmd
title Installing SteamCMD...
if '%LANG%'=='1' (
  echo SteamCMD nereye kurulsun? ^(Varsayilan: C:\SteamCMD^)
  echo.
  set /p STEAMCMD="Konum: "
) else (
  echo Where would you like to install SteamCMD? ^(Default: C:\SteamCMD^)
  echo.
  set /p STEAMCMD="Location: "
)
if "%STEAMCMD%"=="" set STEAMCMD=C:\SteamCMD
echo.
md "%STEAMCMD%"
curl -SL -A "Mozilla/5.0" https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip --ssl-no-revoke --output "%STEAMCMD%"\SteamCMD.zip
cd /d "%STEAMCMD%"
powershell -command "Expand-Archive -Force SteamCMD.zip ./"
del SteamCMD.zip
cls
if '%LANG%'=='1' (
  echo SteamCMD basariyla kuruldu!
) else (
  echo SteamCMD installed successfully!
)
echo.

:: ══════════════════════════════════════════════════
:: BRANCH SEÇİMİ / SELECTION
:: ══════════════════════════════════════════════════
:branch
if '%LANG%'=='1' (
  echo Sunucu Dali Secin:
  echo.
  echo   1: Ana Dal ^(Resmi Surum^)
  echo   2: Staging Dal ^(Test Surumu^)
  echo.
  echo   Not: Staging dalinda Oxide destegi yerlesik degildir.
  echo.
  set /p BRANCH="1 veya 2 girin: "
) else (
  echo Choose Your Server Branch:
  echo.
  echo   1: Main Branch ^(Official Version^)
  echo   2: Staging Branch ^(Testing Version^)
  echo.
  echo   Note: Staging Branch does not have built-in Oxide support.
  echo.
  set /p BRANCH="Enter 1 or 2: "
)
if not '%BRANCH%'=='' set BRANCH=%BRANCH:~0,1%
cls
if '%BRANCH%'=='1' goto rustmain
if '%BRANCH%'=='2' goto ruststaging
if '%LANG%'=='1' (echo Lutfen 1 veya 2 girin.) else (echo Please enter 1 or 2.)
goto branch

:: ══════════════════════════════════════════════════
:: RUST MAIN KURULUMU
:: ══════════════════════════════════════════════════
:rustmain
set FORCEINSTALL=C:\RustServer
if '%LANG%'=='1' (
  echo UYARI: Bu dizinde mevcut bir kurulum olmadigi ndan emin olun.
  echo Klasor bos veya mevcut olmamalidir.
  echo.
  echo Rust Sunucusunu nereye kurmak istiyorsunuz? ^(Varsayilan: C:\RustServer^)
  echo.
  set /p FORCEINSTALL="Konum: "
) else (
  echo WARNING: Ensure there is no existing Rust Server installation in this directory.
  echo The folder should be either empty or nonexistent.
  echo.
  echo Where would you like to install the Rust Server? ^(Default: C:\RustServer^)
  echo.
  set /p FORCEINSTALL="Location: "
)
if "%FORCEINSTALL%"=="" set FORCEINSTALL=C:\RustServer
md "%FORCEINSTALL%"
cd /d "%FORCEINSTALL%"
if '%LANG%'=='1' (
  title Rust Sunucusu kuruluyor, lutfen bekleyin...
) else (
  title Installing Rust Server... Please wait.
)
"%STEAMCMD%"\steamcmd.exe +force_install_dir "%FORCEINSTALL%" +login anonymous +app_update 258550 +quit

call :write_update_main
cls
if '%LANG%'=='1' (
  echo Rust Sunucusu kuruldu!
) else (
  echo Rust Server installed!
)
echo ----------------------
echo.
goto modchoice

:: ══════════════════════════════════════════════════
:: RUST STAGING KURULUMU
:: ══════════════════════════════════════════════════
:ruststaging
set FORCEINSTALL=C:\RustStagingServer
if '%LANG%'=='1' (
  echo UYARI: Bu dizinde mevcut bir kurulum olmadigi ndan emin olun.
  echo.
  echo Rust Staging Sunucusunu nereye kurmak istiyorsunuz? ^(Varsayilan: C:\RustStagingServer^)
  echo.
  set /p FORCEINSTALL="Konum: "
) else (
  echo WARNING: Ensure there is no existing installation in this directory.
  echo.
  echo Where would you like to install the Rust Staging Server? ^(Default: C:\RustStagingServer^)
  echo.
  set /p FORCEINSTALL="Location: "
)
if "%FORCEINSTALL%"=="" set FORCEINSTALL=C:\RustStagingServer
md "%FORCEINSTALL%"
cd /d "%FORCEINSTALL%"
if '%LANG%'=='1' (title Rust Staging Sunucusu kuruluyor...) else (title Installing Rust Staging Server...)
"%STEAMCMD%"\steamcmd.exe +force_install_dir "%FORCEINSTALL%" +login anonymous +app_update 258550 -beta staging +quit

call :write_update_staging
cls
if '%LANG%'=='1' (echo Rust Staging Sunucusu kuruldu!) else (echo Rust Staging Server installed!)
echo.
goto modchoicestaging

:: ══════════════════════════════════════════════════
:: UPDATE SCRIPT YAZICI - MAIN
:: ══════════════════════════════════════════════════
:write_update_main
if '%LANG%'=='1' (
(
  echo @echo off
  echo REM UpdateServer.bat
  echo title Sunucu guncelleniyor...
  echo echo Sunucu guncelleniyor...
  echo "%STEAMCMD%"\steamcmd.exe +force_install_dir "%FORCEINSTALL%" +login anonymous +app_update 258550 +quit
  echo echo.
  echo echo Rust guncellendi!
  echo echo.
  echo choice /c eh /m "Sunucuyu simdi baslatmak istiyor musunuz?: "
  echo IF ERRORLEVEL 2 exit
  echo IF ERRORLEVEL 1 goto serverstart
  echo :serverstart
  echo title %comspec%
  echo StartServer.bat
)>"%FORCEINSTALL%\UpdateServer.bat"
) else (
(
  echo @echo off
  echo REM UpdateServer.bat
  echo title Updating Server...
  echo echo Updating server...
  echo "%STEAMCMD%"\steamcmd.exe +force_install_dir "%FORCEINSTALL%" +login anonymous +app_update 258550 +quit
  echo echo.
  echo echo Rust updated!
  echo echo.
  echo choice /c yn /m "Do you want to run your server now?: "
  echo IF ERRORLEVEL 2 exit
  echo IF ERRORLEVEL 1 goto serverstart
  echo :serverstart
  echo title %comspec%
  echo StartServer.bat
)>"%FORCEINSTALL%\UpdateServer.bat"
)
goto :eof

:: ══════════════════════════════════════════════════
:: UPDATE SCRIPT YAZICI - STAGING
:: ══════════════════════════════════════════════════
:write_update_staging
if '%LANG%'=='1' (
(
  echo @echo off
  echo REM UpdateServer.bat
  echo title Sunucu guncelleniyor...
  echo echo Sunucu guncelleniyor...
  echo "%STEAMCMD%"\steamcmd.exe +force_install_dir "%FORCEINSTALL%" +login anonymous +app_update 258550 -beta staging +quit
  echo echo.
  echo echo Rust Staging guncellendi!
  echo echo.
  echo choice /c eh /m "Sunucuyu simdi baslatmak istiyor musunuz?: "
  echo IF ERRORLEVEL 2 exit
  echo IF ERRORLEVEL 1 goto serverstart
  echo :serverstart
  echo title %comspec%
  echo StartServer.bat
)>"%FORCEINSTALL%\UpdateServer.bat"
) else (
(
  echo @echo off
  echo REM UpdateServer.bat
  echo title Updating Server...
  echo echo Updating server...
  echo "%STEAMCMD%"\steamcmd.exe +force_install_dir "%FORCEINSTALL%" +login anonymous +app_update 258550 -beta staging +quit
  echo echo.
  echo echo Rust Staging updated!
  echo echo.
  echo choice /c yn /m "Do you want to run your server now?: "
  echo IF ERRORLEVEL 2 exit
  echo IF ERRORLEVEL 1 goto serverstart
  echo :serverstart
  echo title %comspec%
  echo StartServer.bat
)>"%FORCEINSTALL%\UpdateServer.bat"
)
goto :eof

:: ══════════════════════════════════════════════════
:: MOD SEÇİMİ - MAIN
:: ══════════════════════════════════════════════════
:modchoice
if '%LANG%'=='1' (
  echo Mod secenekleri:
  echo.
  echo   1: Oxide
  echo   2: Carbon
  echo   3: Vanilla ^(Modsuz^)
  echo.
  set /p MOD="Oxide, Carbon veya Vanilla? ^(1/2/3^): "
) else (
  echo Mod options:
  echo.
  echo   1: Oxide
  echo   2: Carbon
  echo   3: Vanilla ^(No Mods^)
  echo.
  set /p MOD="Install Oxide, Carbon or Vanilla? ^(1/2/3^): "
)
if not '%MOD%'=='' set MOD=%MOD:~0,1%
cls
if '%MOD%'=='1' goto oxideinstall
if '%MOD%'=='2' goto carboninstall
if '%MOD%'=='3' goto mapchoice
if '%LANG%'=='1' (echo Lutfen 1, 2 veya 3 girin.) else (echo Please enter 1, 2 or 3.)
goto modchoice

:: ══════════════════════════════════════════════════
:: MOD SEÇİMİ - STAGING
:: ══════════════════════════════════════════════════
:modchoicestaging
if '%LANG%'=='1' (
  echo Mod secenekleri:
  echo.
  echo   1: Carbon
  echo   2: Vanilla ^(Modsuz^)
  echo.
  set /p MOD="Carbon veya Vanilla? ^(1/2^): "
) else (
  echo Mod options:
  echo.
  echo   1: Carbon
  echo   2: Vanilla ^(No Mods^)
  echo.
  set /p MOD="Install Carbon or Vanilla? ^(1/2^): "
)
if not '%MOD%'=='' set MOD=%MOD:~0,1%
cls
if '%MOD%'=='1' goto carboninstallstaging
if '%MOD%'=='2' goto mapchoice
if '%LANG%'=='1' (echo Lutfen 1 veya 2 girin.) else (echo Please enter 1 or 2.)
goto modchoicestaging

:: ══════════════════════════════════════════════════
:: OXIDE KURULUMU
:: ══════════════════════════════════════════════════
:oxideinstall
if '%LANG%'=='1' (title Oxide kuruluyor...) else (title Installing Oxide...)
curl -SL -A "Mozilla/5.0" "https://umod.org/games/rust/download" --ssl-no-revoke --output "%FORCEINSTALL%"\OxideMod.zip
cd /d "%FORCEINSTALL%"
powershell -command "Expand-Archive -Force OxideMod.zip ./"
del OxideMod.zip

if '%LANG%'=='1' (
(
  echo @echo off
  echo REM UpdateServer.bat
  echo title Sunucu guncelleniyor...
  echo echo Sunucu guncelleniyor...
  echo "%STEAMCMD%"\steamcmd.exe +force_install_dir "%FORCEINSTALL%" +login anonymous +app_update 258550 +quit
  echo echo Rust guncellendi!
  echo pause
  echo curl -SL -A "Mozilla/5.0" "https://umod.org/games/rust/download" --ssl-no-revoke --output "%FORCEINSTALL%"\OxideMod.zip
  echo cd /d "%FORCEINSTALL%"
  echo powershell -command "Expand-Archive -Force OxideMod.zip ./"
  echo del OxideMod.zip
  echo echo Oxide guncellendi!
  echo echo.
  echo choice /c eh /m "Sunucuyu simdi baslatmak istiyor musunuz?: "
  echo IF ERRORLEVEL 2 exit
  echo IF ERRORLEVEL 1 goto serverstart
  echo :serverstart
  echo title %comspec%
  echo StartServer.bat
)>"%FORCEINSTALL%\UpdateServer.bat"
) else (
(
  echo @echo off
  echo REM UpdateServer.bat
  echo title Updating Server...
  echo echo Updating server...
  echo "%STEAMCMD%"\steamcmd.exe +force_install_dir "%FORCEINSTALL%" +login anonymous +app_update 258550 +quit
  echo echo Rust updated!
  echo pause
  echo curl -SL -A "Mozilla/5.0" "https://umod.org/games/rust/download" --ssl-no-revoke --output "%FORCEINSTALL%"\OxideMod.zip
  echo cd /d "%FORCEINSTALL%"
  echo powershell -command "Expand-Archive -Force OxideMod.zip ./"
  echo del OxideMod.zip
  echo echo Oxide updated!
  echo echo.
  echo choice /c yn /m "Do you want to run your server now?: "
  echo IF ERRORLEVEL 2 exit
  echo IF ERRORLEVEL 1 goto serverstart
  echo :serverstart
  echo title %comspec%
  echo StartServer.bat
)>"%FORCEINSTALL%\UpdateServer.bat"
)
cls
if '%LANG%'=='1' (echo Oxide kuruldu!) else (echo Oxide installed!)
echo.
goto mapchoice

:: ══════════════════════════════════════════════════
:: CARBON KURULUMU (MAIN)
:: ══════════════════════════════════════════════════
:carboninstall
if '%LANG%'=='1' (title Carbon kuruluyor...) else (title Installing Carbon...)
curl -SL -A "Mozilla/5.0" "https://github.com/CarbonCommunity/Carbon.Core/releases/download/production_build/Carbon.Windows.Release.zip" --ssl-no-revoke --output "%FORCEINSTALL%"\CarbonMod.zip
cd /d "%FORCEINSTALL%"
powershell -command "Expand-Archive -Force CarbonMod.zip ./"
del CarbonMod.zip

if '%LANG%'=='1' (
(
  echo @echo off
  echo REM UpdateServer.bat
  echo title Sunucu guncelleniyor...
  echo echo Sunucu guncelleniyor...
  echo "%STEAMCMD%"\steamcmd.exe +force_install_dir "%FORCEINSTALL%" +login anonymous +app_update 258550 +quit
  echo echo Rust guncellendi!
  echo echo.
  echo choice /c eh /m "Carbon'u da guncellemek istiyor musunuz?: "
  echo IF ERRORLEVEL 2 goto start
  echo IF ERRORLEVEL 1 goto carbonupdate
  echo :carbonupdate
  echo curl -SL -A "Mozilla/5.0" "https://github.com/CarbonCommunity/Carbon.Core/releases/download/production_build/Carbon.Windows.Release.zip" --ssl-no-revoke --output "%FORCEINSTALL%"\CarbonMod.zip
  echo cd /d "%FORCEINSTALL%"
  echo powershell -command "Expand-Archive -Force CarbonMod.zip ./"
  echo del CarbonMod.zip
  echo echo Carbon guncellendi!
  echo :start
  echo echo.
  echo choice /c eh /m "Sunucuyu simdi baslatmak istiyor musunuz?: "
  echo IF ERRORLEVEL 2 exit
  echo IF ERRORLEVEL 1 goto serverstart
  echo :serverstart
  echo title %comspec%
  echo StartServer.bat
)>"%FORCEINSTALL%\UpdateServer.bat"
) else (
(
  echo @echo off
  echo REM UpdateServer.bat
  echo title Updating Server...
  echo echo Updating server...
  echo "%STEAMCMD%"\steamcmd.exe +force_install_dir "%FORCEINSTALL%" +login anonymous +app_update 258550 +quit
  echo echo Rust updated!
  echo echo.
  echo choice /c yn /m "Do you want to update Carbon now?: "
  echo IF ERRORLEVEL 2 goto start
  echo IF ERRORLEVEL 1 goto carbonupdate
  echo :carbonupdate
  echo curl -SL -A "Mozilla/5.0" "https://github.com/CarbonCommunity/Carbon.Core/releases/download/production_build/Carbon.Windows.Release.zip" --ssl-no-revoke --output "%FORCEINSTALL%"\CarbonMod.zip
  echo cd /d "%FORCEINSTALL%"
  echo powershell -command "Expand-Archive -Force CarbonMod.zip ./"
  echo del CarbonMod.zip
  echo echo Carbon updated!
  echo :start
  echo echo.
  echo choice /c yn /m "Do you want to run your server now?: "
  echo IF ERRORLEVEL 2 exit
  echo IF ERRORLEVEL 1 goto serverstart
  echo :serverstart
  echo title %comspec%
  echo StartServer.bat
)>"%FORCEINSTALL%\UpdateServer.bat"
)
cls
if '%LANG%'=='1' (echo Carbon kuruldu!) else (echo Carbon installed!)
echo.
goto mapchoice

:: ══════════════════════════════════════════════════
:: CARBON KURULUMU (STAGING)
:: ══════════════════════════════════════════════════
:carboninstallstaging
if '%LANG%'=='1' (title Carbon kuruluyor...) else (title Installing Carbon...)
curl -SL -A "Mozilla/5.0" "https://github.com/CarbonCommunity/Carbon.Core/releases/download/production_build/Carbon.Windows.Release.zip" --ssl-no-revoke --output "%FORCEINSTALL%"\CarbonMod.zip
cd /d "%FORCEINSTALL%"
powershell -command "Expand-Archive -Force CarbonMod.zip ./"
del CarbonMod.zip

if '%LANG%'=='1' (
(
  echo @echo off
  echo REM UpdateServer.bat
  echo title Sunucu guncelleniyor...
  echo echo Sunucu guncelleniyor...
  echo "%STEAMCMD%"\steamcmd.exe +force_install_dir "%FORCEINSTALL%" +login anonymous +app_update 258550 -beta staging +quit
  echo echo Rust Staging guncellendi!
  echo choice /c eh /m "Carbon'u da guncellemek istiyor musunuz?: "
  echo IF ERRORLEVEL 2 goto start
  echo IF ERRORLEVEL 1 goto carbonupdate
  echo :carbonupdate
  echo curl -SL -A "Mozilla/5.0" "https://github.com/CarbonCommunity/Carbon.Core/releases/download/production_build/Carbon.Windows.Release.zip" --ssl-no-revoke --output "%FORCEINSTALL%"\CarbonMod.zip
  echo cd /d "%FORCEINSTALL%"
  echo powershell -command "Expand-Archive -Force CarbonMod.zip ./"
  echo del CarbonMod.zip
  echo echo Carbon guncellendi!
  echo :start
  echo echo.
  echo choice /c eh /m "Sunucuyu simdi baslatmak istiyor musunuz?: "
  echo IF ERRORLEVEL 2 exit
  echo IF ERRORLEVEL 1 goto serverstart
  echo :serverstart
  echo title %comspec%
  echo StartServer.bat
)>"%FORCEINSTALL%\UpdateServer.bat"
) else (
(
  echo @echo off
  echo REM UpdateServer.bat
  echo title Updating Server...
  echo echo Updating server...
  echo "%STEAMCMD%"\steamcmd.exe +force_install_dir "%FORCEINSTALL%" +login anonymous +app_update 258550 -beta staging +quit
  echo echo Rust Staging updated!
  echo choice /c yn /m "Do you want to update Carbon now?: "
  echo IF ERRORLEVEL 2 goto start
  echo IF ERRORLEVEL 1 goto carbonupdate
  echo :carbonupdate
  echo curl -SL -A "Mozilla/5.0" "https://github.com/CarbonCommunity/Carbon.Core/releases/download/production_build/Carbon.Windows.Release.zip" --ssl-no-revoke --output "%FORCEINSTALL%"\CarbonMod.zip
  echo cd /d "%FORCEINSTALL%"
  echo powershell -command "Expand-Archive -Force CarbonMod.zip ./"
  echo del CarbonMod.zip
  echo echo Carbon updated!
  echo :start
  echo echo.
  echo choice /c yn /m "Do you want to run your server now?: "
  echo IF ERRORLEVEL 2 exit
  echo IF ERRORLEVEL 1 goto serverstart
  echo :serverstart
  echo title %comspec%
  echo StartServer.bat
)>"%FORCEINSTALL%\UpdateServer.bat"
)
cls
if '%LANG%'=='1' (echo Carbon kuruldu!) else (echo Carbon installed!)
echo.
goto mapchoice

:: ══════════════════════════════════════════════════
:: HARİTA / MAP SEÇİMİ
:: ══════════════════════════════════════════════════
:mapchoice
if '%LANG%'=='1' (
  choice /c eh /m "Ozel harita dosyasi kullanmak istiyor musunuz? "
) else (
  choice /c yn /m "Do you want to use a custom map file? "
)
cls
IF ERRORLEVEL 2 goto startproc
IF ERRORLEVEL 1 goto rusteditchoice

:rusteditchoice
if '%LANG%'=='1' (
  choice /c eh /m "RustEdit DLL kurmak istiyor musunuz? (ozel haritalar icin genellikle gereklidir): "
) else (
  choice /c yn /m "Do you want to install the RustEdit DLL? (usually required for custom maps): "
)
echo.
IF ERRORLEVEL 2 goto startcustom
IF ERRORLEVEL 1 goto rusteditinstall

:rusteditinstall
if '%LANG%'=='1' (title RustEdit DLL kuruluyor...) else (title Installing RustEdit DLL...)
powershell -Command "Invoke-WebRequest https://github.com/k1lly0u/Oxide.Ext.RustEdit/raw/master/Oxide.Ext.RustEdit.dll -OutFile '%FORCEINSTALL%\RustDedicated_Data\Managed\Oxide.Ext.RustEdit.dll'"
cls
if '%LANG%'=='1' (echo RustEdit DLL kuruldu!) else (echo RustEdit DLL installed!)
echo.
goto startcustom

:: ══════════════════════════════════════════════════
:: SUNUCU YAPILANDIRMASI - PROSEDÜREL
:: ══════════════════════════════════════════════════
:startproc
cd /d "%FORCEINSTALL%"
if '%LANG%'=='1' (title Baslangic Dosyasi Olusturuluyor...) else (title Creating Startup File...)

set serverport=28015
set rconport=28016
set queryport=28017
set identity=RustServer
set seed=1337
set worldsize=4500
set maxplayers=150
set hostname=A Simple Rust Server
set description=An unconfigured Rust server.
set rconpw=ChangeThisPlease
set serverurl=
set headerimage=

if '%LANG%'=='1' (
  set /p serverport="Sunucu portu (Varsayilan: 28015): "
  echo.
  set /p rconport="RCON portu (Varsayilan: 28016): "
  echo.
  set /p queryport="Query portu (Varsayilan: 28017): "
  echo.
  echo Kimlik adinda bosluk kullanmayin!
  set /p identity="Sunucu kimligi (Varsayilan: RustServer): "
  echo.
  set /p seed="Harita tohumu (Varsayilan: 1337): "
  echo.
  set /p worldsize="Dunya boyutu (Varsayilan: 4500): "
  echo.
  set /p maxplayers="Maksimum oyuncu (Varsayilan: 150): "
  echo.
  set /p hostname="Sunucu adi (Sunucu listesinde gorunecek isim): "
  echo.
  set /p description="Sunucu aciklamasi: "
  echo.
  set /p rconpw="RCON sifresi (guvenli bir sifre secin!): "
  echo.
  set /p serverurl="Sunucu URL'si (Discord daveti vb. bos birakilabilir): "
  echo.
  echo Header resim linki SADECE resmi icermeli, 1024x512 boyutunda olmali
  set /p headerimage="Sunucu header resmi (bos birakilabilir): "
) else (
  set /p serverport="Server port (Default: 28015): "
  echo.
  set /p rconport="RCON port (Default: 28016): "
  echo.
  set /p queryport="Query port (Default: 28017): "
  echo.
  echo Do not use spaces in the identity name!
  set /p identity="Server identity (Default: RustServer): "
  echo.
  set /p seed="Map seed (Default: 1337): "
  echo.
  set /p worldsize="World size (Default: 4500): "
  echo.
  set /p maxplayers="Max players (Default: 150): "
  echo.
  set /p hostname="Server hostname (How it appears on the server browser): "
  echo.
  set /p description="Server description: "
  echo.
  set /p rconpw="RCON password (make it secure!): "
  echo.
  set /p serverurl="Server URL (e.g. Discord invite, can be blank): "
  echo.
  echo Header image link MUST contain ONLY the picture, at 1024x512 size
  set /p headerimage="Server header image (can be blank): "
)

(
  echo @echo off
  echo :start
  echo RustDedicated.exe -batchmode ^^
  echo -logFile "%identity%_logs.txt" ^^
  echo +server.queryport %queryport% ^^
  echo +server.port %serverport% ^^
  echo +server.level "Procedural Map" ^^
  echo +server.seed %seed% ^^
  echo +server.worldsize %worldsize% ^^
  echo +server.maxplayers %maxplayers% ^^
  echo +server.hostname "%hostname%" ^^
  echo +server.description "%description%" ^^
  echo +server.headerimage "%headerimage%" ^^
  echo +server.url "%serverurl%" ^^
  echo +server.identity "%identity%" ^^
  echo +rcon.port %rconport% ^^
  echo +rcon.password %rconpw% ^^
  echo +rcon.web 1
  echo goto start
)>StartServer.bat

md "%FORCEINSTALL%"\server\%identity%\cfg
cd /d "%FORCEINSTALL%"\server\%identity%\cfg
(echo fps.limit "60")>server.cfg
cd /d "%FORCEINSTALL%"

call :write_wipe_script
cls

if '%LANG%'=='1' (
  choice /c eh /m "Kendinizi sunucuya admin olarak eklemek istiyor musunuz?: "
) else (
  choice /c yn /m "Do you want to add yourself as an admin on the server now?: "
)
cls
IF ERRORLEVEL 2 goto finish
IF ERRORLEVEL 1 goto admin

:: ══════════════════════════════════════════════════
:: SUNUCU YAPILANDIRMASI - ÖZEL HARİTA
:: ══════════════════════════════════════════════════
:startcustom
cd /d "%FORCEINSTALL%"
if '%LANG%'=='1' (title Baslangic Dosyasi Olusturuluyor (Ozel Harita)...) else (title Creating Startup File (Custom Map)...)

set serverport=28015
set rconport=28016
set queryport=28017
set identity=RustServer
set levelurl=https://www.dropbox.com/s/ig1ds1m3q5hnflj/proc_install_1.0.map?dl=1
set maxplayers=150
set hostname=A Simple Rust Server
set description=An unconfigured Rust server.
set rconpw=ChangeThisPlease
set serverurl=
set headerimage=

if '%LANG%'=='1' (
  set /p serverport="Sunucu portu (Varsayilan: 28015): "
  echo.
  set /p rconport="RCON portu (Varsayilan: 28016): "
  echo.
  set /p queryport="Query portu (Varsayilan: 28017): "
  echo.
  echo Kimlik adinda bosluk kullanmayin!
  set /p identity="Sunucu kimligi (Varsayilan: RustServer): "
  echo.
  set /p levelurl="Ozel harita URL'si (Direkt indirme linki olmali!): "
  echo.
  set /p maxplayers="Maksimum oyuncu (Varsayilan: 150): "
  echo.
  set /p hostname="Sunucu adi: "
  echo.
  set /p description="Sunucu aciklamasi: "
  echo.
  set /p rconpw="RCON sifresi: "
  echo.
  set /p serverurl="Sunucu URL'si (bos birakilabilir): "
  echo.
  echo Header resim linki SADECE resmi icermeli, 1024x512 boyutunda olmali
  set /p headerimage="Sunucu header resmi (bos birakilabilir): "
) else (
  set /p serverport="Server port (Default: 28015): "
  echo.
  set /p rconport="RCON port (Default: 28016): "
  echo.
  set /p queryport="Query port (Default: 28017): "
  echo.
  echo Do not use spaces in the identity name!
  set /p identity="Server identity (Default: RustServer): "
  echo.
  set /p levelurl="Custom map URL (Must be a direct download link!): "
  echo.
  set /p maxplayers="Max players (Default: 150): "
  echo.
  set /p hostname="Server hostname: "
  echo.
  set /p description="Server description: "
  echo.
  set /p rconpw="RCON password: "
  echo.
  set /p serverurl="Server URL (can be blank): "
  echo.
  echo Header image link MUST contain ONLY the picture, at 1024x512 size
  set /p headerimage="Server header image (can be blank): "
)

(
  echo @echo off
  echo :start
  echo RustDedicated.exe -batchmode ^^
  echo -logFile "%identity%_logs.txt" ^^
  echo -levelurl "%levelurl%" ^^
  echo +server.queryport %queryport% ^^
  echo +server.port %serverport% ^^
  echo +server.maxplayers %maxplayers% ^^
  echo +server.hostname "%hostname%" ^^
  echo +server.description "%description%" ^^
  echo +server.headerimage "%headerimage%" ^^
  echo +server.url "%serverurl%" ^^
  echo +server.identity "%identity%" ^^
  echo +rcon.port %rconport% ^^
  echo +rcon.password %rconpw% ^^
  echo +rcon.web 1
  echo goto start
)>StartServer.bat

md "%FORCEINSTALL%"\server\%identity%\cfg
cd /d "%FORCEINSTALL%"\server\%identity%\cfg
(echo fps.limit "60")>server.cfg
cd /d "%FORCEINSTALL%"

call :write_wipe_script
cls

if '%LANG%'=='1' (
  choice /c eh /m "Kendinizi sunucuya admin olarak eklemek istiyor musunuz?: "
) else (
  choice /c yn /m "Do you want to add yourself as an admin on the server now?: "
)
cls
IF ERRORLEVEL 2 goto finish
IF ERRORLEVEL 1 goto admin

:: ══════════════════════════════════════════════════
:: WIPE SCRIPT YAZICI
:: ══════════════════════════════════════════════════
:write_wipe_script
if '%LANG%'=='1' (
(
  echo @echo off
  echo REM WipeServer.bat
  echo echo Bu arac sunucunuzu silecektir. Devam etmek istediginizden emin olun.
  echo echo.
  echo pause
  echo echo.
  echo choice /c eh /m "Blueprint'leri de silmek istiyor musunuz?: "
  echo IF ERRORLEVEL 2 goto wipemap
  echo IF ERRORLEVEL 1 goto wipebp
  echo :wipebp
  echo echo.
  echo echo UYARI: HARITA, OYUNCU VE BLUEPRINT VERILERI SILINECEK!
  echo pause
  echo echo.
  echo cd /d server/%identity%
  echo del *.sav
  echo del *.sav.*
  echo del *.map
  echo del *.db
  echo del *.db-journal
  echo del *.db-wal
  echo goto finishbp
  echo :wipemap
  echo echo.
  echo echo UYARI: HARITA VE OYUNCU VERILERI SILINECEK!
  echo pause
  echo echo.
  echo cd /d server/%identity%
  echo del *.sav
  echo del *.sav.*
  echo del *.map
  echo del player.deaths.*
  echo del player.identities.*
  echo del player.states.*
  echo del player.tokens.*
  echo del sv.files.*
  echo goto finishmap
  echo :finishbp
  echo echo.
  echo echo Sunucu Harita ve BP Silindi!
  echo echo Harita tohumunu baslangic dosyanizda guncellemeyi unutmayin!
  echo echo Gerekli eklenti verilerini silmeyi unutmayin!
  echo echo.
  echo pause
  echo exit
  echo :finishmap
  echo echo.
  echo echo Sunucu Harita Silindi!
  echo echo Harita tohumunu baslangic dosyanizda guncellemeyi unutmayin!
  echo echo Gerekli eklenti verilerini silmeyi unutmayin!
  echo echo.
  echo pause
)>WipeServer.bat
) else (
(
  echo @echo off
  echo REM WipeServer.bat
  echo echo This will wipe your server. Make sure you want to continue.
  echo echo.
  echo pause
  echo echo.
  echo choice /c yn /m "Do you want to wipe Blueprints?: "
  echo IF ERRORLEVEL 2 goto wipemap
  echo IF ERRORLEVEL 1 goto wipebp
  echo :wipebp
  echo echo.
  echo echo WARNING: THIS WILL WIPE MAP, PLAYER AND BLUEPRINT DATA!
  echo pause
  echo echo.
  echo cd /d server/%identity%
  echo del *.sav
  echo del *.sav.*
  echo del *.map
  echo del *.db
  echo del *.db-journal
  echo del *.db-wal
  echo goto finishbp
  echo :wipemap
  echo echo.
  echo echo WARNING: THIS WILL WIPE MAP AND PLAYER DATA!
  echo pause
  echo echo.
  echo cd /d server/%identity%
  echo del *.sav
  echo del *.sav.*
  echo del *.map
  echo del player.deaths.*
  echo del player.identities.*
  echo del player.states.*
  echo del player.tokens.*
  echo del sv.files.*
  echo goto finishmap
  echo :finishbp
  echo echo.
  echo echo Server has been Map and BP Wiped!
  echo echo Be sure to change your map seed in your startup batch file!
  echo echo Don't forget to delete any necessary plugin data!
  echo echo.
  echo pause
  echo exit
  echo :finishmap
  echo echo.
  echo echo Server has been Map Wiped!
  echo echo Be sure to change your map seed in your startup batch file!
  echo echo Don't forget to delete any necessary plugin data!
  echo echo.
  echo pause
)>WipeServer.bat
)
goto :eof

:: ══════════════════════════════════════════════════
:: ADMİN EKLEME / ADD ADMIN
:: ══════════════════════════════════════════════════
:admin
set steamid=12345678901234567
if '%LANG%'=='1' (
  echo Steam ID'nizi bilmiyorsaniz: https://www.businessinsider.com/how-to-find-steam-id
  echo.
  echo Admin bilgileri burada saklanir: %FORCEINSTALL%\server\%identity%\cfg
  echo.
  set /p steamid="Steam64 ID'nizi girin: "
) else (
  echo If you do not know your SteamID: https://www.businessinsider.com/how-to-find-steam-id
  echo.
  echo Admin info is stored at: %FORCEINSTALL%\server\%identity%\cfg
  echo.
  set /p steamid="Enter your Steam64 ID: "
)
cd /d "%FORCEINSTALL%"\server\%identity%\cfg
(echo ownerid %steamid% "unknown" "no reason")>users.cfg
cls
goto finish

:: ══════════════════════════════════════════════════
:: BİTİŞ / FINISH
:: ══════════════════════════════════════════════════
:finish
if '%LANG%'=='1' (
  echo Her sey hazir! Asagidaki dosyalar %FORCEINSTALL% dizininde olusturuldu:
  echo.
  echo   StartServer.bat   - Sunucuyu baslatir.
  echo   UpdateServer.bat  - Sunucuyu gunceller (Oxide varsa onu da).
  echo   WipeServer.bat    - Sunucuyu siler (harita veya BP+harita secenegiyle).
  echo.
  choice /c eh /m "Sunucuyu simdi baslatmak istiyor musunuz?: "
) else (
  echo All done! The following files were created in %FORCEINSTALL%:
  echo.
  echo   StartServer.bat   - Launch your server.
  echo   UpdateServer.bat  - Update your server (and Oxide if installed).
  echo   WipeServer.bat    - Wipe your server (map or full BP wipe).
  echo.
  choice /c yn /m "Do you want to run your new server now?: "
)
echo.
IF ERRORLEVEL 2 exit
IF ERRORLEVEL 1 goto serverstart

:serverstart
cd /d "%FORCEINSTALL%"
StartServer.bat
