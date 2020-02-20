DefinitionBlock ("", "SSDT", 2, "hack", "_UIAC", 0)
{
    Device(UIAC)
    {
        Name(_HID, "UIA00000")

        Name(RMCF, Package()
        {
            // EHC1 (8086_1e26)
            "EHC1", Package()
            {
                "port-count", Buffer() { 0x01, 0x00, 0x00, 0x00 },
                "ports", Package()
                {
                      "PRT1", Package()
                      {
                          "UsbConnector", 255,
                          "port", Buffer() { 0x01, 0x00, 0x00, 0x00 },
                      },
                },
            },
            // EHC2 (8086_1e2d)
            "EHC2", Package()
            {
                "port-count", Buffer() { 0x01, 0x00, 0x00, 0x00 },
                "ports", Package()
                {
                      "PRT1", Package()
                      {
                          "UsbConnector", 255,
                          "port", Buffer() { 0x01, 0x00, 0x00, 0x00 },
                      },
                },
            },
            // HUB2 (8086_1e2d)
            "HUB2", Package()
            {
                "port-count", Buffer() { 0x04, 0x00, 0x00, 0x00 },
                "ports", Package()
                {
                      "HP24", Package()
                      {
                          "portType", 255,
                          "port", Buffer() { 0x04, 0x00, 0x00, 0x00 },
                      },
                },
            },
            // HUB1 (8086_1e26)
            "HUB1", Package()
            {
                "port-count", Buffer() { 0x06, 0x00, 0x00, 0x00 },
                "ports", Package()
                {
                      "HP16", Package()
                      {
                          "portType", 255,
                          "port", Buffer() { 0x06, 0x00, 0x00, 0x00 },
                      },
                      "HP12", Package()
                      {
                          "portType", 0,
                          "port", Buffer() { 0x02, 0x00, 0x00, 0x00 },
                      },
                      "HP15", Package()
                      {
                          "portType", 255,
                          "port", Buffer() { 0x05, 0x00, 0x00, 0x00 },
                      },
                      "HP13", Package()
                      {
                          "portType", 0,
                          "port", Buffer() { 0x03, 0x00, 0x00, 0x00 },
                      },
                      "HP11", Package()
                      {
                          "portType", 0,
                          "port", Buffer() { 0x01, 0x00, 0x00, 0x00 },
                      },
                },
            },
            // XHC1 (8086_1e31)
            "XHC1", Package()
            {
                "port-count", Buffer() { 0x06, 0x00, 0x00, 0x00 },
                "ports", Package()
                {
                      "PRT6", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x06, 0x00, 0x00, 0x00 },
                      },
                      "PRT5", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x05, 0x00, 0x00, 0x00 },
                      },
                },
            },
        })
    }
}
