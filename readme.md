## ASUS UX32VD

### Info

#### Common Problems in 10.13 High Sierra:
https://www.tonymacx86.com/threads/readme-common-problems-in-10-13-high-sierra.233582/

#### Laptop Frequent Questions:
https://www.tonymacx86.com/threads/faq-read-first-laptop-frequent-questions.164990/

### Install High Sierra

#### 1. Make Clover USB Stick

##### a) Preparation
- Format USB-Stick with GUID and HFS+
	- Find the correct disk number of USB-Stick:
	```
	diskutil list
	```
	- Replace {#} with corresponding disk number and {Volume} with desired Name:
	```
	diskutil partitionDisk /dev/disk{#} 1 GPT HFS+ {Volume} R
	```
- Download Clover: https://sourceforge.net/projects/cloverefiboot/

##### b) Clover Install
- Install Clover r4497
	- Select USB-Stick as install target
	- Open custom install settings
		- Select `Install Clover in ESP`
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
- Download High-Sierra-Boot-Theme: https://github.com/hirakujira/High-Sierra-Boot-Theme
- Copy High Sierra Theme to `EFI/CLOVER/themes/`


#### 2. Make High Sierra USB Stick
- Download UniBeast 8.1.0: https://www.tonymacx86.com/resources/unibeast-8-1-0.353/ 
- UniBeast: Install macOS High Sierra on Any Supported Intel-based PC: https://www.tonymacx86.com/threads/unibeast-install-macos-high-sierra-on-any-supported-intel-based-pc.235474/
- Change System Language to English
- Format USB-Stick with GUID and HFS+ Journaled
	- Find the correct disk number of USB-Stick:
	```
	diskutil list
	```
	- Replace {#} with corresponding disk number and {Volume} with desired Name:
	```
	sudo diskutil partitionDisk /dev/disk{#} GPT JHFS+ {Volume} R
	```
- Make Install with UniBeast 8.1.0

#### 3. Install Clover in EFI partition on High Sierra
- Repeat steps 1b - 1c but with High Sierra disk as target

### Post Install

#### Download Clover Configurator:
http://mackie100projects.altervista.org/download-clover-configurator/

#### Download Kext Utility:
http://cvad-mac.narod.ru/index/0-4

### Kexts

#### AzureWave Broadcom BCM94352HMB/BCM94352 WLAN+BT4.0 macOS Sierra 10.12.1:
http://forum.osxlatitude.com/index.php?/topic/9414-azurewave-broadcom-bcm94352hmbbcm94352-wlanbt40-macos-sierra-10121/

#### WiFi:
Copy latest LiLu.kext (requires v1.2.0) to EFI/CLOVER/kexts/other:
https://github.com/vit9696/Lilu/releases

Copy AirportBrcmFixup.kext to kexts folder:
https://sourceforge.net/projects/airportbrcmfixup/files/

Add following entries to EFI/CLOVER/config.plist:
- ACPI > Fixes > AddDTGP
- ACPI > Fixes > FixAirport
- Devices > Fake ID > WIFI =  0x43a014E4

#### Bluetooth:
Copy BrcmFirmwareRepo.kext and BrcmPatchRAM2.kext to EFI/CLOVER/kexts/other:
http://forum.osxlatitude.com/index.php?app=core&module=attach&section=attach&attach_id=12117


### Kext Ressources:

Broadcom BCM4352 802.11 ac wifi and bluetooth combo card
http://forum.osxlatitude.com/index.php?/topic/2767-broadcom-bcm4352-80211-ac-wifi-and-bluetooth-combo-card/

ACPIBatteryManager.kext
https://bitbucket.org/RehabMan/os-x-acpi-battery-driver/downloads/

Needed? AppleIntelE1000e.kext
https://sourceforge.net/projects/osx86drivers/

ApplePS2SmartTouchPad.kext
http://forum.osxlatitude.com/index.php?/topic/1948-elan-focaltech-and-synaptics-smart-touchpad-driver-mac-os-x/

AsusNBFnKeys.kext
http://forum.osxlatitude.com/index.php?/topic/1968-fn-hotkey-and-als-sensor-driver-for-asus-notebooks/

AtherosE2200Ethernet.kext
http://www.insanelymac.com/forum/files/file/313-atherose2200ethernet/

FakeSMC
https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/

NullCPUPowerManagement.kext
https://www.tonymacx86.com/resources/nullcpupowermanagement.268/

Needed? RealtekRTL8111.kext
https://bitbucket.org/RehabMan/os-x-realtek-network/downloads/

VoodooHDA + AppleHDADisabler
https://sourceforge.net/projects/voodoohda/files/
https://www.hackintosh.zone/file/1023-voodoohda-290d10/

Deprecated:

BTFirmwareUploader.kext
http://forum.osxlatitude.com/index.php?/topic/2925-bluetooth-firmware-uploader/

KextToPatch Einträge für High Sierra:
https://www.hackintosh-forum.de/index.php/Thread/28676-Neue-Clover-KextsToPatch-Eintr%C3%A4ge-f%C3%BCr-Sierra-High-Sierra/