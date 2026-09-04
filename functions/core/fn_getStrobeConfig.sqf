params [
    ["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {configNull};

private _strobeType = [_unit] call UKSF_Strobes_fnc_getStrobeType;
if (_strobeType isEqualTo "") exitWith {configNull};

private _config = configFile >> "CfgUKSFStrobes" >> _strobeType;
if !(isClass _config) exitWith {configNull};

_config