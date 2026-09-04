class CfgUKSFStrobes
{
    class Signals
    {
        class GREEN_STEADY
        {
            spectrum = "VISIBLE";
            colour = "GREEN";
            pattern = "STEADY";
            intensity = "STANDARD";
        };

        class WHITE_FLASH
        {
            spectrum = "VISIBLE";
            colour = "WHITE";
            pattern = "FLASH";
            intensity = "BRIGHT";
            flashRate = 60;
        };

        class WHITE_FLASH_DIM
        {
            spectrum = "VISIBLE";
            colour = "WHITE";
            pattern = "FLASH";
            intensity = "DIM";
            flashRate = 60;
        };

        class IR_FLASH_DIM
        {
            spectrum = "IR";
            pattern = "FLASH";
            intensity = "DIM";
            flashRate = 60;
        };

        class IR_FLASH
        {
            spectrum = "IR";
            pattern = "FLASH";
            intensity = "STANDARD";
            flashRate = 60;
        };

        class IR_FLASH_BRIGHT
        {
            spectrum = "IR";
            pattern = "FLASH";
            intensity = "BRIGHT";
            flashRate = 60;
        };

        class IR_STEADY
        {
            spectrum = "IR";
            pattern = "STEADY";
            intensity = "STANDARD";
        };
    };

    class HELSTAR6_GEN3PLUS
    {
        displayName = "HEL-STAR 6 Gen III+";
        family = "HELSTAR6";
        profile = "HS-640-03";
        defaultState = "OFF";
        states[] = {"OFF","A1","A2","B1","B2"};
        operateAnimation = "UKSF_Strobes_Operate";
        switchDelay = 0.45;

        class Emitters
        {
            class PRIMARY
            {
                offset[] = {0,0,0};
            };
        };

        class StateData
        {
            class OFF
            {
                displayName = "Off";
                mode = "OFF";
                position = 0;
                class Signals {};
            };

            class A1
            {
                displayName = "A1 - Green Steady";
                mode = "A";
                position = 1;

                class Signals
                {
                    class Green
                    {
                        type = "GREEN_STEADY";
                        emitters[] = {"PRIMARY"};
                    };
                };
            };

            class A2
            {
                displayName = "A2 - Green / White";
                mode = "A";
                position = 2;

                class Signals
                {
                    class Green
                    {
                        type = "GREEN_STEADY";
                        emitters[] = {"PRIMARY"};
                    };

                    class White
                    {
                        type = "WHITE_FLASH";
                        emitters[] = {"PRIMARY"};
                    };
                };
            };

            class B1
            {
                displayName = "B1 - IR Flash";
                mode = "B";
                position = 1;

                class Signals
                {
                    class IR
                    {
                        type = "IR_FLASH";
                        emitters[] = {"PRIMARY"};
                    };
                };
            };

            class B2
            {
                displayName = "B2 - IR Steady";
                mode = "B";
                position = 2;

                class Signals
                {
                    class IR
                    {
                        type = "IR_STEADY";
                        emitters[] = {"PRIMARY"};
                    };
                };
            };
        };
    };

    class HELSTAR5_EXO
    {
        displayName = "HEL-STAR 5 EXO";
        family = "HELSTAR5";
        profile = "HS-501X";
        defaultState = "OFF";
        states[] = {"OFF","M1","M2","M3"};
        operateAnimation = "UKSF_Strobes_Operate";
        switchDelay = 0.45;

        class Emitters
        {
            class PRIMARY
            {
                offset[] = {0,0,0};
            };
        };

        class StateData
        {
            class OFF
            {
                displayName = "Off";
                mode = "OFF";
                position = 0;
                class Signals {};
            };

            class M1
            {
                displayName = "M1 - Green / White";
                mode = "M1";
                position = 1;

                class Signals
                {
                    class Green
                    {
                        type = "GREEN_STEADY";
                        emitters[] = {"PRIMARY"};
                    };

                    class White
                    {
                        type = "WHITE_FLASH";
                        emitters[] = {"PRIMARY"};
                    };
                };
            };

            class M2
            {
                displayName = "M2 - Green Steady";
                mode = "M2";
                position = 2;

                class Signals
                {
                    class Green
                    {
                        type = "GREEN_STEADY";
                        emitters[] = {"PRIMARY"};
                    };
                };
            };

            class M3
            {
                displayName = "M3 - IR Flash";
                mode = "M3";
                position = 3;

                class Signals
                {
                    class IR
                    {
                        type = "IR_FLASH";
                        emitters[] = {"PRIMARY"};
                    };
                };
            };
        };
    };

    class HELSTAR6_640
    {
        displayName = "HEL-STAR 6 640 Series";
        family = "HELSTAR6";
        profile = "HS-640-01";
        defaultState = "OFF";
        states[] = {"OFF","A1","A2","B1","B2"};
        operateAnimation = "UKSF_Strobes_Operate";
        switchDelay = 0.45;

        class Emitters
        {
            class PRIMARY
            {
                offset[] = {0,0,0};
            };
        };

        class StateData
        {
            class OFF
            {
                displayName = "Off";
                mode = "OFF";
                position = 0;
                class Signals {};
            };

            class A1
            {
                displayName = "A1 - Green Steady";
                mode = "A";
                position = 1;

                class Signals
                {
                    class Green
                    {
                        type = "GREEN_STEADY";
                        emitters[] = {"PRIMARY"};
                    };
                };
            };

            class A2
            {
                displayName = "A2 - Green / White";
                mode = "A";
                position = 2;

                class Signals
                {
                    class Green
                    {
                        type = "GREEN_STEADY";
                        emitters[] = {"PRIMARY"};
                    };

                    class White
                    {
                        type = "WHITE_FLASH";
                        emitters[] = {"PRIMARY"};
                    };
                };
            };

            class B1
            {
                displayName = "B1 - IR Flash";
                mode = "B";
                position = 1;

                class Signals
                {
                    class IR
                    {
                        type = "IR_FLASH";
                        emitters[] = {"PRIMARY"};
                    };
                };
            };

            class B2
            {
                displayName = "B2 - IR Flash Bright";
                mode = "B";
                position = 2;

                class Signals
                {
                    class IR
                    {
                        type = "IR_FLASH_BRIGHT";
                        emitters[] = {"PRIMARY"};
                    };
                };
            };
        };
    };

    class MANTA_OLD
    {
        displayName = "S&S Precision Manta";
        family = "MANTA";
        profile = "MS-0015";
        defaultState = "OFF";
        states[] = {"OFF","IR_NEAR","IR_FAR","GREEN","GREEN_WHITE"};
        operateAnimation = "UKSF_Strobes_Operate";
        switchDelay = 0.45;

        class Emitters
        {
            class PRIMARY
            {
                offset[] = {0,0,0};
            };
        };

        class StateData
        {
            class OFF
            {
                displayName = "Off";
                mode = "OFF";
                position = 0;
                class Signals {};
            };

            class IR_NEAR
            {
                displayName = "IR - Near IFF";
                mode = "IR";
                position = 1;

                class Signals
                {
                    class IR
                    {
                        type = "IR_FLASH_DIM";
                        emitters[] = {"PRIMARY"};
                    };
                };
            };

            class IR_FAR
            {
                displayName = "IR - Far IFF";
                mode = "IR";
                position = 2;

                class Signals
                {
                    class IR
                    {
                        type = "IR_FLASH_BRIGHT";
                        emitters[] = {"PRIMARY"};
                    };
                };
            };

            class GREEN
            {
                displayName = "Green Steady";
                mode = "VISIBLE";
                position = 3;

                class Signals
                {
                    class Green
                    {
                        type = "GREEN_STEADY";
                        emitters[] = {"PRIMARY"};
                    };
                };
            };

            class GREEN_WHITE
            {
                displayName = "Green / White";
                mode = "VISIBLE";
                position = 4;

                class Signals
                {
                    class Green
                    {
                        type = "GREEN_STEADY";
                        emitters[] = {"PRIMARY"};
                    };

                    class White
                    {
                        type = "WHITE_FLASH";
                        emitters[] = {"PRIMARY"};
                    };
                };
            };
        };
    };

    class MANTA_NEW
    {
        displayName = "S&S Precision Manta";
        family = "MANTA";
        profile = "MS-0011";
        defaultState = "OFF";
        states[] = {"OFF","IR_FAR","GREEN"};
        operateAnimation = "UKSF_Strobes_Operate";
        switchDelay = 0.45;

        class Emitters
        {
            class PRIMARY
            {
                offset[] = {0,0,0};
            };
        };

        class StateData
        {
            class OFF
            {
                displayName = "Off";
                mode = "OFF";
                position = 0;
                class Signals {};
            };

            class IR_FAR
            {
                displayName = "IR - Far IFF";
                mode = "IR";
                position = 1;

                class Signals
                {
                    class IR
                    {
                        type = "IR_FLASH_BRIGHT";
                        emitters[] = {"PRIMARY"};
                    };
                };
            };

            class GREEN
            {
                displayName = "Green Steady";
                mode = "VISIBLE";
                position = 2;

                class Signals
                {
                    class Green
                    {
                        type = "GREEN_STEADY";
                        emitters[] = {"PRIMARY"};
                    };
                };
            };
        };
    };

    class HELSTAR_RAIL
    {
        displayName = "HEL-STAR Rail Strobe";
        family = "HELSTAR_RAIL";
        profile = "RAIL";
        defaultState = "OFF";
        states[] = {"OFF","VIS_DIM","VIS_BRIGHT","IR_DIM","IR_BRIGHT"};
        operateAnimation = "UKSF_Strobes_Operate";
        switchDelay = 0.45;
        useHelmetOffset = 0;

        class Emitters
        {
            class LEFT
            {
                offset[] = {-0.150,-0.140,0.200};
            };

            class RIGHT
            {
                offset[] = {0.050,-0.140,0.200};
            };
        };

        class StateData
        {
            class OFF
            {
                displayName = "Off";
                mode = "OFF";
                position = 0;
                class Signals {};
            };

            class VIS_DIM
            {
                displayName = "Visible - Dim";
                mode = "VIS";
                position = 1;

                class Signals
                {
                    class White
                    {
                        type = "WHITE_FLASH_DIM";
                        emitters[] = {"LEFT","RIGHT"};
                    };
                };
            };

            class VIS_BRIGHT
            {
                displayName = "Visible - Bright";
                mode = "VIS";
                position = 2;

                class Signals
                {
                    class White
                    {
                        type = "WHITE_FLASH";
                        emitters[] = {"LEFT","RIGHT"};
                    };
                };
            };

            class IR_DIM
            {
                displayName = "IR - Dim";
                mode = "IR";
                position = 1;

                class Signals
                {
                    class IR
                    {
                        type = "IR_FLASH_DIM";
                        emitters[] = {"LEFT","RIGHT"};
                    };
                };
            };

            class IR_BRIGHT
            {
                displayName = "IR - Bright";
                mode = "IR";
                position = 2;

                class Signals
                {
                    class IR
                    {
                        type = "IR_FLASH_BRIGHT";
                        emitters[] = {"LEFT","RIGHT"};
                    };
                };
            };
        };
    };
};