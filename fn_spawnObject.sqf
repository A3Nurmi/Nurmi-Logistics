/*
 * Author: Nurmi
 *
 * Arguments:
 * Params passed by ace_interact_menu_fnc_createAction;
 *
 * Example:
 * [] call NURMI_NL_fnc_spawnObject
 *
 * Return Value:
 * True - if vehicle was spawned
 * False - if no vehicle was spawned
 *
 * Description:
 * <Placeholder>
 *
 */

params ["_object", "_player", "_params"];
_params params ["_vehName", "_className", "_rearmes", "_customPos", "_code", ["_loadTo", objNull], ["_loadToName", ""]];
private ["_hashMap", "_amount", "_index"];

//Get vehicle amount
if (NURMI_NL_UseGlobalAmount) then {
    _index = [WEST, EAST, INDEPENDENT, CIVILIAN] find (side _player);
    _hashMap = [NURMI_NL_VehiclesWest, NURMI_NL_VehiclesEast, NURMI_NL_VehiclesIndependent, NURMI_NL_VehiclesCivilian] select _index;
    _amount = _hashMap getOrDefault [_vehName, 0];
} else {
    _hashMap = _object getVariable ["NURMI_NL_spawnList", createHashMap];
    _amount = _hashMap getOrDefault [_vehName, 0];
};

//Exit if no vehicles left
if (_amount == 0) exitWith {
    localize "STR_NL_Notification_NoVehicles" remoteExecCall ["CBA_fnc_notify", _player];
    false
};

//Update the amount
if (_amount > 0) then {
    _amount = _amount - 1;
    _hashMap set [_vehName, _amount];
    if (NURMI_NL_UseGlobalAmount) then {
        switch (side _player) do {
            case East: {publicVariable "NURMI_NL_VehiclesEast";};
            case West: {publicVariable "NURMI_NL_VehiclesWest";};
            case Independent: {publicVariable "NURMI_NL_VehiclesIndependent";};
            case Civilian: {publicVariable "NURMI_NL_VehiclesCivilian";};
        };
    };
} else {
    _amount = "∞";
};

private _direction = 0;
private _position = [];

//If custom spawn position was given
if (count _customPos > 0) then {
    {
        switch (typeName _x) do {
            case "ARRAY": {
                if (count (nearestObjects [_x, ["AllVehicles"], 6, true]) == 0) then {
                    _position = _x;
                    break;
                };
            };
            case "OBJECT": {
                if (count (nearestObjects [getPos _x, ["AllVehicles"], 6, true]) == 0) then {
                    _direction = getDir _x;
                    _position = getPosATL _x;
                    break;
                };
            };
            case "STRING": {
                if (count (nearestObjects [getMarkerPos _x, ["AllVehicles"], 6, true]) == 0) then {
                    _direction = markerDir _x;
                    _position = getMarkerPos _x;
                    break;
                };
            };
        };
    } forEach _customPos;
} else {
    //If vehicle is helicopter / ship try to find suitable poistion to spawn
    if (_className isKindOf "Helicopter") then {
        private _helipads = nearestObjects [getPos _object, ["HeliH"], 100, true];
        {
            if (count (nearestObjects [getPos _x, ["AllVehicles"], 6, true]) == 0) then {
                _direction = getDir _x;
                _position = getPos _x;
                break;
            };
        } forEach _helipads;
    };

    if (_className isKindOf "Ship") then {
        _position = [getPos _object, 5, 50, 6, 2] call BIS_fnc_findSafePos;
        _direction = (_position getDir (getPos _player)) + 180;
    };
};

//Get spawn position if custom pos had not been defined
if (count _position < 1) then {
    _position = (getPos _object) findEmptyPosition [8, 40, _className];
};

//Exit if no spawn position was found
if (count _position < 1) exitWith {
    (call compile localize "STR_NL_Notification_Position") remoteExecCall ["CBA_fnc_notify", _player];
    false
};

private _vehicle = createVehicle [_className, _position, [], 0, "NONE"];
_vehicle setVariable ["displayName", _vehName];
_vehicle setDir _direction;

if (_className isKindOf "AllVehicles") then {
    _vehicle setVariable ["NurmiAmountOfRearmes", _rearmes];
};

//Call custom code
call compile _code;

[[format ["%1 spawned", _vehName]],[format ["%1 vehicle(s) remainin", _amount]]] remoteExecCall ["CBA_fnc_notify", _player];

{_x addCuratorEditableObjects [[_vehicle], true]} forEach allCurators;

//Load supplie to vehicle
if (!(_loadTo isEqualTo objNull)) then {
    [_vehicle, _loadTo, true] call ace_cargo_fnc_loadItem;
    [format ["Loaded %1 to %2", _vehName, _loadToName]] remoteExecCall ["CBA_fnc_notify", _player];
};

true