## ASUS UX32VD

### Info

#### Laptop Frequent Questions: [tonymacx86.com](https://www.tonymacx86.com/threads/faq-read-first-laptop-frequent-questions.164990/)

### Install OS X Mojave

#### 1. Make Clover USB-Drive

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

##### b) Clover Install [clover-wiki](https://clover-wiki.zetam.org/Installation)

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

#### 2. Make Mojave USB-Drive

- Use [DiskMaker X](https://diskmakerx.com/) to create Mojave USB=Drive

#### 3. Install Clover in EFI partition on Mojave

- Repeat steps 1b - 1c but with Mojave disk as target

### Update Mojave

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

### Post Install

#### Download Clover Configurator: [Link](http://mackie100projects.altervista.org/download-clover-configurator/)

#### Download Kext Utility: [Link](http://cvad-mac.narod.ru/index/0-4)

### SSDT

Generate your SSDT with [ssdtPRGen.sh](https://github.com/Piker-Alpha/ssdtPRGen.sh)
<br>-x 1 is for SandyBridge CPU
<br>-lmf 900 sets lowest idle frequency to 900 mhz

```sh
./ssdtPRGen.sh -x 1 -lfm 900
```

Copy `/Users/{Name}/Library/ssdtPRGen/ssdt.aml` to `EFI/CLOVER/ACPI/patched/`
Replace existing file, rename it to `SSDT.aml`

### Kexts

#### Patch

- Lilu.kext

[acidanthera/Lilu](https://github.com/acidanthera/Lilu/releases)

#### WiFi

- FakePCIID.kext
- FakePCIID_Broadcom_WiFi.kext

[RehabMan/OS-X-Fake-PCI-ID](https://bitbucket.org/RehabMan/os-x-fake-pci-id/downloads/)

#### Bluetooth

- BrcmFirmwareRepo.kext
- BrcmPatchRAM2.kext

[RehabMan/OS-X-BrcmPatchRAM](https://bitbucket.org/RehabMan/os-x-brcmpatchram/downloads/)

#### Battery

- ACPIBatteryManager.kext

[RehabMan/OS-X-ACPI-Battery-Driver](https://bitbucket.org/RehabMan/os-x-acpi-battery-driver/downloads/)

#### Sensors

- FakeSMC.kext
- FakeSMC_ACPISensors.kext
- FakeSMC_CPUSensors.kext
- FakeSMC_GPUSensors.kext
- FakeSMC_LPCSensors.kext
- FakeSMC_SMMSensors.kext

[RehabMan/OS-X-FakeSMC-kozlek](https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/)

### CPU

- NullCPUPowerManagement.kext

[tonymacx86/NullCPUPowerManagement](https://www.tonymacx86.com/resources/nullcpupowermanagement.268/)

#### Audio

- VoodooHDA.kext

[SourceForge/VoodooHDA](https://sourceforge.net/projects/voodoohda/)

#### TouchPad

- ApplePS2SmartTouchPad.kext

[EMlyDinEsH/Smart-Touchpad-Driver](http://forum.osxlatitude.com/index.php?/topic/1948-elan-focaltech-and-synaptics-smart-touchpad-driver-mac-os-x/)

#### FN-Keys

- AsusNBFnKeys.kext

[EMlyDinEsH/ASUS-FN-ALS-Sensor-Driver](http://forum.osxlatitude.com/index.php?/topic/1968-fn-hotkey-and-als-sensor-driver-for-asus-notebooks/)
