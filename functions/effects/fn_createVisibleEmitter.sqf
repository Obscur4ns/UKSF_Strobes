params [
    ["_unit", objNull, [objNull]],
    ["_bone", "head", [""]],
    ["_offset", [0,0,0], [[]], 3],
    ["_colour", "WHITE", [""]],
    ["_intensity", "STANDARD", [""]]
];

if (isNull _unit || {_bone isEqualTo ""}) exitWith {objNull};

_colour = toUpper _colour;
_intensity = toUpper _intensity;

private _rgb = switch (_colour) do {
    case "GREEN": {[0.1,1,0.1]};
    case "RED": {[1,0.1,0.1]};
    case "BLUE": {[0.1,0.1,1]};
    default {[1,1,1]};
};

private _settings = switch (_intensity) do {
    case "DIM": {[0.5,350,0.08,0.002,3]};
    default {[1,1000,0.15,0.004,6]};
};

_settings params [
    "_brightness",
    "_lightIntensity",
    "_minimumFlare",
    "_flareScale",
    "_maximumFlare"
];

private _light = "#lightpoint" createVehicleLocal (getPosATL _unit);
if (isNull _light) exitWith {objNull};

_light setLightColor _rgb;
_light setLightAmbient [0,0,0];
_light setLightBrightness _brightness;
_light setLightIntensity _lightIntensity;
_light setLightUseFlare true;
_light setLightFlareSize _minimumFlare;
_light setLightFlareMaxDistance 3000;
_light setLightDayLight true;
_light setLightAttenuation [0,0,0,20,0.1,0.3];
_light attachTo [_unit,_offset,_bone,true];

private _objects = _unit getVariable ["UKSF_Strobes_effectObjects", []];
_objects pushBack _light;
_unit setVariable ["UKSF_Strobes_effectObjects", _objects, false];

private _generation = _unit getVariable ["UKSF_Strobes_effectGeneration", 0];

private _handle = [{
    params ["_args", "_handle"];
    _args params [
        "_unit",
        "_light",
        "_generation",
        "_minimumFlare",
        "_flareScale",
        "_maximumFlare"
    ];

    if (
        isNull _unit ||
        {isNull _light} ||
        {(_unit getVariable ["UKSF_Strobes_effectGeneration", -1]) != _generation}
    ) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    private _distance = (positionCameraToWorld [0,0,0]) distance _unit;
    private _flareSize = _minimumFlare max (_maximumFlare min (_distance * _flareScale));

    _light setLightFlareSize _flareSize;
}, 0.1, [
    _unit,
    _light,
    _generation,
    _minimumFlare,
    _flareScale,
    _maximumFlare
]] call CBA_fnc_addPerFrameHandler;

private _handles = _unit getVariable ["UKSF_Strobes_effectPFHs", []];
_handles pushBack _handle;
_unit setVariable ["UKSF_Strobes_effectPFHs", _handles, false];

_light