/*
 * Author: Nurmi
 *
 * Discription:
 * <Placeholder>
 *
 */

if (!isServer) exitWith {};

private ["_logic", "_moduleSide", "_moduleObject", "_object", "_side", "_offSet", "_syncObjects", "_hasVehicles", "_hasSupplies", "_hasLoadouts", "_parentAction"];

//Get defined values from the module
_logic = param [0, objNull, [objNull]];

_moduleSide = _logic getVariable ["NL_ModuleSide", ""];
_moduleObject = _logic getVariable ["NL_ModuleObject", ""];
_object = missionNameSpace getVariable [_moduleObject, objNull];

//Debug
if (_object isEqualTo objNull) exitWith {hint format ["[NL] Module - %1:\nObject is not defined or doesn't exist", _logic]};
if (count _moduleSide == 0) exitWith {hint format ["[NL] Module - %1:\nObject side was not defined", _logic]};

//Create hashMap to store the info from modules
if (!NURMI_NL_UseGlobalAmount) then {
	_object setVariable ["NURMI_NL_spawnList", createHashMap, false];
};

//Get parent action
_parentAction = [_object] call NURMI_NL_fnc_getParentAction;

//Get object hight, so we can get an offset for the actions (only if no parent action exists)
if (count _parentAction == 0) then {
	_offSet = [_object] call NURMI_NL_fnc_getOffSet;
} else {
	_offSet = [];
};

//Get side from string
_side = [WEST,EAST,INDEPENDENT,CIVILIAN] select (["WEST","EAST","INDEPENDENT","CIVILIAN"] find _moduleSide);

//Get all synchronized modules
_syncObjects = synchronizedObjects _logic;

if ((_syncObjects findIf {typeOf _x == "NL_ModuleVehicle"}) > -1) then {_hasVehicles = true;} else {_hasVehicles = false;};
if ((_syncObjects findIf {typeOf _x == "NL_ModuleSupplie"}) > -1) then {_hasSupplies = true;} else {_hasSupplies = false;};
if ((_syncObjects findIf {typeOf _x == "NL_ModuleLoadout"}) > -1) then {_hasLoadouts = true;} else {_hasLoadouts = false;};

[_object, _hasVehicles, _hasSupplies, _hasLoadouts, _offSet, _parentAction] remoteExecCall ["NURMI_NL_fnc_addMainActions", _side, true];

{
	switch (typeOf _x) do {
		case "NL_ModuleLoadout": {
			[_x, _object, _side] remoteExecCall ["NURMI_NL_fnc_addLoadout", 0];
		};
		default {
			[_x, _object, _side] remoteExecCall ["NURMI_NL_fnc_addObject", 0];
		};
	};
} forEach _syncObjects;