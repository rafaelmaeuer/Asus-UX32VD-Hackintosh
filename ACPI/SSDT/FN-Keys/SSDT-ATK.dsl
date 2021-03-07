DefinitionBlock("", "SSDT", 2, "HIEP", "ATK", 0)
{
    External (_SB.ATKP, IntObj)
    External (_SB.ATKD, DeviceObj)
    External (_SB.ATKD.IANE, MethodObj)
    External (_SB.PCI0.LPCB.EC0, DeviceObj)
    External (_SB.PCI0.LPCB.EC0.WRAM, MethodObj)
    
    Scope (_SB.ATKD)
    {
        // patch key backlight
        Method (SKBV, 1, NotSerialized)
        {
            \_SB.PCI0.LPCB.EC0.WRAM (0x044B, Arg0)
            Return (Arg0)
        }
    }

    Scope (_SB.PCI0.LPCB.EC0)
    {
        // F1 key
        Method (_Q0A, 0, NotSerialized)
        {
            If (ATKP)
            {
                \_SB.ATKD.IANE (0x5E)
            }
        }
        
        // F2 key
        Method (_Q0B, 0, NotSerialized) 
        {
            If (ATKP)
            {
                \_SB.ATKD.IANE (0x7D)
            }
        }
        
        // F5 key
        Method (_Q0E, 0, NotSerialized) 
        {
            If (ATKP)
            {
                \_SB.ATKD.IANE (0x20)
            }
        }
        
        // F6 key
        Method (_Q0F, 0, NotSerialized) 
        {
            If (ATKP)
            {
                \_SB.ATKD.IANE (0x10)
            }
        }
        
        // F7 key
        Method (_Q10, 0, NotSerialized) 
        {
            If (ATKP)
            {
                \_SB.ATKD.IANE (0x35)
            }
        }
        
        // F8 key
        Method (_Q11, 0, NotSerialized) 
        {
            If (ATKP)
            {
                \_SB.ATKD.IANE (0x61)
            }
        }
        
        // patch Fn+A
        Method (_Q76, 0, NotSerialized)
        {
            If (ATKP)
            {
                \_SB.ATKD.IANE (0x7A)
            }
        }
    }
}