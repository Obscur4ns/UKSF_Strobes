params [
    ["_unit", objNull, [objNull]],
    ["_bone", "head", [""]],
    ["_offset", [0,0,0], [[]], 3],
    ["_intensity", "STANDARD", [""]],
    ["_pattern", "STEADY", [""]]
];

if (isNull _unit || {_bone isEqualTo ""}) exitWith {objNull};

_intensity = toUpper _intensity;
_pattern = toUpper _pattern;

private _class = if (_pattern isEqualTo "FLASH") then {
    switch (_intensity) do {
        case "DIM": {
            "UKSF_Strobes_IR_Flash_Dim"
        };

        case "BRIGHT";
        case "BRIGHT+";
        case "BRIGHTPLUS": {
            "UKSF_Strobes_IR_Flash_Bright"
        };

        default {
            "UKSF_Strobes_IR_Flash"
        };
    };
} else {
    "UKSF_Strobes_IR_Steady"
};

private _marker = _class createVehicleLocal (getPosATL _unit);
if (isNull _marker) exitWith {objNull};

_marker attachTo [_unit,_offset,_bone,true];

private _objects = _unit getVariable ["UKSF_Strobes_effectObjects", []];
_objects pushBack _marker;
_unit setVariable ["UKSF_Strobes_effectObjects", _objects, false];

_marker