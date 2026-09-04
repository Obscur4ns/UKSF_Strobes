params [
    ["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {""};

private _strobeType = [_unit] call UKSF_Strobes_fnc_getStrobeType;
if (_strobeType isEqualTo "") exitWith {""};

private _strobeConfig = [_unit] call UKSF_Strobes_fnc_getStrobeConfig;
if (isNull _strobeConfig) exitWith {""};

private _states = getArray (_strobeConfig >> "states");
if (_states isEqualTo []) exitWith {""};

private _defaultState = getText (_strobeConfig >> "defaultState");
if !(_defaultState in _states) then {
    _defaultState = _states param [0, "OFF", [""]];
};

private _storedState = _unit getVariable ["UKSF_Strobes_state", []];
if !(_storedState isEqualType [] && {count _storedState >= 2}) exitWith {_defaultState};

private _storedType = _storedState param [0, "", [""]];
private _state = _storedState param [1, "", [""]];

if !(_storedType isEqualTo _strobeType) exitWith {_defaultState};
if !(_state in _states) exitWith {_defaultState};

_state