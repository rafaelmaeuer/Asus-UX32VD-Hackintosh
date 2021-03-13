### ACPI Patching

This guide explains how to create all necessary and additional SSDTs that are required to get UX32VD Hackintosh working with OpenCore.

**Table of Contents**

- [ACPI Patching](#acpi-patching)
  - [Necessary SSDTs](#necessary-ssdts)
    - [Embedded Controller](#embedded-controller)
    - [Display Backlight](#display-backlight)
    - [IRQ Conflicts](#irq-conflicts)
    - [IMEI Device](#imei-device)
    - [nVidia GPU](#nvidia-gpu)
    - [SMBUS Controller](#smbus-controller)
  - [Additional SSDTs](#additional-ssdts)
    - [Battery](#battery)
    - [Fixing Sleep](#fixing-sleep)
    - [CPU Power-Management](#cpu-power-management)
    - [ALS & Keys (FN/Backlight)](#als--keys-fnbacklight)

#### Necessary SSDTs

Find necessary SSDT-patches for `Ivy Brigde Laptops` on [What SSDTs do each platform need?](https://dortania.github.io/Getting-Started-With-ACPI/ssdt-platform.html#laptop)  
Some SSDTs are available in a [pre-compiled](https://github.com/dortania/Getting-Started-With-ACPI/tree/master/extra-files/compiled) version, others need to be created with [tools](https://dortania.github.io/Getting-Started-With-ACPI/ssdt-methods/ssdt-easy.html) or by [hand](https://dortania.github.io/Getting-Started-With-ACPI/ssdt-methods/ssdt-long.html).

##### Embedded Controller

Read [Fixing Embedded Controller (SSDT-EC/USBX)](https://dortania.github.io/Getting-Started-With-ACPI/Universal/ec-fix.html) and choose between [prebuilt](https://dortania.github.io/Getting-Started-With-ACPI/Universal/ec-methods/prebuilt.html) version and [SSDTTime](https://dortania.github.io/Getting-Started-With-ACPI/Universal/ec-methods/ssdttime.html) generation. This guide uses [SSDTTime](https://github.com/corpnewt/SSDTTime) from a parallel windows install, following this guide: [SSDTs: The easy way](https://dortania.github.io/Getting-Started-With-ACPI/ssdt-methods/ssdt-easy.html#so-what-can-t-ssdttime-do) to create:

- SSDT-EC.aml

##### Display Backlight

To enable display backlight, read [Fixing Backlight (SSDT-PNLF)](https://dortania.github.io/Getting-Started-With-ACPI/Laptops/backlight.html) and choose between [prebuilt](https://dortania.github.io/Getting-Started-With-ACPI/Laptops/backlight-methods/prebuilt.html) version and [manual](https://dortania.github.io/Getting-Started-With-ACPI/Laptops/backlight-methods/manual.html) creation (this guide uses the manual approach): Download [SSDT-PNLF.dsl](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/AcpiSamples/Source/SSDT-PNLF.dsl) change  `\_SB.PCI0.GFX0` to `\_SB.PCI0.IGPU` and compile with [MaciASL](https://github.com/acidanthera/MaciASL) (Stable Compiler) to:

- SSDT-PNLF.aml

##### IRQ Conflicts

In order to apply hot-patches know from clover (FixRTC, FixHPET, etc.) read [Fixing IRQ Conflicts (SSDT-HPET + OC_Patches.plist)](https://dortania.github.io/Getting-Started-With-ACPI/Universal/irq.html). This step requires manual creation with [SSDTTime](https://dortania.github.io/Getting-Started-With-ACPI/ssdt-methods/ssdt-easy.html) (apply patches from `config.plist` to OpenCore's `config.plist`). The method generates:

- SSDT-HPET.aml
- ACPI-renames

##### IMEI Device

To fix IMEI device read [Fixing IMEI (SSDT-IMEI)](https://dortania.github.io/Getting-Started-With-ACPI/Universal/imei.html) and choose between [prebuilt](https://dortania.github.io/Getting-Started-With-ACPI/Universal/imei-methods/prebuilt.html) version and [manual](https://dortania.github.io/Getting-Started-With-ACPI/Universal/imei-methods/manual.html) creation (this guide uses the manual approach): Download [SSDT-IMEI.dsl](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/AcpiSamples/Source/SSDT-IMEI.dsl) and compile with [MaciASL](https://github.com/acidanthera/MaciASL) (Legacy Compiler) to:

- SSDT-IMEI.aml

##### nVidia GPU

The internal nVidia GPU needs to be disabled in order for graphics to work correctly. Read [Disabling laptop dGPUs (SSDT-dGPU-Off/NoHybGfx)](https://dortania.github.io/Getting-Started-With-ACPI/Laptops/laptop-disable.html) and choose between [prebuilt](https://dortania.github.io/Getting-Started-With-ACPI/Laptops/laptop-disable.html#prebuilts), [SSDTTime](https://dortania.github.io/Getting-Started-With-ACPI/Laptops/laptop-disable.html#ssdttime) and [manual](https://dortania.github.io/Getting-Started-With-ACPI/Laptops/laptop-disable.html#manual) solutions (this guide follows the manual [Optimus Method](https://dortania.github.io/Getting-Started-With-ACPI/Laptops/laptop-disable.html#optimus-method)): Download [SSDT-dGPU-Off.dsl](https://github.com/dortania/Getting-Started-With-ACPI/blob/master/extra-files/decompiled/SSDT-dGPU-Off.dsl.zip), use `\_SB.PCI0.PEG0.PEGP` for nVidia GPU and compile with [MaciASL](https://github.com/acidanthera/MaciASL) (Legacy Compiler) to:

- SSDT-dGPU-Off.aml

##### SMBUS Controller

To fix the AppleSMBus support in macOS read [Fixing SMBus support (SSDT-SBUS-MCHC)](https://dortania.github.io/Getting-Started-With-ACPI/Universal/smbus.html) and follow the [manual](https://dortania.github.io/Getting-Started-With-ACPI/Universal/smbus-methods/manual.html) guide: Download [SSDT-SBUS-MCHC.dsl](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/AcpiSamples/Source/SSDT-SBUS-MCHC.dsl), use `\_SB.PCI0.SBUS` as SMBUS device and compile with [MaciASL](https://github.com/acidanthera/MaciASL) (Stable Compiler) to:

- SSDT-SBUS-MCHC.aml

#### Additional SSDTs

##### Battery

[Battery Patching](https://dortania.github.io/OpenCore-Post-Install/laptop-specific/battery.html) is a very advanced process and requires static DSDT patching as a first step. In a second step hot-patches can be created by extracting differences from an unpatched and a patched DSDT using a [diff-tool](https://kaleidoscope.app/) following RehabMan's [Battery Status Hotpatch](https://www.tonymacx86.com/threads/guide-using-clover-to-hotpatch-acpi.200137/#post-1308261) guide.

1. Static DSDT-patch (use Legacy Compiler)
   - Extract `DSDT.aml` ([Getting a copy of your DSDT](https://dortania.github.io/Getting-Started-With-ACPI/Manual/dump.html#from-windows))
   - Decompile `DSDT.aml` with [MaciASL](https://github.com/acidanthera/MaciASL) and save as `DSDT.dsl`
   - Apply battery-patch (`battery_ASUS-N55SL.txt`) on `DSDT.dsl`
   - Save as `DSDT-BAT.dsl` and compiled version as `DSDT-BAT.aml`

2. Verify the patch works
   - Add `DSDT-BAT.aml` to `EFI/OC/ACPI` and `config.plist`
   - Boot and check menu bar and system settings for battery entries

3. Create SSDT hot-patch
   - Show Diff between `DSDT.dsl` and `DSDT-BAT.dsl` (e.g. [Kaleidoscope](https://kaleidoscope.app/))
   - Generate empty file `SSDT-BATT.dsl` with [MaciASL](https://github.com/acidanthera/MaciASL)
   - Follow RehabMan’s [Battery-Patching](https://www.tonymacx86.com/threads/guide-using-clover-to-hotpatch-acpi.200137/#post-1308261) guide
     - Extract scopes, regions and methods from file differences
     - Create ACPI-renames for every patched function
   - Use [Hex Fiend](https://hexfiend.com/) to verify uniqueness of ACPI-renames
   - Save file as `SSDT-BATT.aml` in `\EFI\OC\ACPI` and `config.plist`
   - Add ACPI-renames in OCC -> ACPI -> Patch

- SSDT-BATT.aml
- ACPI-renames

##### Fixing Sleep

In order to fix instant wake on sleep, read [GPRW/UPRW/LANC Instant Wake Patch](https://dortania.github.io/OpenCore-Post-Install/usb/misc/instant-wake.html). After checking the DSDT for occurrences, the GPRW method is applicable: Download prebuild [SSDT-GPRW.aml](https://github.com/dortania/OpenCore-Post-Install/blob/master/extra-files/SSDT-GPRW.aml) and apply [GPRW-Patch.plist](https://github.com/dortania/OpenCore-Post-Install/blob/master/extra-files/GPRW-Patch.plist) to `config.plist`:

- SSDT-GPRW.aml
- ACPI-rename

##### CPU Power-Management

For correct CPU Power-Management (turbo mode and speed stepping) read [Fixing Power Management (SSDT-PLUG)](https://dortania.github.io/Getting-Started-With-ACPI/Universal/plug.html). As `MacBookAir5,2` is the closest SMBIOS to UX32VD ([link](https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/ivy-bridge.html#platforminfo)), it is used to generate SSDT for power-management. As `SSDT-PLUG` is only compatible with Intel's Haswell and newer CPUs ([link](https://dortania.github.io/Getting-Started-With-ACPI/Universal/plug.html)), Ivy Bridge needs to follow the [ssdtPRgen](https://dortania.github.io/OpenCore-Post-Install/universal/pm.html#sandy-and-ivy-bridge-power-management) method.

- OpenCore Configurator Paths
  - Drop ACPI: `ACPI` -> `Delete`
  - SMBIOS: `PlatformInfo` -> `SMBIOS` -> `Button Up/Down`
  - Boot-Args: `NVRAM` -> `UUID` -> `7C4...F82` -> `boot-args`

1. Select SMBIOS `MacBookAir5,2` (CPU: Ivy Bridge i5 3427U)
   - Set `1796` as `ProcessorType` (CPU: Ivy Bridge i7 3667U)
   - Add `-no_compat_check` boot-flag
   - Drop `CpuPm` and `Cpu0Ist` tables
   - Reboot with new SMBIOS

2. Use [ssdtPRGen.sh](https://github.com/Piker-Alpha/ssdtPRGen.sh) from [Tools](/Tools) folder to generate `SSDTs`
   - [Ignore](https://github.com/Piker-Alpha/ssdtPRGen.sh/issues/183#issuecomment-171089689) warning about improperly 'cpu-type' ([0x0704](https://docs.google.com/spreadsheets/d/1x09b5-DGh8ozNwN5ZjAi7TMnOp4TDm6DbmrKu86i_bQ/edit#gid=0&range=E88) instead of 0x0604)
   - Output folder: `~/Library/ssdtPRGen/`
   - Rename `SSDT.aml` to `SSDT-PM.aml`
   - Add to `EFI/OC/ACPI` and `config.plist`

- SSDT-PM.aml

##### ALS & Keys (FN/Backlight)

Getting FN-Keys and Keyboard-Backlight to work with OpenCore was a bit [tricky](https://github.com/hieplpvip/AsusSMC/issues/93). Finally with help of hieplpvip's [SSDT-ATK-BDW.dsl](https://github.com/hieplpvip/Asus-Zenbook-Hackintosh/blob/master/src/acpi/include/SSDT-ATK-BDW.dsl), [SSDT-RALS.dsl](https://github.com/hieplpvip/Asus-Zenbook-Hackintosh/blob/master/src/acpi/include/SSDT-RALS.dsl) and [AsusSMC Patches](https://github.com/hieplpvip/AsusSMC/tree/master/patches) it was possible to create:

- SSDT-ATK.aml
- AsusSMCDeamon

In order to find out which FN-keys need to be patched, the following key-table was created:

| Key    | Symbol             | Current              | Wanted             | Action   |
| ------ | ------------------ | -------------------- | ------------------ | -------- |
| F1     | Sleep              | sleep -> wake -> off | sleep              | patch    |
| F2     | WiFi               | nothing              | wifi on/off        | patch    |
| F3     | Key-Dim-Down       | key light down       | key light down     | no patch |
| F4     | Key-Dim-Up         | key light up         | key light up       | no patch |
| F5     | Brightness-Down    | nothing              | display light down | patch    |
| F6     | Brightness-Up      | nothing              | display light up   | patch    |
| F7     | Display on/off     | display instant off  | display dim off    | patch    |
| F8     | External Display   | print (cmd + p)      | mission control    | patch    |
| F9     | Trackpad on/off    | trackpad on/off      | trackpad on/off    | no patch |
| F10    | Volume on/off      | volume on/off        | volume on/off      | no patch |
| F11    | Volume down        | volume down          | volume down        | no patch |
| F12    | Volume up          | volume up            | volume up          | no patch |
| Pause  | Pause              | display light up     | nothing            | patch    |
| Druck  | Druck              | nothing              | print (cmd + p)    | patch    |
| A      | ALS-Sensor on/off  | nothing              | als-sensor on/off  | patch    |
| C      | Screen             | previous track       | previous track     | no patch |
| V      | Camera             | next track           | next track         | no patch |
| Space  | Speed-Mode         | play/pause           | play/pause         | no patch |
| Arrows | Left/Up/Down/Right | left/up/down/right   | left/up/down/right | no patch |

Regarding the table, the Keys `F1-F2`, `F5-F8` and `A` were patched. As finding the correct key codes for `Pause (F15)` and `Druck (F13)` was not possible using [RehabMan/OS-X-ACPI-Debug](https://github.com/RehabMan/OS-X-ACPI-Debug) or [VoodooPS2/Debug](https://github.com/acidanthera/VoodooPS2/blob/master/VoodooPS2Controller/VoodooPS2Controller.cpp#L463), their key-function is suppressed with Karabiner.

The complex Karabiner-modification [Fn + Backspace to Forward Delete](https://ke-complex-modifications.pqrs.org/?q=FN%20delete) doesn't had the wanted effect, but the `Entf`-key next to the power-button can be used for this purpose.
