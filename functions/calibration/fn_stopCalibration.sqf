params [
    ["_unit", player, [objNull]]
];

if (!hasInterface || {isNull _unit}) exitWith {false};

private _marker = _unit getVariable ["UKSF_Strobes_calibrationMarker", objNull];

if (!isNull _marker) then {
    detach _marker;
    deleteVehicle _marker;
};

_unit setVariable ["UKSF_Strobes_calibrationActive", false, false];
_unit setVariable ["UKSF_Strobes_calibrationMarker", objNull, false];
_unit setVariable ["UKSF_Strobes_calibrationHelmet", nil, false];
_unit setVariable ["UKSF_Strobes_calibrationBone", nil, false];
_unit setVariable ["UKSF_Strobes_calibrationOffset", nil, false];
_unit setVariable ["UKSF_Strobes_calibrationStep", nil, false];

hintSilent "";

true