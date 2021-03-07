DefinitionBlock ("", "SSDT", 2, "HACK", "PCI", 0x00000000)
{
	External (_SB_.PCI0.MCHC, DeviceObj)
	Device (_SB.PCI0.MCHC)
	{
		Name (_ADR, 0x00000000)
		Method (_DSM, 4, NotSerialized)
		{
			If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
			Return (Package ()
			{
				"model", Buffer () { "3rd Gen Core processor DRAM Controller" },
				"device_type", Buffer () { "Host bridge" },
				"AAPL,slot-name", Buffer () { "Internal@0,0,0" },
			})
		}
	}
	External (_SB_.PCI0.HDEF, DeviceObj)
	Device (_SB.PCI0.HDEF)
	{
		Name (_ADR, 0x001b0000)
		Method (_DSM, 4, NotSerialized)
		{
			If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
			Return (Package ()
			{
				"model", Buffer () { "7 Series/C216 Chipset Family High Definition Audio Controller" },
				"layout-id", Buffer () { 0x2D, 0x00, 0x00, 0x00 },
				"hda-gfx", Buffer () { "onboard-1" },
				"AAPL,slot-name", Buffer () { "Internal@0,27,0" },
				"device_type", Buffer () { "Audio device" },
			})
		}
	}
	External (_SB_.PCI0.RP01, DeviceObj)
	Device (_SB.PCI0.RP01)
	{
		Name (_ADR, 0x001c0000)
		Method (_DSM, 4, NotSerialized)
		{
			If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
			Return (Package ()
			{
				"model", Buffer () { "7 Series/C216 Chipset Family PCI Express Root Port 1" },
				"device_type", Buffer () { "PCI bridge" },
				"AAPL,slot-name", Buffer () { "Internal@0,28,0" },
			})
		}
	}
	External (_SB_.PCI0.RP02, DeviceObj)
	Device (_SB.PCI0.RP02)
	{
		Name (_ADR, 0x001c0001)
		Method (_DSM, 4, NotSerialized)
		{
			If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
			Return (Package ()
			{
				"model", Buffer () { "7 Series/C210 Series Chipset Family PCI Express Root Port 2" },
				"device_type", Buffer () { "PCI bridge" },
				"AAPL,slot-name", Buffer () { "Internal@0,28,1" },
			})
		}
	}
	External (_SB_.PCI0.EH01, DeviceObj)
	Device (_SB.PCI0.EH01)
	{
		Name (_ADR, 0x001d0000)
		Method (_DSM, 4, NotSerialized)
		{
			If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
			Return (Package ()
			{
				"model", Buffer () { "7 Series/C216 Chipset Family USB Enhanced Host Controller #1" },
				"device_type", Buffer () { "USB controller" },
				"AAPL,slot-name", Buffer () { "Internal@0,29,0" },
			})
		}
	}
	External (_SB_.PCI0.LPCB, DeviceObj)
	Device (_SB.PCI0.LPCB)
	{
		Name (_ADR, 0x001f0000)
		Method (_DSM, 4, NotSerialized)
		{
			If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
			Return (Package ()
			{
				"model", Buffer () { "HM76 Express Chipset LPC Controller" },
				"device_type", Buffer () { "ISA bridge" },
				"AAPL,slot-name", Buffer () { "Internal@0,31,0" },
			})
		}
	}
	External (_SB_.PCI0.IDE0, DeviceObj)
	Device (_SB.PCI0.IDE0)
	{
		Name (_ADR, 0x001f0002)
		Method (_DSM, 4, NotSerialized)
		{
			If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
			Return (Package ()
			{
				"model", Buffer () { "7 Series Chipset Family 6-port SATA Controller [AHCI mode]" },
				"device_type", Buffer () { "SATA controller" },
				"AAPL,slot-name", Buffer () { "Internal@0,31,2" },
			})
		}
	}
	External (_SB_.PCI0.SBUS, DeviceObj)
	Device (_SB.PCI0.SBUS)
	{
		Name (_ADR, 0x001f0003)
		Method (_DSM, 4, NotSerialized)
		{
			If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
			Return (Package ()
			{
				"model", Buffer () { "7 Series/C216 Chipset Family SMBus Controller" },
				"device_type", Buffer () { "SMBus" },
				"AAPL,slot-name", Buffer () { "Internal@0,31,3" },
			})
		}
	}
	External (_SB_.PCI0.TPCH, DeviceObj)
	Device (_SB.PCI0.TPCH)
	{
		Name (_ADR, 0x001f0006)
		Method (_DSM, 4, NotSerialized)
		{
			If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
			Return (Package ()
			{
				"model", Buffer () { "7 Series/C210 Series Chipset Family Thermal Management Controller" },
				"device_type", Buffer () { "Signal processing controller" },
				"AAPL,slot-name", Buffer () { "Internal@0,31,6" },
			})
		}
	}
	External (_SB_.PCI0.PEG0, DeviceObj)
	Device (_SB.PCI0.PEG0)
	{
		Name (_ADR, 0x00010000)
		Method (_DSM, 4, NotSerialized)
		{
			If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
			Return (Package ()
			{
				"model", Buffer () { "Xeon E3-1200 v2/3rd Gen Core processor PCI Express Root Port" },
				"device_type", Buffer () { "PCI bridge" },
				"AAPL,slot-name", Buffer () { "Internal@0,1,0" },
			})
		}
	}
	External (_SB_.PCI0.IGPU, DeviceObj)
	Device (_SB.PCI0.IGPU)
	{
		Name (_ADR, 0x00020000)
		Method (_DSM, 4, NotSerialized)
		{
			If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
			Return (Package ()
			{
				"AAPL,ig-platform-id", Buffer () { 0x09, 0x00, 0x66, 0x01 },
				"model", Buffer () { "Intel 3rd Gen Core processor Graphics Controller" },
				"hda-gfx", Buffer () { "onboard-1" },
				"AAPL,slot-name", Buffer () { "Internal@0,2,0" },
				"device_type", Buffer () { "VGA compatible controller" },
			})
		}
	}
	External (_SB_.PCI0.B0D4, DeviceObj)
	Device (_SB.PCI0.B0D4)
	{
		Name (_ADR, 0x00040000)
		Method (_DSM, 4, NotSerialized)
		{
			If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
			Return (Package ()
			{
				"model", Buffer () { "3rd Gen Core Processor Thermal Subsystem" },
				"device_type", Buffer () { "Signal processing controller" },
				"AAPL,slot-name", Buffer () { "Internal@0,4,0" },
			})
		}
	}
	External (_SB_.PCI0.SHCI, DeviceObj)
	Device (_SB.PCI0.SHCI)
	{
		Name (_ADR, 0x00140000)
		Method (_DSM, 4, NotSerialized)
		{
			If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
			Return (Package ()
			{
				"model", Buffer () { "7 Series/C210 Series Chipset Family USB xHCI Host Controller" },
				"device_type", Buffer () { "USB controller" },
				"AAPL,slot-name", Buffer () { "Internal@0,20,0" },
			})
		}
	}
	External (_SB_.PCI0.IMEI, DeviceObj)
	Device (_SB.PCI0.IMEI)
	{
		Name (_ADR, 0x00160000)
		Method (_DSM, 4, NotSerialized)
		{
			If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
			Return (Package ()
			{
				"model", Buffer () { "7 Series/C216 Chipset Family MEI Controller #1" },
				"device_type", Buffer () { "Communication controller" },
				"AAPL,slot-name", Buffer () { "Internal@0,22,0" },
			})
		}
	}
	External (_SB_.PCI0.EH02, DeviceObj)
	Device (_SB.PCI0.EH02)
	{
		Name (_ADR, 0x001a0000)
		Method (_DSM, 4, NotSerialized)
		{
			If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
			Return (Package ()
			{
				"model", Buffer () { "7 Series/C216 Chipset Family USB Enhanced Host Controller #2" },
				"device_type", Buffer () { "USB controller" },
				"AAPL,slot-name", Buffer () { "Internal@0,26,0" },
			})
		}
	}
	External (_SB_.PCI0.RP02.ARPT, DeviceObj)
	Device (_SB.PCI0.RP02.ARPT)
	{
		Name (_ADR, 0x00000000)
		Method (_DSM, 4, NotSerialized)
		{
			If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
			Return (Package ()
			{
				"model", Buffer () { "BCM4352 802.11ac Wireless Network Adapter" },
				"device_type", Buffer () { "Network controller" },
				"AAPL,slot-name", Buffer () { "Internal@0,28,1/0,0" },
			})
		}
	}
}
