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
 * Discription:
 * <Placeholder>
 *
 */

params ["_object", "_player", "_params"];
_params params ["_vehName", "_className", "_customPos", "_gear"];
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

//Exit if none left
if (_amount == 0) exitWith {
    localize "STR_NL_Notification_NoVehicles" remoteExecCall ["hintSilent", _player];
    false
};

//Update the amount
if (_amount > 0) then {
    _amount = _amount - 1;
    _hashMap set [_vehName, _amount];
    if (NURMI_NL_UseGlobalAmount) then {publicVariable format ["%1", _hashMap]};
} else {
    _amount = "∞";
};

private _direction = 0;
private _position = [];

if (_className isKindOf "AllVehicles") then {
    //If custom spawn position was given
    if (count _customPos > 0) then {
        {
            /*Check if given custom positions are either string / object or position in array*/
            switch (typeName _x) do {
                case "ARRAY": {
                    if (count (nearestObjects [_x, [], 6, true]) == 0) then {
                        _position = _x;break;
                    };
                };
                case "OBJECT": {
                    if (count ((nearestObjects [getPos _x, [], 6, true]) - [_x]) == 0) then {
                        _direction = getDir _x;
                        _position = getPos _x;break;
                    };
                };
                case "STRING": {
                    if (getMarkerType _x != "") then {
                        if (count (nearestObjects [getMarkerPos _x, [], 6, true]) == 0) then {
                            _direction = markerDir _x;
                            _position = getPos _x;break;
                        };
                    } else {
                        //Debug
                        localize "STR_NL_Error_String" remoteExecCall ["hint", _player];
                    };
                };
                default {
                    //Debug
                    localize "STR_NL_Error_CustomPos" remoteExecCall ["hint", _player];
                };
            };
        } forEach _customPos;
    } else {
        //If vehicle is helicopter / ship try to find suitable poistion to spawn
        if (_className isKindOf "Helicopter") then {
            private _helipads = nearestObjects [getPos _object, ["HeliH"], 100, true];
            {
                if (count ((nearestObjects [getPos _x, [], 6, true]) - [_x]) == 0) then {
                    _direction = getDir _x;
                    _position = getPos _x;break;
                };
            } forEach _helipads;
        };

        if (_className isKindOf "Ship") then {
            _position = [getPos _object, 5, 50, 6, 2] call BIS_fnc_findSafePos;
            _direction = (_position getDir (getPos _player)) + 180;
        };
    };
};

//Get spawn position if custom pos had not been defined
if (count _position < 1) then {
    _position = (getPos _object) findEmptyPosition [8, 40, _className];
};

if (count _position < 1) exitWith {
    localize "STR_NL_Notification_Position" remoteExecCall ["hintSilent", _player];
    false
};

private _vehicle = createVehicle [_className, _position, [], 0, "NONE"];
_vehicle setVariable ["displayName", _vehName];
_vehicle setDir _direction;

private _path = _player getVariable "Tun_Respawn_GearPath";
[_gear, _vehicle] call compile preprocessFileLineNumbers _path;

(format ["""%1"" spawned\n%2 vehicle(s) remaining", _vehName, _amount]) remoteExecCall ["hintSilent", _player];

{_x addCuratorEditableObjects [[_vehicle], true]} forEach allCurators;

true