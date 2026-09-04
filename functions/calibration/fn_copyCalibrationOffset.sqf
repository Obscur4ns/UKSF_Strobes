params [
    ["_unit", player, [objNull]]
];

if (
    !hasInterface ||
    {isNull _unit} ||
    {!local _unit} ||
    {!(_unit getVariable ["UKSF_Strobes_calibrationActive", false])}
) exitWith {false};

private _offset = _unit getVariable ["UKSF_Strobes_calibrationOffset", [0,0,0]];

if ((count _offset) != 3) exitWith {false};

private _output = format [
    "UKSF_strobeOffset[] = {%1,%2,%3};",
    (_offset # 0) toFixed 3,
    (_offset # 1) toFixed 3,
    (_offset # 2) toFixed 3
];

missionNamespace setVariable ["UKSF_Strobes_calibrationOutput", _output];

if (isServer) then {
    copyToClipboard _output;
};

diag_log format ["[UKSF Strobes] Calibration: %1", _output];

hintSilent format [
    "Strobe Calibration\n\n%1\n\n%2",
    _output,
    if (isServer) then {
        "Copied to clipboard"
    } else {
        "Saved to UKSF_Strobes_calibrationOutput and RPT"
    }
];

true