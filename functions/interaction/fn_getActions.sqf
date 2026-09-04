params ["_target", "_player", ["_params", []]];

if (isNull _player) exitWith {[]};

private _strobeType = [_player] call UKSF_Strobes_fnc_getStrobeType;
if (_strobeType isEqualTo "") exitWith {[]};

private _config = [_player] call UKSF_Strobes_fnc_getStrobeConfig;
if (isNull _config) exitWith {[]};

private _currentState = [_player] call UKSF_Strobes_fnc_getStrobeState;
private _states = getArray (_config >> "states");
private _orderedStates = _states select {_x != "OFF"};

if ("OFF" in _states) then {
    _orderedStates pushBack "OFF";
};

private _actions = [];

{
    private _state = _x;

    if (_state != _currentState) then {
        private _stateConfig = _config >> "StateData" >> _state;

        if (isClass _stateConfig) then {
            private _displayName = getText (_stateConfig >> "displayName");
            if (_displayName isEqualTo "") then {
                _displayName = _state;
            };

            private _action = [
                format ["UKSF_Strobes_%1_%2", _strobeType, _state],
                _displayName,
                "",
                {
                    params ["_target", "_player", "_params"];
                    _params params ["_strobeType", "_state"];

                    if (([_player] call UKSF_Strobes_fnc_getStrobeType) isEqualTo _strobeType) then {
                        [_player, _state] call UKSF_Strobes_fnc_setStrobeState;
                    };
                },
                {
                    params ["_target", "_player", "_params"];
                    _params params ["_strobeType"];

                    [_player] call UKSF_Strobes_fnc_canUseStrobe &&
                    {([_player] call UKSF_Strobes_fnc_getStrobeType) isEqualTo _strobeType}
                },
                {},
                [_strobeType, _state]
            ] call ace_interact_menu_fnc_createAction;

            _actions pushBack [_action, [], _target];
        };
    };
} forEach _orderedStates;

_actions