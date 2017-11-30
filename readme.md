## ASUS UX32VD

### Info

#### Common Problems in 10.13 High Sierra:
https://www.tonymacx86.com/threads/readme-common-problems-in-10-13-high-sierra.233582/

#### Laptop Frequent Questions:
https://www.tonymacx86.com/threads/faq-read-first-laptop-frequent-questions.164990/

### Install High Sierra

Make Clover USB Stick:
- Format USB-Stick with MBR and FAT
- Download Clover: https://sourceforge.net/projects/cloverefiboot/
- Install Clover r4318
    - Select all Drivers in Setup (Drivers64 and Drivers64UEFI)
- Copy High Sierra compatible kexts to EFI/CLOVER/kexts/other/
- Copy DSDT.aml and SSDT.aml to EFI/CLOVER/ACPI/patched/
- Copy config.plist to EFI/CLOVER/
- Download High-Sierra-Boot-Theme: https://github.com/hirakujira/High-Sierra-Boot-Theme
- Copy copy High Sierra Theme to EFI/CLOVER/themes/

Make APFS Partition Bootable:
- mount /Applications/Install\ macOS\ High\ Sierra.app/Contents/SharedSupport/BaseSystem.dmg
- copy /Volumes/OS\ X\ Base\ System/usr/standalone/i386/apfs.efi to EFI/CLOVER/drivers64UEFI/

Make High Sierra USB Stick:
- Download UniBeast 8.1.0: https://www.tonymacx86.com/resources/unibeast-8-1-0.353/ 
- UniBeast: Install macOS High Sierra on Any Supported Intel-based PC: https://www.tonymacx86.com/threads/unibeast-install-macos-high-sierra-on-any-supported-intel-based-pc.235474/
- Change System Language to English
- Format USB Stick with
	sudo diskutil partitionDisk {/dev/disk2} GPT JHFS+ {Volume} R
- Install with UniBeast 8.1.0

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