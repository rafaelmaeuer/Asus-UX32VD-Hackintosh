## ASUS UX32VD

### Info

Guide how to install macOS Catalina on ASUS UX32VD

- macOS version: 10.15.3
- clover version: 2.5k r5104

#### Laptop Frequent Questions: [tonymacx86.com](https://www.tonymacx86.com/threads/faq-read-first-laptop-frequent-questions.164990/)

---

#### BIOS

- Use version 214
- Check for correct settings

```sh
Basic
- Intel Virtualization Technology [Enabled]
- Intel AES-NI [Enabled]
- VT-d [Enabled]

SATA
- SATA Mode Selection [AHCI]

Graphics
- DVMT Pre-Allocated [64M]

Intel
- Intel(R) Anti-Theft Technology [Enabled]

USB
- Legacy USB Support [Enabled]
- XHCI Pre-Boot Mode [Disabled]

Network
- Network Stack [Disabled]
```

#### Hardware

This Hackintosh is based on an ASUS UX32VD-R4002V Laptop, with an Intel Core i7-3517U Processor and a NVIDIA GeForce GT 620M graphics card.

##### RAM

The default 2GB RAM module was replaced with an equivalent 8GB module to get 10GB of RAM.

##### WIFI / Bluetooth

As the default WiFi/BT card is not supported by macOS, it is replaced by a [Broadcom BCM4352 Combo card](https://osxlatitude.com/forums/topic/2767-broadcom-bcm4352-80211-ac-wifi-and-bluetooth-combo-card/).
<br>Notice that antenna-adapters are needed when replacing the default card due to different connector sizes ([link](http://forum.notebookreview.com/threads/upgrading-asus-ux32vd-wireless-card-antenna-connector-problem-help.731735/)).

##### Ethernet

The default USB-ethernet adapter was replaced with a [UGREEN 20256 Adapter](https://www.ugreen.com/product/UGREEN_Network_Adapter_USB_to_Ethernet_RJ45_Lan_Gigabit_Adapter_for_Ethernet_Black-en.html) after it stopped working.
Benefits of the new adapter are USB3 and Gigabit speed.

---

### Install macOS

#### 1. Create Clover Drive

##### a) Preparation

- Format USB-Drive with GUID and FAT32
  - Find the correct disk number of USB-Drive:

        diskutil list

  - Replace {#} with corresponding disk number and {Volume} with desired Name:

        diskutil partitionDisk /dev/disk{#} 1 GPT FAT32 {Volume} R

- Download Clover: [github.com/CloverHackyColor](https://github.com/CloverHackyColor/CloverBootloader/releases)

##### b) Install Clover [clover-wiki](https://clover-wiki.zetam.org/Installation)

- Follow this guide [Create a MacOS Catalina 10.15.0 USB Installer Drive w/Clover](https://hackintosher.com/forums/thread/guide-how-to-create-a-macos-catalina-10-15-0-usb-installer-drive-w-clover.2836/) Section `IV. Install Clover Bootloader into the USB Installer Flash Drive's EFI Boot Partition`

##### c) Post Install

- Copy DSDT.aml and SSDT.aml from/to `EFI/CLOVER/ACPI/patched/`
- Rename existing config.plist to config-org.plist in `EFI/CLOVER/`
- Copy config.plist from/to `EFI/CLOVER/`
- Delete all 10.X folders from `EFI/CLOVER/kexts/`
- Copy all necessary kexts from/to `EFI/CLOVER/kexts/other/`
- (Optional: Copy favorite theme to `EFI/CLOVER/themes`)

#### 2. Create macOS Installer Drive

To create a working macOS Installer boot drive, you will need the following:
- An empty USB flash drive (minimum 16GB)  
  (Chose USB2 or you need an USB2 cable to avoid USBSMC-Error)
- A device already running macOS with access to the App Store

##### a) Download macOS Installer

- Open the Mac App Store on your device already running macOS
- Download `Install macOS Catalina` application
- Close when it opens automatically

##### b) Create Installer Stick

- Use [DiskMaker X](https://diskmakerx.com/) or [Install Disk Creator](https://macdaddy.io/install-disk-creator/) to create macOS Install Drive

---

#### 3. Install macOS

- Connect macOS Installer and Clover Drive to your UX32VD
- Boot from Clover drive and select macOS Installer (`Install macOS Catalina`)
- Once installer shows up, follow the installation instructions
- On reboot select Macintosh HD in Clover (`Macintosh HD`)
- Create user account and finish setup process

---

#### 4. Post Installation

##### a) Install Clover in EFI partition of Macintosh HD

- After successfully install repeat steps 1b - 1c but with EFI on Macintosh HD as target
- Follow this guide to add clover boot entry in BIOS [Restoring UEFI boot entry](https://www.thomas-krenn.com/en/wiki/Restoring_UEFI_boot_entry_via_motherboard_replacement_or_BIOS_update) or this [UEFI clover boot option](https://www.tonymacx86.com/threads/solved-uefi-clover-boot-option-gone-after-bios-update.211715/#post-1409404)

##### b) Enable TRIM for SSD

There are two options:

- Run following command in the terminal:
  
  `sudo trimforce enable`

- Patch kext with clover configurator:

  ```sh
  com.apple.iokit.IOAHCIBlockStorage

  00415050 4C452053 534400
  00000000 00000000 000000
  ```

---

### Troubleshooting

- When getting `Error loading kernel cache` reboot until it passes

- On USBSMC Error check if your Installer-Stick is USB3, use an USB2 cable then

- If EFI partition is messed up and boot only works in safe mode, mount EFI with:

  ```sh
  sudo mkdir /kexts
  sudo cp -RX /System/Library/Extensions/msdosfs.kext /kexts
  sudo /usr/libexec/PlistBuddy -c "Add :OSBundleRequired string" /kexts/msdosfs.kext/Contents/Info.plist
  sudo /usr/libexec/PlistBuddy -c "Set :OSBundleRequired \"Safe Boot\"" /kexts/msdosfs.kext/Contents/Info.plist
  ```

---

### Update Clover

Update with Clover Configurator or download latest `CLOVERX64.efi` from [github.com/CloverHackyColor](https://github.com/CloverHackyColor/CloverBootloader/releases) and replace in `EFI/CLOVER`

### Update macOS

- Make a full backup
- Check [hackintosher.com](https://hackintosher.com/guides/) for the latest macOS Update Guide
- Check all kexts for updates
- Create a new Clover Drive for testing purpose
  - Use updated kexts and drivers in post install
- Boot from new Clover Drive
- If system boots
  - Mount EFI partition of Macintosh HD
  - Backup `EFI` to `EFI-Backups`
  - Install new Clover version to EFI partition
  - Copy updated kexts and drivers during post install
  - Don't forget to copy `Microsoft` and `Ubuntu` folder (it contains the windows and ubuntu bootloader)
- Eject Clover Drive and reboot
- If system boots
  - Start macOS Update
  - On restart select newly added `Install macOS Catalina` partition
  - After reboot select normal Macintosh HD partition
- If system boots
  - Be happy and enjoy the new update
- If system doesn't boot on one of these steps
  - Try to fix the problem or revert to the latest backup

---

## Resources

### SSDT

Generate your SSDT with [ssdtPRGen.sh](https://github.com/Piker-Alpha/ssdtPRGen.sh)  
-x 1 is for Ivy Bridge CPU  
-lmf 900 sets lowest idle frequency to 900 mhz

    ./ssdtPRGen.sh -x 1 -lfm 900

Copy `/Users/{Name}/Library/ssdtPRGen/ssdt.aml` to `EFI/CLOVER/ACPI/patched/`
Replace existing file, rename it to `SSDT.aml`

### DSDT

Generation of DSDT is not covered by this tutorial, have a look at: [danieleds/Asus-UX32VD-Hackintosh](https://github.com/danieleds/Asus-UX32VD-Hackintosh/tree/master/src/DSDT)

---

### Kexts

#### Kext Patch: [acidanthera/Lilu](https://github.com/acidanthera/Lilu/releases)

- Lilu.kext

#### WiFi: [acidanthera/AirportBrcmFixup](https://github.com/acidanthera/AirportBrcmFixup/releases)

- AirportBrcmFixup.kext

#### WiFi: [RehabMan/OS-X-Fake-PCI-ID](https://bitbucket.org/RehabMan/os-x-fake-pci-id/downloads/)

- FakePCIID.kext
- FakePCIID_Broadcom_WiFi.kext

#### Bluetooth: [RehabMan/OS-X-BrcmPatchRAM](https://bitbucket.org/RehabMan/os-x-brcmpatchram/downloads/)

- BrcmFirmwareData.kext
- BrcmPatchRAM2.kext

#### Battery: [RehabMan/OS-X-ACPI-Battery-Driver](https://bitbucket.org/RehabMan/os-x-acpi-battery-driver/downloads/)

- ACPIBatteryManager.kext

#### Sensors: [RehabMan/OS-X-FakeSMC-kozlek](https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/)

- FakeSMC.kext
- FakeSMC_ACPISensors.kext
- FakeSMC_CPUSensors.kext
- FakeSMC_GPUSensors.kext
- FakeSMC_LPCSensors.kext
- FakeSMC_SMMSensors.kext

#### CPU: [tonymacx86/NullCPUPowerManagement](https://www.tonymacx86.com/resources/nullcpupowermanagement.268/)

- NullCPUPowerManagement.kext

#### Audio: [SourceForge/VoodooHDA](https://sourceforge.net/projects/voodoohda/)

- VoodooHDA.kext

#### TouchPad: [EMlyDinEsH/Smart-Touchpad-Driver](http://forum.osxlatitude.com/index.php?/topic/1948-elan-focaltech-and-synaptics-smart-touchpad-driver-mac-os-x/)

- ApplePS2SmartTouchPad.kext

#### FN-Keys: [EMlyDinEsH/ASUS-FN-ALS-Sensor-Driver](http://forum.osxlatitude.com/index.php?/topic/1968-fn-hotkey-and-als-sensor-driver-for-asus-notebooks/)

- AsusNBFnKeys.kext

#### USB 3.0: [RehabMan/os-x-usb-inject-all](https://bitbucket.org/RehabMan/os-x-usb-inject-all/downloads/)

- USBInjectAll.kext

---

### Driver

- ASIX USB 2.0 to 10/100M Fast Ethernet Controller [AX88772B Driver](https://www.asix.com.tw/download.php?PItemID=105&sub=driverdetail)

- Ugreen USB 3.0 Gigabit Ethernet Adapter [AX88179 Driver](https://www.ugreen.com/drivers/217-en.html)

---

### Tools

- [Clover Configurator](http://mackie100projects.altervista.org/download-clover-configurator/)
- [Hackintool](https://www.tonymacx86.com/threads/release-hackintool-v2-8-6.254559/)
