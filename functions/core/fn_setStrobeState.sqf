params [
    ["_unit", objNull, [objNull]],
    ["_state", "", [""]]
];

if (
    isNull _unit ||
    {!local _unit} ||
    {!alive _unit} ||
    {_state isEqualTo ""}
) exitWith {false};

private _strobeType = [_unit] call UKSF_Strobes_fnc_getStrobeType;
if (_strobeType isEqualTo "") exitWith {false};

private _strobeConfig = [_unit] call UKSF_Strobes_fnc_getStrobeConfig;
if (isNull _strobeConfig) exitWith {false};

private _states = getArray (_strobeConfig >> "states");
if !(_state in _states) exitWith {false};

private _currentState = [_unit] call UKSF_Strobes_fnc_getStrobeState;
if (_state isEqualTo _currentState) exitWith {true};

private _animation = getText (_strobeConfig >> "operateAnimation");
private _switchDelay = 0 max getNumber (_strobeConfig >> "switchDelay");

if !(_animation isEqualTo "") then {
    _unit playActionNow _animation;
};

private _requestID = (_unit getVariable ["UKSF_Strobes_requestID", 0]) + 1;
_unit setVariable ["UKSF_Strobes_requestID", _requestID, false];

[{
    params [
        "_unit",
        "_strobeType",
        "_state",
        "_requestID"
    ];

    if (
        isNull _unit ||
        {!local _unit} ||
        {!alive _unit}
    ) exitWith {};

    if (
        (_unit getVariable ["UKSF_Strobes_requestID", 0]) != _requestID
    ) exitWith {};

    if !(
        ([_unit] call UKSF_Strobes_fnc_getStrobeType) isEqualTo _strobeType
    ) exitWith {};

    private _strobeConfig = [_unit] call UKSF_Strobes_fnc_getStrobeConfig;
    if (isNull _strobeConfig) exitWith {};

    if !(_state in getArray (_strobeConfig >> "states")) exitWith {};

    _unit setVariable ["UKSF_Strobes_lastHelmet", headgear _unit, false];
    _unit setVariable ["UKSF_Strobes_state", [_strobeType, _state], true];

    private _jipID = format [
        "UKSF_Strobes_state_%1",
        netId _unit
    ];

    [
        "UKSF_Strobes_stateChanged",
        [_unit, _strobeType, _state],
        _jipID
    ] call CBA_fnc_globalEventJIP;

    [_jipID, _unit] call CBA_fnc_removeGlobalEventJIP;
}, [
    _unit,
    _strobeType,
    _state,
    _requestID
], _switchDelay] call CBA_fnc_waitAndExecute;

true