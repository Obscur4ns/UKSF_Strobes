params [
    ["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {false};

private _generation = (_unit getVariable ["UKSF_Strobes_effectGeneration", 0]) + 1;
_unit setVariable ["UKSF_Strobes_effectGeneration", _generation, false];

private _handles = _unit getVariable ["UKSF_Strobes_effectPFHs", []];

{
    if (_x isEqualType 0 && {_x >= 0}) then {
        [_x] call CBA_fnc_removePerFrameHandler;
    };
} forEach _handles;

_unit setVariable ["UKSF_Strobes_effectPFHs", [], false];

private _objects = _unit getVariable ["UKSF_Strobes_effectObjects", []];

{
    if (_x isEqualType objNull && {!isNull _x}) then {
        deleteVehicle _x;
    };
} forEach _objects;

_unit setVariable ["UKSF_Strobes_effectObjects", [], false];
_unit setVariable ["UKSF_Strobes_renderedType", "", false];
_unit setVariable ["UKSF_Strobes_renderedState", "", false];

true