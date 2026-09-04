params [
    ["_unit", objNull, [objNull]],
    ["_strobeConfig", configNull, [configNull]],
    ["_signalInstance", configNull, [configNull]]
];

if (isNull _unit || {isNull _strobeConfig} || {isNull _signalInstance}) exitWith {false};

private _type = getText (_signalInstance >> "type");
private _signalConfig = configFile >> "CfgUKSFStrobes" >> "Signals" >> _type;
if !(isClass _signalConfig) exitWith {false};

private _spectrum = toUpper getText (_signalConfig >> "spectrum");
private _colour = toUpper getText (_signalConfig >> "colour");
private _pattern = toUpper getText (_signalConfig >> "pattern");
private _intensity = toUpper getText (_signalConfig >> "intensity");
private _flashRate = getNumber (_signalConfig >> "flashRate");

if (isText (_signalInstance >> "colour")) then {
    _colour = toUpper getText (_signalInstance >> "colour");
};

if (isText (_signalInstance >> "pattern")) then {
    _pattern = toUpper getText (_signalInstance >> "pattern");
};

if (isText (_signalInstance >> "intensity")) then {
    _intensity = toUpper getText (_signalInstance >> "intensity");
};

if (isNumber (_signalInstance >> "flashRate")) then {
    _flashRate = getNumber (_signalInstance >> "flashRate");
};

if !(_pattern in ["STEADY","FLASH"]) exitWith {false};

private _helmetConfig = configFile >> "CfgWeapons" >> headgear _unit;
if !(isClass _helmetConfig) exitWith {false};

private _baseBone = getText (_helmetConfig >> "UKSF_strobeBone");
private _baseOffset = getArray (_helmetConfig >> "UKSF_strobeOffset");

if (_baseBone isEqualTo "") then {
    _baseBone = "head";
};

if ((count _baseOffset) != 3) then {
    _baseOffset = [0,0,0];
};

private _useHelmetOffset = if (isNumber (_strobeConfig >> "useHelmetOffset")) then {
    getNumber (_strobeConfig >> "useHelmetOffset") > 0
} else {
    true
};

if (!_useHelmetOffset) then {
    _baseOffset = [0,0,0];
};

private _objects = [];

{
    private _emitterConfig = _strobeConfig >> "Emitters" >> _x;

    if (isClass _emitterConfig) then {
        private _bone = getText (_emitterConfig >> "bone");
        private _emitterOffset = getArray (_emitterConfig >> "offset");

        if (_bone isEqualTo "") then {
            _bone = _baseBone;
        };

        if ((count _emitterOffset) != 3) then {
            _emitterOffset = [0,0,0];
        };

        private _offset = _baseOffset vectorAdd _emitterOffset;
        private _object = objNull;

        switch (_spectrum) do {
            case "VISIBLE": {
                _object = [
                    _unit,
                    _bone,
                    _offset,
                    _colour,
                    _intensity
                ] call UKSF_Strobes_fnc_createVisibleEmitter;
            };

            case "IR": {
                _object = [
                    _unit,
                    _bone,
                    _offset,
                    _intensity,
                    _pattern
                ] call UKSF_Strobes_fnc_createIREmitter;
            };
        };

        if (!isNull _object) then {
            _objects pushBack _object;
        };
    };
} forEach getArray (_signalInstance >> "emitters");

if (_objects isEqualTo []) exitWith {false};

if (_spectrum isEqualTo "IR") exitWith {true};
if (_pattern isEqualTo "STEADY") exitWith {true};

if (_flashRate <= 0) then {
    _flashRate = 60;
};

private _period = 60 / _flashRate;
private _onTime = 0.1 min (_period * 0.5);
private _offTime = _period - _onTime;
private _generation = _unit getVariable ["UKSF_Strobes_effectGeneration", 0];

private _onBrightness = 1;
private _onIntensity = 1000;

if (_intensity isEqualTo "DIM") then {
    _onBrightness = 0.5;
    _onIntensity = 350;
};

{
    _x setLightBrightness 0;
    _x setLightIntensity 0;
    _x setLightUseFlare false;
} forEach _objects;

private _handle = [{
    params ["_args", "_handle"];

    _args params [
        "_unit",
        "_objects",
        "_generation",
        "_onTime",
        "_offTime",
        "_nextToggle",
        "_on",
        "_onBrightness",
        "_onIntensity"
    ];

    if (
        isNull _unit ||
        {(_unit getVariable ["UKSF_Strobes_effectGeneration", -1]) != _generation}
    ) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    private _validObjects = _objects select {!isNull _x};

    if (_validObjects isEqualTo []) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    if (CBA_missionTime < _nextToggle) exitWith {};

    _on = !_on;

    {
        _x setLightBrightness (if (_on) then {_onBrightness} else {0});
        _x setLightIntensity (if (_on) then {_onIntensity} else {0});
        _x setLightUseFlare _on;
    } forEach _validObjects;

    _args set [
        5,
        CBA_missionTime + (if (_on) then {_onTime} else {_offTime})
    ];

    _args set [6, _on];
}, 0.01, [
    _unit,
    _objects,
    _generation,
    _onTime,
    _offTime,
    CBA_missionTime,
    false,
    _onBrightness,
    _onIntensity
]] call CBA_fnc_addPerFrameHandler;

private _handles = _unit getVariable ["UKSF_Strobes_effectPFHs", []];
_handles pushBack _handle;
_unit setVariable ["UKSF_Strobes_effectPFHs", _handles, false];

true