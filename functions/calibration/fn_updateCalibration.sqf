params [
    ["_unit", player, [objNull]]
];

if (
    !hasInterface ||
    {isNull _unit} ||
    {!local _unit} ||
    {!(_unit getVariable ["UKSF_Strobes_calibrationActive", false])}
) exitWith {false};

private _helmet = headgear _unit;
private _calibrationHelmet = _unit getVariable ["UKSF_Strobes_calibrationHelmet", ""];

if (
    _helmet isEqualTo "" ||
    {!(_helmet isEqualTo _calibrationHelmet)}
) exitWith {
    [_unit] call UKSF_Strobes_fnc_stopCalibration;
    false
};

private _marker = _unit getVariable ["UKSF_Strobes_calibrationMarker", objNull];

if (isNull _marker) exitWith {
    [_unit] call UKSF_Strobes_fnc_stopCalibration;
    false
};

private _bone = _unit getVariable ["UKSF_Strobes_calibrationBone", "head"];
private _offset = _unit getVariable ["UKSF_Strobes_calibrationOffset", [0,0,0]];
private _step = _unit getVariable ["UKSF_Strobes_calibrationStep", 0.01];

if ((count _offset) != 3) then {
    _offset = [0,0,0];
    _unit setVariable ["UKSF_Strobes_calibrationOffset", _offset, false];
};

_marker attachTo [_unit,_offset,_bone,true];

hintSilent format [
    "Strobe Calibration\n\nX: %1\nY: %2\nZ: %3\n\nStep: %4 m",
    (_offset # 0) toFixed 3,
    (_offset # 1) toFixed 3,
    (_offset # 2) toFixed 3,
    _step toFixed 3
];

true