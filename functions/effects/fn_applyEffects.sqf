params [
    ["_unit", objNull, [objNull]],
    ["_strobeType", "", [""]],
    ["_state", "", [""]]
];

if (isNull _unit) exitWith {false};

[_unit] call UKSF_Strobes_fnc_clearEffects;

if (_state isEqualTo "OFF" || {_strobeType isEqualTo ""}) exitWith {true};

private _currentType = [_unit] call UKSF_Strobes_fnc_getStrobeType;
if !(_currentType isEqualTo _strobeType) exitWith {false};

private _strobeConfig = configFile >> "CfgUKSFStrobes" >> _strobeType;
if !(isClass _strobeConfig) exitWith {false};

private _states = getArray (_strobeConfig >> "states");
if !(_state in _states) exitWith {false};

private _stateConfig = _strobeConfig >> "StateData" >> _state;
if !(isClass _stateConfig) exitWith {false};

private _signalsConfig = _stateConfig >> "Signals";
if !(isClass _signalsConfig) exitWith {false};

private _signals = configProperties [_signalsConfig, "isClass _x", true];
if (_signals isEqualTo []) exitWith {false};

private _success = true;

{
    if !([_unit, _strobeConfig, _x] call UKSF_Strobes_fnc_startSignal) then {
        _success = false;
    };
} forEach _signals;

if (!_success) exitWith {
    [_unit] call UKSF_Strobes_fnc_clearEffects;
    false
};

_unit setVariable ["UKSF_Strobes_renderedType", _strobeType, false];
_unit setVariable ["UKSF_Strobes_renderedState", _state, false];

private _generation = _unit getVariable ["UKSF_Strobes_effectGeneration", 0];
private _helmet = headgear _unit;
private _objects = +(_unit getVariable ["UKSF_Strobes_effectObjects", []]);

private _handle = [{
    params ["_args", "_handle"];

    _args params [
        "_unit",
        "_generation",
        "_helmet",
        "_objects"
    ];

    if (isNull _unit) exitWith {
        {
            if (!isNull _x) then {
                deleteVehicle _x;
            };
        } forEach _objects;

        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    if (
        (_unit getVariable ["UKSF_Strobes_effectGeneration", -1]) != _generation
    ) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    if (
        !alive _unit ||
        {!(headgear _unit isEqualTo _helmet)}
    ) exitWith {
        {
            if (!isNull _x) then {
                deleteVehicle _x;
            };
        } forEach _objects;

        [_handle] call CBA_fnc_removePerFrameHandler;
    };
}, 0.25, [
    _unit,
    _generation,
    _helmet,
    _objects
]] call CBA_fnc_addPerFrameHandler;

private _handles = _unit getVariable ["UKSF_Strobes_effectPFHs", []];
_handles pushBack _handle;
_unit setVariable ["UKSF_Strobes_effectPFHs", _handles, false];

true