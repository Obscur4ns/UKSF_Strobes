params [
    ["_unit", player, [objNull]]
];

if (
    !hasInterface ||
    {isNull _unit} ||
    {!local _unit} ||
    {!(_unit getVariable ["UKSF_Strobes_calibrationActive", false])}
) exitWith {false};

private _steps = [0.05,0.01,0.001];
private _currentStep = _unit getVariable ["UKSF_Strobes_calibrationStep", 0.01];

private _index = _steps findIf {
    abs (_x - _currentStep) < 0.00001
};

if (_index < 0) then {
    _index = 1;
};

private _nextIndex = (_index + 1) mod count _steps;
private _nextStep = _steps # _nextIndex;

_unit setVariable ["UKSF_Strobes_calibrationStep", _nextStep, false];

[_unit] call UKSF_Strobes_fnc_updateCalibration;

true