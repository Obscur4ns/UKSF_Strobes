params [
    ["_unit", player, [objNull]],
    ["_axis", "", [""]],
    ["_direction", 0, [0]]
];

if (
    !hasInterface ||
    {isNull _unit} ||
    {!local _unit} ||
    {!(_unit getVariable ["UKSF_Strobes_calibrationActive", false])} ||
    {_direction isEqualTo 0}
) exitWith {false};

_axis = toUpper _axis;

private _index = switch (_axis) do {
    case "X": {0};
    case "Y": {1};
    case "Z": {2};
    default {-1};
};

if (_index < 0) exitWith {false};

private _offset = +(_unit getVariable ["UKSF_Strobes_calibrationOffset", [0,0,0]]);
private _step = _unit getVariable ["UKSF_Strobes_calibrationStep", 0.01];

if ((count _offset) != 3 || {_step <= 0}) exitWith {false};

private _value = (_offset # _index) + (_step * (if (_direction > 0) then {1} else {-1}));
_value = parseNumber (_value toFixed 4);

_offset set [_index, _value];

_unit setVariable ["UKSF_Strobes_calibrationOffset", _offset, false];

[_unit] call UKSF_Strobes_fnc_updateCalibration;

true