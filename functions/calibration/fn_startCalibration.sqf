params [
    ["_unit", player, [objNull]]
];

if (
    !hasInterface ||
    {isNull _unit} ||
    {!local _unit} ||
    {!alive _unit}
) exitWith {false};

private _strobeType = [_unit] call UKSF_Strobes_fnc_getStrobeType;
if (_strobeType isEqualTo "") exitWith {false};

if (_unit getVariable ["UKSF_Strobes_calibrationActive", false]) then {
    [_unit] call UKSF_Strobes_fnc_stopCalibration;
};

private _helmet = headgear _unit;
private _helmetConfig = configFile >> "CfgWeapons" >> _helmet;
if !(isClass _helmetConfig) exitWith {false};

private _bone = getText (_helmetConfig >> "UKSF_strobeBone");
private _offset = getArray (_helmetConfig >> "UKSF_strobeOffset");

if (_bone isEqualTo "") then {
    _bone = "head";
};

if ((count _offset) != 3) then {
    _offset = [0,0,0];
};

private _marker = "Sign_Sphere10cm_F" createVehicleLocal (getPosATL _unit);
if (isNull _marker) exitWith {false};

_marker setObjectTexture [0,"#(argb,8,8,3)color(1,0,1,1)"];
_marker setObjectScale 0.25;
_marker attachTo [_unit,_offset,_bone,true];

_unit setVariable ["UKSF_Strobes_calibrationActive", true, false];
_unit setVariable ["UKSF_Strobes_calibrationMarker", _marker, false];
_unit setVariable ["UKSF_Strobes_calibrationHelmet", _helmet, false];
_unit setVariable ["UKSF_Strobes_calibrationBone", _bone, false];
_unit setVariable ["UKSF_Strobes_calibrationOffset", +_offset, false];
_unit setVariable ["UKSF_Strobes_calibrationStep", 0.01, false];

[_unit] call UKSF_Strobes_fnc_updateCalibration;

true