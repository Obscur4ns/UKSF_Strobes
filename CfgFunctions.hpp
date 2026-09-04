class CfgFunctions
{
    class UKSF_Strobes
    {
        tag = "UKSF_Strobes";

        class Core
        {
            file = "\UKSF_Strobes\Functions\Core";

            class init
            {
                preInit = 1;
            };

            class getStrobeType {};
            class getStrobeConfig {};
            class getStrobeState {};
            class setStrobeState {};
        };

        class Effects
        {
            file = "\UKSF_Strobes\Functions\Effects";

            class applyEffects {};
            class clearEffects {};
            class createVisibleEmitter {};
            class createIREmitter {};
            class startSignal {};
        };

        class Interaction
        {
            file = "\UKSF_Strobes\Functions\Interaction";

            class canUseStrobe {};
            class getActions {};
        };

        class Calibration
        {
            file = "\UKSF_Strobes\Functions\Calibration";

            class startCalibration {};
            class stopCalibration {};
            class updateCalibration {};
            class adjustCalibration {};
            class cycleCalibrationStep {};
            class copyCalibrationOffset {};
            class getCalibrationActions {};
        };
    };
};