## ASUS UX32VD

### Info

#### Common Problems in 10.13 High Sierra: [tonymacx86.com](https://www.tonymacx86.com/threads/readme-common-problems-in-10-13-high-sierra.233582/)

#### Laptop Frequent Questions: [tonymacx86.com](https://www.tonymacx86.com/threads/faq-read-first-laptop-frequent-questions.164990/)

### Install High Sierra

#### 1. Make Clover USB-Drive

##### a) Preparation
- Format USB-Drive with GUID and HFS+
	- Find the correct disk number of USB-Drive:
	```
	diskutil list
	```
	- Replace {#} with corresponding disk number and {Volume} with desired Name:
	```
	diskutil partitionDisk /dev/disk{#} 1 GPT HFS+ {Volume} R
	```
- Download Clover: [sourceforge.net](https://sourceforge.net/projects/cloverefiboot/)

##### b) Clover Install [clover-wiki](https://clover-wiki.zetam.org/Installation)
- Install Clover r4497
	- Select USB-Drive as install target
	- Open custom install settings
		- Select `Install Clover in the ESP`
		- As Bootloader select `Install boot0ss in MBR`
    	- Select Drivers64
    	- Select Drivers64UEFI
	- Install

##### c) Post Install
- Copy DSDT.aml and SSDT.aml from/to `EFI/CLOVER/ACPI/patched/`
- Rename existing config.plist to config-org.plist in `EFI/CLOVER/`
- Copy config.plist from/to `EFI/CLOVER/`
- Copy only missing drivers from/to `EFI/CLOVER/drivers64/`
- Copy only missing drivers from/to `EFI/CLOVER/drivers64UEFI/` (apfs.efi is important!!!)
- Delete all 10.X folders from `EFI/CLOVER/kexts/`
- Copy High Sierra compatible kexts from/to `EFI/CLOVER/kexts/other/`
- Download High-Sierra-Boot-Theme: [github.com/hirakujira](https://github.com/hirakujira/High-Sierra-Boot-Theme)
- Copy High Sierra Theme to `EFI/CLOVER/themes/`

#### 2. Make High Sierra USB-Drive
- Download UniBeast 8.1.0: [tonymacx86.com](https://www.tonymacx86.com/resources/unibeast-8-1-0.353/)
- UniBeast: Install macOS High Sierra on Any Supported Intel-based PC: [tonymacx86.com](https://www.tonymacx86.com/threads/unibeast-install-macos-high-sierra-on-any-supported-intel-based-pc.235474/)
- Change System Language to English
- Format USB-Drive with GUID and HFS+ Journaled
	- Find the correct disk number of USB-Drive:
	```
	diskutil list
	```
	- Replace {#} with corresponding disk number and {Volume} with desired Name:
	```
	sudo diskutil partitionDisk /dev/disk{#} GPT JHFS+ {Volume} R
	```
- Perform install with UniBeast 8.1.0

#### 3. Install Clover in EFI partition on High Sierra
- Repeat steps 1b - 1c but with High Sierra disk as target


### Update High Sierra
- Make a full backup
- Check [hackintosher.com](https://hackintosher.com/guides/) for the latest OS X Update Guide
- Check all kexts for updates
- Make a new Clover USB-Drive for testing purpose
	- Use updated kexts and drivers in post install (apfs.efi and lilu.kext)
- Boot from new Clover USB-Drive
- If system boots
	- Mount High Sierra EFI partition
	- Backup `EFI` to `EFI-Backups`
	- Install new Clover version to EFI partition
	- Copy updated kexts and drivers during post install
	- Don't forget to copy `Microsoft` folder (it contains the windows bootloader)
- Eject USB-Drive and reboot
- If system boots
	- Start High Sierra Update
	- On restart select newly added `Install OS X ...` partition
	- Disable all BCRM kexts to prevent loop at the end of boot
	- After reboot select normal High Sierra partition
- If system boots
	- Be happy and enjoy the new update
- If system doesn't boot on one of these steps 
	- Try to fix the problem or revert to the latest backup

### Post Install

#### Download Clover Configurator: [Link](http://mackie100projects.altervista.org/download-clover-configurator/)

#### Download Kext Utility: [Link](http://cvad-mac.narod.ru/index/0-4)


### SSDT
Generate your SSDT with [ssdtPRGen.sh](https://github.com/Piker-Alpha/ssdtPRGen.sh)
<br>-x 1 is for SandyBridge CPU
<br>-lmf 900 sets lowest idle frequency to 900 mhz
```
./ssdtPRGen.sh -x 1 -lfm 900
```
Copy `/Users/{Name}/Library/ssdtPRGen/ssdt.aml` to `EFI/CLOVER/ACPI/patched/`
Replace existing file, rename it to `SSDT.aml`

### Kexts

#### AzureWave Broadcom BCM94352HMB/BCM94352 WLAN+BT4.0 macOS Sierra 10.12.1: [forum.osxlatitude.com](http://forum.osxlatitude.com/index.php?/topic/9414-azurewave-broadcom-bcm94352hmbbcm94352-wlanbt40-macos-sierra-10121/)

#### WiFi:
Copy latest LiLu.kext (requires v1.2.0) to EFI/CLOVER/kexts/other: [github.com](https://github.com/vit9696/Lilu/releases)

Copy AirportBrcmFixup.kext to kexts folder: [sourceforge.net](https://sourceforge.net/projects/airportbrcmfixup/files/)

Add following entries to EFI/CLOVER/config.plist:
- ACPI > Fixes > AddDTGP
- ACPI > Fixes > FixAirport
- Devices > Fake ID > WIFI =  0x43a014E4

#### Bluetooth:
Copy BrcmFirmwareRepo.kext and BrcmPatchRAM2.kext to EFI/CLOVER/kexts/other: [forum.osxlatitude.com](http://forum.osxlatitude.com/index.php?app=core&module=attach&section=attach&attach_id=12117)


### Kext Ressources:

Broadcom BCM4352 802.11 ac wifi and bluetooth combo card: [forum.osxlatitude.com](http://forum.osxlatitude.com/index.php?/topic/2767-broadcom-bcm4352-80211-ac-wifi-and-bluetooth-combo-card/)

ACPIBatteryManager.kext: [bitbucket.org/RehabMan](https://bitbucket.org/RehabMan/os-x-acpi-battery-driver/downloads/)

*Needed?* AppleIntelE1000e.kext: [sourceforge.net](https://sourceforge.net/projects/osx86drivers/)

ApplePS2SmartTouchPad.kext: [forum.osxlatitude.com](http://forum.osxlatitude.com/index.php?/topic/1948-elan-focaltech-and-synaptics-smart-touchpad-driver-mac-os-x/)

AsusNBFnKeys.kext: [forum.osxlatitude.com](http://forum.osxlatitude.com/index.php?/topic/1968-fn-hotkey-and-als-sensor-driver-for-asus-notebooks/)

AtherosE2200Ethernet.kext: [insanelymac.com](http://www.insanelymac.com/forum/files/file/313-atherose2200ethernet/)

FakeSMC: [bitbucket.org/RehabMan](https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/)

NullCPUPowerManagement.kext: [tonymacx86.com](https://www.tonymacx86.com/resources/nullcpupowermanagement.268/)

*Needed?* RealtekRTL8111.kext: [bitbucket.org/RehabMan](https://bitbucket.org/RehabMan/os-x-realtek-network/downloads/)

VoodooHDA + AppleHDADisabler: [sourceforge.net](https://sourceforge.net/projects/voodoohda/files/), [hackintosh.zone](https://www.hackintosh.zone/file/1023-voodoohda-290d10/)

Deprecated:

BTFirmwareUploader.kext: [forum.osxlatitude.com](http://forum.osxlatitude.com/index.php?/topic/2925-bluetooth-firmware-uploader/)

KextToPatch Einträge für High Sierra: [hackintosh-forum.de](https://www.hackintosh-forum.de/index.php/Thread/28676-Neue-Clover-KextsToPatch-Eintr%C3%A4ge-f%C3%BCr-Sierra-High-Sierra/)