params [
    ["_unit", objNull, [objNull]]
];

if (isNull _unit || {!alive _unit}) exitWith {false};

!(([_unit] call UKSF_Strobes_fnc_getStrobeType) isEqualTo "")