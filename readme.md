## ASUS UX32VD

### Info

Guide how to install OS X Mojave on ASUS UX32VD

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

As the default WiFi/BT card is not supported by OS X, it is replaced by a [Broadcom BCM4352 Combo card](https://osxlatitude.com/forums/topic/2767-broadcom-bcm4352-80211-ac-wifi-and-bluetooth-combo-card/).
<br>Notice that antenna-adapters are needed when replacing the default card due to different connector sizes ([link](http://forum.notebookreview.com/threads/upgrading-asus-ux32vd-wireless-card-antenna-connector-problem-help.731735/)).

##### Ethernet

The default USB-ethernet adapter was replaced with a [UGREEN 20256 Adapter](https://www.ugreen.com/product/UGREEN_Network_Adapter_USB_to_Ethernet_RJ45_Lan_Gigabit_Adapter_for_Ethernet_Black-en.html) after it stopped working.
Benefits of the new adapter are USB3 and Gigabit speed.

---

### Install OS X

#### 1. Create Clover USB-Drive

##### a) Preparation

- Format USB-Drive with GUID and HFS+
  - Find the correct disk number of USB-Drive:

  ```sh
  diskutil list
  ```

  - Replace {#} with corresponding disk number and {Volume} with desired Name:

  ```sh
  diskutil partitionDisk /dev/disk{#} 1 GPT HFS+ {Volume} R
  ```

- Download Clover: [sourceforge.net](https://sourceforge.net/projects/cloverefiboot/)

##### b) Install Clover [clover-wiki](https://clover-wiki.zetam.org/Installation)

- Install Clover r4798
  - Select USB-Drive as install target
  - Open custom install settings
    - Select `Install Clover in the ESP`
    - At Boot Sectors select `Install boot0ss in MBR`
    - Select `Clover for BIOS (legacy) booting`
    - Select `BIOS Drivers, 64 bit`
    - Select `UEFI Drivers`
  - Install

##### c) Post Install

- Copy DSDT.aml and SSDT.aml from/to `EFI/CLOVER/ACPI/patched/`
- Rename existing config.plist to config-org.plist in `EFI/CLOVER/`
- Copy config.plist from/to `EFI/CLOVER/`
- Delete all 10.X folders from `EFI/CLOVER/kexts/`
- Copy Mojave compatible kexts from/to `EFI/CLOVER/kexts/other/`

#### 2. Create OS X USB-Drive

To create a working macOS Mojave installer boot drive, you will need the following:
- A free USB flash drive (minimum 8GB)
- A device already running OS X with access to the App Store

##### a) Download OS X Installer

- Open the Mac App Store on your device already running OS X
- Download `Install macOS Mojave` application
- Close when it opens automatically

##### b) Format USB flash drive

- Insert USB flash drive
- Open Disk Utility and format flash drive
  - Select `GUID` as partition scheme
  - Select `Mac OS Extended (Journaled)` as file format

##### c) Create Installer

- Use [DiskMaker X](https://diskmakerx.com/) or [Install Disk Creator](https://macdaddy.io/install-disk-creator/) to create OS X USB-Drive

#### 3. Install Clover in EFI partition on Mojave

- Repeat steps 1b - 1c but with Mojave disk as target

---

#### 3. Install OS X

- Connect Mojave USB drive and Clover USB drive to your target machine
- Boot from Clover USB drive and select Mojave USB drive (`Install OS X Mojave`)
- Once installer shows up, follow the installation instructions
- On reboot select the OS X disk in Clover (`OS X Mojave`)
- Create user account and finish setup process

---

#### 4. Post Installation

##### a) Install Clover in EFI partition of OS X disk

- After successfully install repeat steps 1b - 1c but with EFI on OS X disk as target
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

- If EFI partition is messed up and boot only works in safe mode, mount EFI with:

  ```sh
  sudo mkdir /kexts
  sudo cp -RX /System/Library/Extensions/msdosfs.kext /kexts
  sudo /usr/libexec/PlistBuddy -c "Add :OSBundleRequired string" /kexts/msdosfs.kext/Contents/Info.plist
  sudo /usr/libexec/PlistBuddy -c "Set :OSBundleRequired \"Safe Boot\"" /kexts/msdosfs.kext/Contents/Info.plist
  ```

---

### Update Clover

Download latest `CLOVERX64.efi` from [Dids/clover-builder](https://github.com/Dids/clover-builder/releases) and replace in `EFI/CLOVER`

### Update OS X

- Make a full backup
- Check [hackintosher.com](https://hackintosher.com/guides/) for the latest OS X Update Guide
- Check all kexts for updates
- Make a new Clover USB-Drive for testing purpose
  - Use updated kexts and drivers in post install
- Boot from new Clover USB-Drive
- If system boots
  - Mount Mojave EFI partition
  - Backup `EFI` to `EFI-Backups`
  - Install new Clover version to EFI partition
  - Copy updated kexts and drivers during post install
  - Don't forget to copy `Microsoft` folder (it contains the windows bootloader)
- Eject USB-Drive and reboot
- If system boots
  - Start Mojave Update
  - On restart select newly added `Install OS X ...` partition
  - Disable all BCRM kexts to prevent loop at the end of boot
  - After reboot select normal Mojave partition
- If system boots
  - Be happy and enjoy the new update
- If system doesn't boot on one of these steps
  - Try to fix the problem or revert to the latest backup

---

## Resources

### SSDT

Generate your SSDT with [ssdtPRGen.sh](https://github.com/Piker-Alpha/ssdtPRGen.sh)
<br>-x 1 is for Ivy Bridge CPU
<br>-lmf 900 sets lowest idle frequency to 900 mhz

```sh
./ssdtPRGen.sh -x 1 -lfm 900
```

Copy `/Users/{Name}/Library/ssdtPRGen/ssdt.aml` to `EFI/CLOVER/ACPI/patched/`
Replace existing file, rename it to `SSDT.aml`

### DSDT

Generation of DSDT is not covered by this tutorial, have a look at: [danieleds/Asus-UX32VD-Hackintosh](https://github.com/danieleds/Asus-UX32VD-Hackintosh/tree/master/src/DSDT)

---

### Kexts

#### Kext Patch: [acidanthera/Lilu](https://github.com/acidanthera/Lilu/releases)

- Lilu.kext

#### WiFi: [RehabMan/OS-X-Fake-PCI-ID](https://bitbucket.org/RehabMan/os-x-fake-pci-id/downloads/)

- FakePCIID.kext
- FakePCIID_Broadcom_WiFi.kext

#### Bluetooth: [RehabMan/OS-X-BrcmPatchRAM](https://bitbucket.org/RehabMan/os-x-brcmpatchram/downloads/)

- BrcmFirmwareRepo.kext
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

- Clover Configurator: [Link](http://mackie100projects.altervista.org/download-clover-configurator/)
- Kext Utility: [Link](http://cvad-mac.narod.ru/index/0-4)
