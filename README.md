## ASUS UX32VD Hackintosh

Guide about installing macOS Big Sur on ASUS UX32VD Laptop

![UX32VD Hackintosh](Images/UX32VD-banner.jpg)

### Information

This Hackintosh was build with help of [danieleds/Asus-UX32VD-Hackintosh](https://github.com/danieleds/Asus-UX32VD-Hackintosh) repository and OpenCore guide [Laptop Ivy Bridge](https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/ivy-bridge.html) as base.

As OpenCore requires to move from static DSDT patching to dynamic SSDT patching the Hackintosh was rebuilt from scratch with a lot of time and effort.

- macOS: Big Sur 11.4
- bootloader: OpenCore 0.7.4

---

**Table of Contents**

- [ASUS UX32VD Hackintosh](#asus-ux32vd-hackintosh)
  - [Information](#information)
    - [BIOS](#bios)
    - [Hardware](#hardware)
    - [Restrictions](#restrictions)
  - [Install macOS](#install-macos)
    - [1. Create OpenCore Drive](#1-create-opencore-drive)
    - [2. Create macOS Installer Drive](#2-create-macos-installer-drive)
    - [3. Install macOS](#3-install-macos)
    - [4. Post Installation](#4-post-installation)
  - [Update macOS](#update-macos)
  - [OpenCore Config](#opencore-config)
  - [Troubleshooting](#troubleshooting)
  - [Resources](#resources)
    - [ACPI Patches](#acpi-patches)
    - [Device Properties](#device-properties)
    - [Advanced Config](#advanced-config)
    - [Kexts in use](#kexts-in-use)
    - [Driver and Tools](#driver-and-tools)
    - [Useful Links](#useful-links)

---

#### BIOS

- Use version 214 (get ROM from [BIOS](/BIOS) folder)
- Check for correct BIOS settings (F2/ESC on post):

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
  - XHCI Pre-Boot Mode [Auto]

  Network
  - Network Stack [Disabled]
  ```

#### Hardware

This Hackintosh is based on an [ASUS UX32VD-R4002V](https://www.asus.com/de/supportonly/UX32VD/HelpDesk_Download/) Laptop, with an [Intel Core i7-3517U](https://ark.intel.com/content/www/de/de/ark/products/65714/intel-core-i7-3517u-processor-4m-cache-up-to-3-00-ghz.html) Processor and a [NVIDIA GeForce GT 620M](https://www.geforce.co.uk/hardware/notebook-gpus/geforce-gt-620m/specifications) graphics card.

**RAM**

The default 2GB of RAM were replaced with an equivalent [8GB DDR3](https://www.speicher.de/arbeitsspeicher-8gb-ddr3-asus-zenbook-ux32vd-r4002v-ram-so-dimm-sp247073.html) module to get 10GB of RAM.

**Graphics**

The NVIDIA GeForce GT 620M was disabled in favour of the Ivy Bridge Intel HD 4000 graphics card which is renamed to iGPU with a SSDT patch.

**WIFI / Bluetooth**

As the default WiFi/BT card is not supported by macOS, it is replaced by a [Broadcom BCM4352 Combo card](https://osxlatitude.com/forums/topic/2767-broadcom-bcm4352-80211-ac-wifi-and-bluetooth-combo-card/).  
Notice that antenna-adapters are needed when replacing the default card due to different connector sizes ([link](http://forum.notebookreview.com/threads/upgrading-asus-ux32vd-wireless-card-antenna-connector-problem-help.731735/)).

**Ethernet**

The default USB-ethernet adapter was replaced with an [UGREEN 20256 Adapter](https://www.ugreen.com/product/UGREEN_Network_Adapter_USB_to_Ethernet_RJ45_Lan_Gigabit_Adapter_for_Ethernet_Black-en.html) after it stopped working. Benefits of the new adapter are USB3 and Gigabit speed.

#### Restrictions

The following devices or features are not working or disabled:

- NVIDIA GeForce GT 620M
- Realtek SD Card Reader
- F2 Status-Indicator LED

---

### Install macOS

#### 1. Create OpenCore Drive

**a) Preparation**

- Format USB-Drive with GUID and APFS ([Link](https://www.howtogeek.com/272741/how-to-format-a-drive-with-the-apfs-file-system-on-macos-sierra/))

  - Find the correct disk number of USB-Drive:

    ```sh
    diskutil list
    ```

  - Replace {n} with corresponding disk number and {Volume} with desired Name:

    ```sh
    diskutil apfs createContainer /dev/disk{n}
    diskutil apfs addVolume disk{n} APFS {Volume}
    ```

- Download latest OpenCore: [acidanthera/opencorepkg](https://github.com/acidanthera/opencorepkg/releases)
  - Chose `debug` for installation and config or `release` for final use

**b) Install OpenCore**

- Follow this guide [OpenCore-Install-Guide](https://dortania.github.io/OpenCore-Install-Guide/installer-guide/)
  - Basically the files mentioned in [file-swaps](https://dortania.github.io/OpenCore-Install-Guide/troubleshooting/debug.html#file-swaps) need to be copied/updated
    - Copy `OpenCanopy.efi` to `EFI/OC/Drivers` for GUI picker
    - Copy `OpenHfsPlus.efi` to `EFI/OC/Drivers` for HFS+ support
  - Repeat this step when switching from `debug` to `release` version

**c) Add Config and Kexts**

- Copy all ACPI patches from/to `EFI/OC/ACPI/`
- Copy `config.plist` from/to `EFI/OC/config.plist`
- Copy all kexts from/to `EFI/OC/Kexts/`

#### 2. Create macOS Installer Drive

To create a working macOS Installer boot drive, you will need the following:

- An empty USB3 flash drive (minimum 32GB)
- A device already running macOS with App Store access

**a) Download macOS Installer**

- Open the Mac App Store on a device running macOS
- Download `Install macOS Big Sur` application
- Close Installer when it opens automatically

**b) Create Installer Stick**

- Follow this guide: [macOS Big Sur 11: bootbaren USB-Stick erstellen](https://www.zdnet.de/88389660/macos-big-sur-11-bootbaren-usb-stick-erstellen/)
  
  Create installer stick with this command:

  ```sh
  sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume /Volumes/Big\ Sur/ --nointeraction
  ```

**c) Patch Installer Stick**

Enable installation on unsupported hardware:
  
- Download and unpack: [barrykn/big-sur-micropatcher](https://github.com/barrykn/big-sur-micropatcher/releases)
- Execute in Terminal (replace X with correct version)
  
  ```sh
  ~/Downloads/big-sur-micropatcher-0.5.X/micropatcher.sh
  ```

---

#### 3. Install macOS

- Connect macOS Installer to left-sided USB
- Connect OpenCore Drive to right-sided USB next to HDMI
- Boot from OC Drive (`ESC` on BIOS post -> `UEFI: OpenCore Drive`)
- Reset NVRAM from Boot-Picker (reboot)
- Select macOS Installer (`Install macOS Big Sur`)
- Begin installation on APFS formatted HDD/SSD
- On reboots select `(Install) Big Sur` drive (auto)
- Finish the initial macOS setup process

---

#### 4. Post Installation

**a) OpenCore**

- After successful install copy OpenCore to system EFI partition
- Repeat steps 1b - 1c but with EFI on macOS HDD as target
  - Switch OpenCore from `debug` to `release` version ([file-swaps](https://dortania.github.io/OpenCore-Install-Guide/troubleshooting/debug.html#file-swaps))
  - To disable all logging apply following [config-changes](https://dortania.github.io/OpenCore-Install-Guide/troubleshooting/debug.html#config-changes)

**b) System-Tools**

- Install the following from [Tools](/Tools) folder:
  - `Intel Power Gadget` to test CPU frequency and speed stepping
  - `OpenCore Configurator` (OCC) to modify/update `config.plist`
  - `Hackintool` to check for loaded kexts and system settings

**c) AsusSMCDaemon**

- Unzip `AsusSMC-1.4.X-RELEASE.zip` in [Kexts](/Kexts) folder
- Run `install_daemon.sh` as root (replace X with current version)

    ```sh
    cd .../Kexts/AsusSMC-1.4.X-RELEASE
    sudo ./install_daemon.sh
    ```

    (More details in [Installation-Instructions](https://github.com/hieplpvip/AsusSMC/wiki/Installation-Instruction#2-installing-asussmcdaemon-only-if-you-have-sleep-and-airplane-fn-keys) of AsusSMC.kext)

**d) Karabiner Elements**

- Install Karabiner Elements from [Config/Karabiner](/Config/Karabiner) folder
- Option a) Import `karabiner.json` from [Config/Karabiner](/Config/Karabiner) folder
- Option b) Create config with following settings:

  ![Karabiner-Key-Mapping](Images/Karabiner-Key-Mapping.png)
  ![Karabiner-FN-Keys](Images/Karabiner-FN-Keys.png)

**e) Audio Boost**

As the maximum audio volume with AppleALC can be insufficient, [Boom 2](https://www.globaldelight.com/boom/boom2.php) is used as system-wide volume booster.

- Install `Boom 2` (download [Trial](https://www.globaldelight.com/storefs/thankyou_free_boom2.php) or [Buy](https://www.globaldelight.com/store/?product=boom2)) and the [Boom 2 Audio Component](https://www.globaldelight.com/boom/mas-content/device-installer.php) from [Tools](/Tools) folder
- Use the following settings, which allow a satisfying volume for audio output on UX32VD:

  ![Boom2-Audio-Booster](Images/Boom2-Audio-Booster.png)

**f) Drivers**

Install the driver for the appropriate Ethernet-Adapter from [Driver](/Driver) folder

- Original: ASIX USB 2.0 to 10/100M Fast Ethernet Controller
- Replacement: UGREEN USB 3.0 Gigabit Ethernet Adapter

__Note:__ Unless Asix ethernet adapters are [unsupported](https://plugable.com/blogs/news/asix-ethernet-adapters-unsupported-on-macos-big-sur) on Big Sur avoid install. Better extract kext with tools like [The Unarchiver](https://apps.apple.com/de/app/the-unarchiver/id425424353) and inject directly with OC.

---

### Update macOS

- Make a full backup with `Time Machine` or similar software
- Check the official update-guide: [OpenCore-Post-Install/update](https://dortania.github.io/OpenCore-Post-Install/universal/update.html)
- Download latest version of OpenCore
- Download updates for all installed kexts
- Update OpenCore Drive for testing purpose
  - Use latest OpenCore, kexts and drivers
- Boot from OpenCore Drive
- If the system boots
  - Mount EFI partition of macOS HDD
  - Replace EFI from OpenCore Drive
  - Don't forget `Microsoft` or `Ubuntu` folder (Windows/Ubuntu bootloader)
  - Reset NVRAM if OpenCore version doesn't change
- If the system boots
  - Start macOS Update from `System Settings` -> `Software Update`
  - With OpenCore the update process should work automatically
    - If `Software Update` shows `Mac version is up to date`, download macOS Installer from AppStore (use another Mac) and initialize the update manually
- If system doesn't boot on one of these steps
  - Try to fix the problem or revert to the latest backup

---

### OpenCore Config

For adding your SSDTs, Kexts and Firmware Drivers to create snapshots of your populated EFI folder ([link](https://dortania.github.io/OpenCore-Install-Guide/config.plist/#adding-your-ssdts-kexts-and-firmware-drivers)) use [corpnewt/ProperTree](https://github.com/corpnewt/ProperTree).

**Add ACPI patches**

To manually add ACPI patches do the following

- Copy `{name}.aml` into `EFI/OC/ACPI`
- Open `config.plist` in OCC
- Add new entry in `ACPI` -> `Add`
  - Add `{name}.aml` as Path
  - Add a meaningful `Comment`
  - Select `Enabled`

**Add kexts**

To manually add kexts do the following

- Copy `{name}.kext` into `EFI/OC/Kexts`
- Open `config.plist` in OCC
- Add new entry in `Kernel` -> `Add`
  - Add `x86_64` as Arch
  - Add `{name}.kext` as BundlePath
  - Add a meaningful `Comment`
  - If kext isn't codeless add `{name}` as ExecutablePath
  - Add `Contents/Info.plist` as PlistPath
  - (Optional: set `MinKernel` and `MaxKernel`)
  - Select `Enabled`

**Sanity Checker**

The OpenCore configuration can be validated by uploading the `config.plist` to [OpenCore Sanity Checker](https://opencore.slowgeek.com/) in order to perform a sanity check. It helps to find problems in the configuration and to optimize the setup.

---

### Troubleshooting

Tips and tricks to solve already known problems

**Graphics Glitch**

If display shows colorful/graphic glitches, close the lid, wait for sleep and reopen.

**Reset NVRAM**

NVRAM can be reset from OpenCanopy boot picker if auxiliary-entries are displayed in OpenCore ([Link](https://www.reddit.com/r/hackintosh/comments/h0jkjl/hide_partitions_from_opencore_boot_screen/))

- Mount `EFI` and open `config.plist` with OCC
- Go to `Misc` -> `Boot` and set `HideAuxiliary = NO`
- On reboot select `Reset NVRAM` from tools

**Default Boot Option**

A default boot entry can be set with `ctrl + enter` if the option is allowed in OpenCore ([Link](https://www.reddit.com/r/hackintosh/comments/dze9kw/how_to_change_default_boot_option_for_opencore/))

- Mount `EFI` and open `config.plist` with OCC
- Go to `Misc` -> `Security` and set `AllowSetDefault = YES`
- In OpenCanopy boot picker set default with `ctrl + enter`

**Add Boot Entry**

To add boot entry for OpenCore enter bios (F2 on post)

- Select `Boot` -> `Add New Boot Option`
  - Select `Add boot option`: OpenCore
  - Select `Path for boot option`: \EFI\BOOT\BOOTx64.efi
  - Select `Create`
- Press `ESC` and move `OpenCore` to first position
- Save changes and restart (F10)

**Boot Resolution**

The display resolution during boot is very low, full display resolution (1080p) is only reached on the last boot stage

- Default options `TextRenderer` set to `BuiltinGraphics` and `Resolution` set to `Max` ([macos-decluttering](https://dortania.github.io/OpenCore-Post-Install/cosmetic/verbose.html#macos-decluttering)) deliver best results (1280x960 or similar)

---

### Resources

Useful information, tips and tutorials used to create this Hackintosh

#### ACPI Patches

With Clover most of the ACPI patches are applied in main DSDT (Differentiated System Description Table) with a `static` patching method (extract DSDT -> decompile -> apply patches -> compile -> use patched DSDT). With OpenCore `dynamic` ACPI-patching is the preferred method (all changes are applied on the fly with current system-DSDT). Therefore all patches must be served as SSDT (Secondary System Description Table). Read more in [Getting started with ACPI](https://dortania.github.io/Getting-Started-With-ACPI/).

Check out the [ACPI Patching](/ACPI) section for more details about DSDT, SSDT and their creation process.

---

#### Device Properties

Setting the correct [device properties](https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/ivy-bridge.html#deviceproperties) is necessary for tha hardware to work as expected.

**iGPU**

For iGPU the correct platform-id `09006601` is necessary to complete the last boot-stage (to be used with some devices that have `eDP` connected monitor). In `config.plist` -> `DeviceProperties` add:

- PciRoot(0x0)/Pci(0x2,0x0)
  - AAPL,ig-platform-id: 09006601 (DATA)

**AppleALC**

In order to get sound working properly, the correct `layout-id` must be used with AppleALC (see [Fixing audio with AppleALC](https://dortania.github.io/OpenCore-Post-Install/universal/audio.html#fixing-audio-with-applealc)). The Audio-Codec on UX32VD is `Realtek ALC269` and shows up in [AppleALC/wiki/Supported-codecs](https://github.com/acidanthera/AppleALC/wiki/Supported-codecs). Instead of testing all possible IDs, working configs of similar devices were tested using [ALC269/Info.plist](https://github.com/acidanthera/AppleALC/blob/master/Resources/ALC269/Info.plist):

| Device-Preset         | AppleALC ID | Audio Output | Output Switch | Microphone | Feature    |
| --------------------- | ----------- | ------------ | ------------- | ---------- | ---------- |
| Asus K53SJ, Asus G73s | alcid=3     | ✓            | ✓             | 𐄂          | -          |
| Asus Vivobook S200CE  | alcid=12    | ✓            | 𐄂             | ✓          | -          |
| Asus Vivobook S300CA  | alcid=19    | ✓            | ✓             | ✓          | -          |
| Asus A45A 269VB1      | alcid=45    | ✓            | ✓             | ✓          | Line-In    |
| Asus K53SJ Mod        | alcid=93    | ✓            | ✓             | 𐄂          | Mic-Switch |

As `Asus A45A 269VB1` has the closest result to UX32VD `alcid=45` is used for this Hackintosh.  
In `config.plist` -> `DeviceProperties` add:

- Device: PciRoot(0x0)/Pci(0x1B,0x0)
  - layout-id: 45 (NUMBER)

---

#### Advanced Config

The following configurations are not essential for the Hackintosh to work, but they improve functionality to get as close to a real MacBook as possible.

**USB Mapping**

Per default USB ist working, but not for the port besides AC-Input. Therefore an USB-Mapping is created following the [Dortania USB-Mapping Guide](https://dortania.github.io/OpenCore-Post-Install/usb/#macos-and-the-15-port-limit). First the necessary ACPI-renames need to be determined by [checking-what-renames-you-need](https://dortania.github.io/OpenCore-Post-Install/usb/system-preparation.html#checking-what-renames-you-need). With `MacBookAir5,x and older` the SMBIOS needs renames for `XHC1`, `EHC1` and `EHC2`.

1. In `config.plist` -> `ACPI` -> `Patch` add following renames:

   - XHC1 to SHCI (find `58484331` replace `53484349`)
   - EHC1 to EH01 (find `45484331` replace `45483031`)
   - EHC1 to EH02 (find `45484332` replace `45483032`)

2. Enable USB Port-Limit patch with `config.plist` -> `Kernel` -> `Quirks` -> `XhciPortLimit` -> `True`
3. Add [USBInjectAll.kext](https://github.com/RehabMan/OS-X-USB-Inject-All) from [Config/USB](/Config/USB) folder to OpenCore (`EFI/OC/kexts` and `config.plist`)
4. Reboot an check the USB renaming works with [Hackintool](https://github.com/headkaze/Hackintool) -> `USB` tab

In the next step the [Intel USB Mapping](https://dortania.github.io/OpenCore-Post-Install/usb/intel-mapping/intel.html#intel-usb-mapping) method is used to determine all USB ports with help of [corpnewt/USBMap](https://github.com/corpnewt/USBMap) tool:

1. Plug the following into every port once and give it a name:
   - `USB2-Stick`
   - `USB3-Stick`
2. Set all internal adapters to: `255`
3. Set all external adapters to: `3`
4. Export `USBMap.kext`

The last steps for a working USB-Mapping are:

1. Replace `USBInjectAll.kext` with `USBMap.kext` in OpenCore (`EFI/OC/kexts` and `config.plist`)
2. Disable the USB Port-Limit patch: `config.plist` -> `Kernel` -> `Quirks` -> `XhciPortLimit` -> `False`
3. Reboot, all USB-Ports should work as expected

**PCI Entries**

This is most of all a cosmetic step, adding PCI-entries will list the internal devices in `SystemInformation` -> `PCI` section. But it helps to verify which devices have a working driver installed and which don't.

- Open `Hackintool` and export PCI entries with tab `PCIe` -> `Refresh` -> `Export`
- It creates 4 `pcidevices` files in different formats (.dsl, .json, .plist, .txt)
- Open `pcidevices.plist` and OpenCore `config.plist` with a code-editor
- Update fields of already existing devices (iGPA, AppleALC) in `DeviceProperties` -> `Add`
- Add all other devices as new entries in `DeviceProperties` -> `Add`
- Rename (e.g. shorten) `model` field of each entry type (e.g. iGPU name is used in `About this Mac`)
- After reboot all PCI-devices show up in `SystemInformation` -> `PCI` including their driver status

**FileVault**

As UX32VD is a portable device, sensitive data can be stored on it, which should be protected. Enabling FileVault is a good step towards better security and privacy of stored data. Read the [Dortania/FileVault](https://dortania.github.io/OpenCore-Post-Install/universal/security/filevault.html) guide to get started with all required settings in `config.plist` for FileVault ot work as expected.

Before starting with FileVault activation, make sure that:

- All necessary FileVault settings from Dortania guide are applied and working
- There is no Bootcamp or Windows partiton so macOS can access the whole SSD/HDD

Make a backup of your system first, then follow the official [Turn on and set up FileVault](https://support.apple.com/en-us/HT204837) guide from Apple. If there is an `Internal Error` on FileVault activation, do the following:

- Reboot and enter your Password on new appearing pre-boot login window
- Open up `System-Settings` -> `Security` -> `FileVault` and wait for encryption to complete

If the system gets stuck with an `Encryption paused` message after a few minutes, continue with the following steps:

- (might be optional): Download and install the [SilentKnight](https://eclecticlight.co/lockrattler-systhist/) app
- (might be optional): Run `SilentKnight` app and select `Download Updates`
- Open `DiskUtility` -> `Visibility` -> `Show all Devices`
- Select root entry of macOS SSD/HDD and run `First Aid` (should complete with `code 0`)
- Go to `System-Settings` -> `Security` -> `FileVault` and wait for encryption to complete

**HiDPI**

As the native 1080p resolution can result in too small UI, enabling `HiDPI`-mode can solve/change this problem. As macOS doesn't support [flexible UI scaling](https://apple.stackexchange.com/questions/193723/scaling-all-ui-elements-when-using-an-external-monitor/193726#193726) like Windows (e.g. 125%), the only option is to force maximum graphic card resolution and use half of the resolution in `HiDPI`-mode.

- The [maximum resolution](https://community.intel.com/t5/Graphics/Intel-HD-4000-HDMI-2560x1440-resolution/td-p/375068) of Intel HD4000 is `2560x1440`
- The maximum `HiDPI`-resolution results in `1280x720`

As `1280x720` is the highest possible `HiDPI`-resolution, the UI will appear quite big, so the perfect step between is missing. But every other configuration will result in unsharp or pixelized resolutions. To enable `1280x720` in `HiDPI`-resolution:

1. Follow instructions from [How To Enable HiDPI Mode In MacOS](https://www.techjunkie.com/hidpi-mode-os-x/):

    ```sh
    sudo defaults write /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled -bool true
    ```

2. Download and Install [SwitchResX](https://www.madrau.com/srx_download/download.html) and open `System Preferences` -> `SwitchResX`
3. Select `Integrated Display` -> `Available Resolutions` -> `1280 x 720, 60 Hz (HiDPI)`
4. The display resolution should change immediately, close `SwitchResX` and save settings
  
---

#### Kexts in use

**Patch Engine**: [acidanthera/Lilu](https://github.com/acidanthera/Lilu)

- Lilu.kext (v1.5.6)

**Graphics**: [acidanthera/WhateverGreen](https://github.com/acidanthera/WhateverGreen)

- WhateverGreen.kext (v1.5.)

**WiFi**: [acidanthera/AirportBrcmFixup](https://github.com/acidanthera/AirportBrcmFixup)

- AirportBrcmFixup.kext (v2.1.3)

**Bluetooth**: [acidanthera/BrcmPatchRAM](https://github.com/acidanthera/BrcmPatchRAM)

- BrcmBluetoothInjector.kext (v2.6.0)
- BrcmFirmwareData.kext (v2.6.0)
- BrcmPatchRAM3.kext (v2.6.0)

**Sensors**: [acidanthera/VirtualSMC](https://github.com/acidanthera/VirtualSMC)

- VirtualSMC.kext (v1.2.7)
- SMCBatteryManager.kext (v1.2.7)
- SMCProcessor.kext (v1.2.7)
- SMCSuperIO.kext (v1.2.7)

**Audio**: [acidanthera/AppleALC](https://github.com/acidanthera/AppleALC/)

- AppleALC.kext (v1.6.5)

**TouchPad**: [BAndysc/VoodooPS2](https://github.com/BAndysc/VoodooPS2)

- VoodooPS2Controller.kext (v2.2.6)

**ALS/FN-Keys**: [hieplpvip/AsusSMC](https://github.com/hieplpvip/AsusSMC)

- AsusSMC.kext (v1.4.1)

**USB**

- USBMap.kext (v1.0)

**USB-Ethernet**

- AX88179_178A.kext (v2.0.0)

---

#### Driver and Tools

**Driver**

- [ASIX AX88772B](https://www.asix.com.tw/en/support/download) -> Software & Tools -> AX88772B - Low-Power USB 2.0 to 10/100M Fast Ethernet Controller -> Apple macOS 11 Drivers Installer(Beta)

- [UGREEN AX88179 178A](https://www.ugreen.com/pages/download) -> 20256 -> Driver

**Hackintosh Tools**

- [Karabiner-Elements](https://karabiner-elements.pqrs.org/)
- [Intel Power Gadget](https://software.intel.com/content/www/us/en/develop/articles/intel-power-gadget.html)
- [OpenCore Configurator](https://mackie100projects.altervista.org/download-opencore-configurator/)
- [headkaze/Hackintool](https://github.com/headkaze/Hackintool/)

**ACPI-Patching Tools**

- [Piker-Alpha/ssdtPRGen](https://github.com/Piker-Alpha/ssdtPRGen.sh)
- [corpnewt/SSDTTime](https://github.com/corpnewt/SSDTTime)
- [acidanthera/MaciASL](https://github.com/acidanthera/MaciASL)

---

#### Useful Links

**Guides**

- [OpenCore Vanilla Guide, Step by Step](https://www.olarila.com/topic/8918-opencore-vanilla-guide-step-by-step-full-dsdt-patched-or-ssdt/)
- [ASUS Zenbook UX310UA (& UX310UQK)](https://www.tonymacx86.com/threads/guide-asus-zenbook-ux310ua-ux310uqk-macos-mojave-catalina-with-clover-big-sur-using-opencore-efi-installation-guide.224591/)
- [OpenCore Sammelthread](https://www.hackintosh-forum.de/forum/thread/42354-opencore-sammelthread-hilfe-und-diskussion/)

**Clover**

- [Clover Configurator (Parameter/Reiter & Wiki/Erklärung)](https://www.hackintosh-forum.de/forum/thread/21723-clover-configurator-parameter-reiter-wiki-erkl%C3%A4rung/)
- [ASUS ZENBOOK UX305FA using Clover UEFI](https://www.tonymacx86.com/threads/guide-asus-zenbook-ux305fa-using-clover-uefi.166818/)
- [ASUS ROG GL551JK fully working on Mavericks](https://www.tonymacx86.com/threads/asus-rog-gl551jk-fully-working-on-mavericks.155064/#post-1038195)
- [Last fix needed...HDMI Audio](https://www.insanelymac.com/forum/topic/343035-last-fix-neededhdmi-audio/?do=findComment&comment=2712880)

**OpenCore**

- [OpenCore 0.6.6 will require you to jump through a few more hoops](https://www.reddit.com/r/hackintosh/comments/lb2456/psa_opencore_066_will_require_you_to_jump_through/)
- [Bootstrap causes BIOS corruption on Gigabyte Z87 if to make reset CMOS](https://github.com/acidanthera/bugtracker/issues/1222#issuecomment-739241310)
- [r/hackintosh: 11.1 update not showing?](https://www.reddit.com/r/hackintosh/comments/ke63zl/111_update_not_showing/)

**ACPI**

- [Neues DSDT oder auch mit nur SSDT lösbar?](https://www.hackintosh-forum.de/forum/thread/33622-neues-dsdt-oder-auch-mit-nur-ssdt-l%C3%B6sbar/)
- [Patching DSDT/SSDT for LAPTOP backlight control](https://www.tonymacx86.com/threads/guide-patching-dsdt-ssdt-for-laptop-backlight-control.152659/)
- [Fix Keyboard Hot keys / Functional Keys](https://www.insanelymac.com/forum/topic/330440-beginners-guide-fix-keyboard-hot-keys-functional-keys/)
- [RehabMan/OS-X-ACPI-Debug](https://github.com/RehabMan/OS-X-ACPI-Debug)

**PCI**

- [OpenCore no keyboard/touchpad/gpu accelleration](https://www.olarila.com/topic/6730-opencore-no-keyboardtouchpadgpu-accelleration/?tab=comments#comment-86076)
- [How to add in device properties for OpenCore](https://www.youtube.com/watch?v=hD0kpsQHIIc)

**Sleep**

- [What is different between hibernatemode=0 and hibernatemode=3](https://www.tonymacx86.com/threads/what-is-different-between-hibernatemode-0-and-hibernatemode-3.164030/)
- [How to Choose a Mac Sleep Mode](https://mackeeper.com/blog/post/366-do-you-know-what-sleep-mode-is-the-best-for-your-mac/)

**Power Management**

- [What does -xcpm do?](https://www.reddit.com/r/hackintosh/comments/85e8hn/what_does_xcpm_do/)
- [X86PlatformPlugin Customization und Anpassung – Perfektes Speedstepping](https://www.hackintosh-forum.de/forum/thread/48025-cpufriend-guide-hwp-speedstep-x86platformplugin-vs-acpi-smc-platformplugin/)

**Security**

- [OpenCore Post-Install: Apple Secure Boot](https://dortania.github.io/OpenCore-Post-Install/universal/security/applesecureboot.html#what-is-apple-secure-boot)
- [Protecting data at multiple layers](https://developer.apple.com/news/?id=3xpv8r2m)
- [Snapshot volume? com.apple.os.update-xxxxxx in Disk Utility](https://discussions.apple.com/thread/252032330)
- [APFS changes in Big Sur: how Time Machine backs up to APFS, and more](https://eclecticlight.co/2020/06/29/apfs-changes-in-big-sur-how-time-machine-backs-up-to-apfs-and-more/)
- [Big Sur’s Signed System Volume: added security protection](https://eclecticlight.co/2020/06/25/big-surs-signed-system-volume-added-security-protection/)
- [Is Big Sur’s system volume sealed?](https://eclecticlight.co/2020/11/30/is-big-surs-system-volume-sealed/)

**Errors**

- [Filevault Error Codes](https://support.addigy.com/support/solutions/articles/8000056056-filevault-error-codes)
- [Fix your Mac stuck on encrypting with FileVault](https://www.macissues.com/2014/12/16/fix-your-mac-stuck-on-encrypting-with-filevault/)
- [FileVault Stuck on Paused Encryption](https://forums.macrumors.com/threads/filevault-stuck-on-paused-encryption.1952148/)
- [FileVault Stuck on Pause](https://apple.stackexchange.com/questions/160161/filevault-stuck-on-pause)

**FN-Keys**

- [FN Keyboard Brightness ASUS UX32VD macOS 11.1](https://github.com/hieplpvip/AsusSMC/issues/93)
- [Fix Keyboard Hot keys / Functional Keys](https://www.insanelymac.com/forum/topic/330440-beginners-guide-fix-keyboard-hot-keys-functional-keys/)
- [GUIDE: How to Fix Brightness hotkeys in DSDT](https://www.insanelymac.com/forum/topic/305030-guide-how-to-fix-brightness-hotkeys-in-dsdt/)
- [Patching DSDT/SSDT for LAPTOP backlight control](https://www.tonymacx86.com/threads/guide-patching-dsdt-ssdt-for-laptop-backlight-control.152659/)