["UKSF_Strobes_stateChanged", {
    params ["_unit", "_strobeType", "_state"];

    if (!hasInterface || {isNull _unit}) exitWith {};

    [_unit, _strobeType, _state] call UKSF_Strobes_fnc_applyEffects;
}] call CBA_fnc_addEventHandler;

if (hasInterface) then {
    ["unit", {
        params ["_unit", "_oldUnit"];

        if (
            !isNull _oldUnit &&
            {_oldUnit != _unit} &&
            {_oldUnit getVariable ["UKSF_Strobes_calibrationActive", false]}
        ) then {
            [_oldUnit] call UKSF_Strobes_fnc_stopCalibration;
        };

        if (isNull _unit) exitWith {};

        if ((_unit getVariable ["UKSF_Strobes_killedEH", -1]) < 0) then {
            private _killedEH = _unit addEventHandler ["Killed", {
                params ["_unit"];

                if (_unit getVariable ["UKSF_Strobes_calibrationActive", false]) then {
                    [_unit] call UKSF_Strobes_fnc_stopCalibration;
                };

                _unit setVariable [
                    "UKSF_Strobes_requestID",
                    (_unit getVariable ["UKSF_Strobes_requestID", 0]) + 1,
                    false
                ];

                private _storedState = _unit getVariable ["UKSF_Strobes_state", []];
                private _strobeType = _storedState param [0, "", [""]];

                if (_strobeType isEqualTo "") then {
                    _strobeType = [_unit] call UKSF_Strobes_fnc_getStrobeType;
                };

                if (_strobeType isEqualTo "") then {
                    _unit setVariable ["UKSF_Strobes_state", [], true];
                } else {
                    _unit setVariable ["UKSF_Strobes_state", [_strobeType, "OFF"], true];
                };

                private _jipID = format ["UKSF_Strobes_state_%1", netId _unit];

                [
                    "UKSF_Strobes_stateChanged",
                    [_unit, _strobeType, "OFF"],
                    _jipID
                ] call CBA_fnc_globalEventJIP;

                [_jipID, _unit] call CBA_fnc_removeGlobalEventJIP;
            }];

            _unit setVariable ["UKSF_Strobes_killedEH", _killedEH, false];
        };
    }, true] call CBA_fnc_addPlayerEventHandler;

    ["loadout", {
        params ["_unit"];

        private _helmet = headgear _unit;

        if (_unit getVariable ["UKSF_Strobes_calibrationActive", false]) then {
            private _calibrationHelmet = _unit getVariable ["UKSF_Strobes_calibrationHelmet", ""];

            if !(_helmet isEqualTo _calibrationHelmet) then {
                [_unit] call UKSF_Strobes_fnc_stopCalibration;
            };
        };

        private _lastHelmet = _unit getVariable ["UKSF_Strobes_lastHelmet", _helmet];
        if (_helmet isEqualTo _lastHelmet) exitWith {};

        _unit setVariable ["UKSF_Strobes_lastHelmet", _helmet, false];

        private _currentType = [_unit] call UKSF_Strobes_fnc_getStrobeType;
        private _storedState = _unit getVariable ["UKSF_Strobes_state", []];
        private _storedType = _storedState param [0, "", [""]];
        private _state = _storedState param [1, "OFF", [""]];

        if (_storedType isEqualTo "" && {_state isEqualTo "OFF"}) exitWith {};

        if (_currentType isEqualTo "") then {
            _unit setVariable ["UKSF_Strobes_state", [], true];
        } else {
            _unit setVariable ["UKSF_Strobes_state", [_currentType, "OFF"], true];
        };

        private _jipID = format ["UKSF_Strobes_state_%1", netId _unit];

        [
            "UKSF_Strobes_stateChanged",
            [_unit, _currentType, "OFF"],
            _jipID
        ] call CBA_fnc_globalEventJIP;

        [_jipID, _unit] call CBA_fnc_removeGlobalEventJIP;
    }, true] call CBA_fnc_addPlayerEventHandler;
};