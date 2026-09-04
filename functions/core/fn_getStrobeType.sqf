params [
    ["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {""};

private _helmet = headgear _unit;
if (_helmet isEqualTo "") exitWith {""};

private _helmetConfig = configFile >> "CfgWeapons" >> _helmet;
if !(isClass _helmetConfig) exitWith {""};

private _strobeType = getText (_helmetConfig >> "UKSF_strobeType");
if (_strobeType isEqualTo "") exitWith {""};

if !(isClass (configFile >> "CfgUKSFStrobes" >> _strobeType)) exitWith {""};

_strobeType