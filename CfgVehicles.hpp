class CfgVehicles
{
    class Man;

    class CAManBase: Man
    {
        class ACE_SelfActions
        {
            class ACE_Equipment
            {
                class UKSF_Helmet
                {
                    displayName = "Helmet";
                    icon = "";
                    condition = "!(headgear _player isEqualTo '')";
                    statement = "";

                    class UKSF_Strobes
                    {
                        displayName = "Strobe";
                        icon = "";
                        condition = "[_player] call UKSF_Strobes_fnc_canUseStrobe";
                        statement = "";
                        insertChildren = "_this call UKSF_Strobes_fnc_getActions";
                    };

                    class UKSF_Strobes_Calibration
                    {
                        displayName = "Strobe Calibration";
                        icon = "";
                        condition = "(_player getVariable ['UKSF_Strobes_calibrationActive',false]) || ((missionNamespace getVariable ['UKSF_Strobes_calibrationEnabled',false]) && ([_player] call UKSF_Strobes_fnc_canUseStrobe))";
                        statement = "";
                        insertChildren = "_this call UKSF_Strobes_fnc_getCalibrationActions";
                    };
                };
            };
        };
    };

    class ACE_IR_Strobe_Effect;

    class UKSF_Strobes_IR_Flash_Dim: ACE_IR_Strobe_Effect
    {
        scope = 1;
        displayName = "UKSF IR Flash Dim";

        class NVGMarker
        {
            diffuse[] = {0.015,0.015,0.015};
            ambient[] = {0.001,0.001,0.001};
            brightness = 0.20;
            name = "pozicni blik";
            activeLight = 0;
            blinking = 1;
            dayLight = 0;
            onlyInNvg = 1;
            useFlare = 0;
            maxLifetime = 28800;
            blinkingPattern[] = {0.1,1.1};
            blinkingStartsOn = 1;
            blinkingPatternGuarantee = 1;
        };
    };

    class UKSF_Strobes_IR_Flash: ACE_IR_Strobe_Effect
    {
        scope = 1;
        displayName = "UKSF IR Flash";
    };

    class UKSF_Strobes_IR_Flash_Bright: ACE_IR_Strobe_Effect
    {
        scope = 1;
        displayName = "UKSF IR Flash Bright";

        class NVGMarker
        {
            diffuse[] = {0.015,0.015,0.015};
            ambient[] = {0.001,0.001,0.001};
            brightness = 0.90;
            name = "pozicni blik";
            activeLight = 0;
            blinking = 1;
            dayLight = 0;
            onlyInNvg = 1;
            useFlare = 0;
            maxLifetime = 28800;
            blinkingPattern[] = {0.1,1.1};
            blinkingStartsOn = 1;
            blinkingPatternGuarantee = 1;
        };
    };

    class UKSF_Strobes_IR_Steady: ACE_IR_Strobe_Effect
    {
        scope = 1;
        displayName = "UKSF IR Steady";

        class NVGMarker
        {
            diffuse[] = {0.015,0.015,0.015};
            ambient[] = {0.001,0.001,0.001};
            brightness = 0.45;
            name = "pozicni blik";
            activeLight = 0;
            blinking = 0;
            dayLight = 0;
            onlyInNvg = 1;
            useFlare = 0;
            maxLifetime = 28800;
            blinkingStartsOn = 1;
            blinkingPatternGuarantee = 1;
        };
    };
};