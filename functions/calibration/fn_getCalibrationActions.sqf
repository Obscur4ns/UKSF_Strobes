params ["_target", "_player", ["_params", []]];

if (isNull _player) exitWith {[]};

private _actions = [];
private _active = _player getVariable ["UKSF_Strobes_calibrationActive", false];

if (!_active) exitWith {
    if (([_player] call UKSF_Strobes_fnc_getStrobeType) isEqualTo "") exitWith {[]};

    private _action = [
        "UKSF_Strobes_Calibration_Start",
        "Start Calibration",
        "",
        {
            params ["_target", "_player"];
            [_player] call UKSF_Strobes_fnc_startCalibration;
        },
        {
            params ["_target", "_player"];

            !(_player getVariable ["UKSF_Strobes_calibrationActive", false]) &&
            {!(([_player] call UKSF_Strobes_fnc_getStrobeType) isEqualTo "")}
        }
    ] call ace_interact_menu_fnc_createAction;

    [[_action, [], _target]]
};

{
    _x params ["_name", "_displayName", "_axis", "_direction"];

    private _action = [
        _name,
        _displayName,
        "",
        {
            params ["_target", "_player", "_params"];
            _params params ["_axis", "_direction"];

            [_player, _axis, _direction] call UKSF_Strobes_fnc_adjustCalibration;
        },
        {
            params ["_target", "_player"];

            _player getVariable ["UKSF_Strobes_calibrationActive", false]
        },
        {},
        [_axis, _direction]
    ] call ace_interact_menu_fnc_createAction;

    _actions pushBack [_action, [], _target];
} forEach [
    ["UKSF_Strobes_Calibration_XPlus", "X +", "X", 1],
    ["UKSF_Strobes_Calibration_XMinus", "X -", "X", -1],
    ["UKSF_Strobes_Calibration_YPlus", "Y +", "Y", 1],
    ["UKSF_Strobes_Calibration_YMinus", "Y -", "Y", -1],
    ["UKSF_Strobes_Calibration_ZPlus", "Z +", "Z", 1],
    ["UKSF_Strobes_Calibration_ZMinus", "Z -", "Z", -1]
];

private _step = _player getVariable ["UKSF_Strobes_calibrationStep", 0.01];

private _stepAction = [
    "UKSF_Strobes_Calibration_Step",
    format ["Step Size: %1 m", _step toFixed 3],
    "",
    {
        params ["_target", "_player"];
        [_player] call UKSF_Strobes_fnc_cycleCalibrationStep;
    },
    {
        params ["_target", "_player"];

        _player getVariable ["UKSF_Strobes_calibrationActive", false]
    }
] call ace_interact_menu_fnc_createAction;

_actions pushBack [_stepAction, [], _target];

private _copyAction = [
    "UKSF_Strobes_Calibration_Copy",
    "Copy Offset",
    "",
    {
        params ["_target", "_player"];
        [_player] call UKSF_Strobes_fnc_copyCalibrationOffset;
    },
    {
        params ["_target", "_player"];

        _player getVariable ["UKSF_Strobes_calibrationActive", false]
    }
] call ace_interact_menu_fnc_createAction;

_actions pushBack [_copyAction, [], _target];

private _stopAction = [
    "UKSF_Strobes_Calibration_Stop",
    "Stop Calibration",
    "",
    {
        params ["_target", "_player"];
        [_player] call UKSF_Strobes_fnc_stopCalibration;
    },
    {
        params ["_target", "_player"];

        _player getVariable ["UKSF_Strobes_calibrationActive", false]
    }
] call ace_interact_menu_fnc_createAction;

_actions pushBack [_stopAction, [], _target];

_actions