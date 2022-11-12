/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Module <OBJECT>
 * 0: Object <OBJECT>
 * 1: Main Module <OBJECT>
 *
 * Example:
 * [Module, FlagPole, MainModule] call NURMI_NL_fnc_addObjects;
 *
 * Discription:
 * <Placeholder>
 *
 */

if (!isServer) exitWith {};

params ["_module", "_object", "_side"];
private ["_className", "_vehName", "_number", "_customPos", "_gear", "_text", "_actionName", "_icon", "_hashMap", "_category"];

//Get defined values from the module
_className = _module getVariable ["NL_ModuleClassName", ""];
_vehName = _module getVariable ["NL_ModuleCustomName", ""];
_number = _module getVariable ["NL_ModuleAmount", -1];
_gear = _module getVariable ["NL_ModuleGear", ""];
_customPos = call compile (_module getVariable ["NL_ModulePosition", "[]"]);

//DEBUG
if (count _className == 0) exitWith {hint format ["[NL] Module - %1: Classname is not defined", _module]};

//Name of the action shown in the menu
if (count _vehName == 0) then {_vehName = getText (configFile >> "CfgVehicles" >> _className >> "displayName")};

//Action Name
_text = _vehName splitString "-,.[]/ ";
_text joinString "_";
_actionName = format ["NURMI_Object_%1", _text];

//Action Icon
if (_className isKindOf "AllVehicles") then {
	_category = "NURMI_SpawnVehicle";
	_icon = getText (configFile >> "CfgVehicles" >> _className >> "picture");
} else {
	_icon = "";
	_category = "NURMI_SpawnSupplies";
};

//Update the hashmap
if (NURMI_NL_UseGlobalAmount) then {
	[_vehName, _number, _side] call NURMI_NL_fnc_globalValues;
} else {
	_hashMap = _object getVariable ["NURMI_NL_spawnList", createHashMap];
	_hashMap set [_vehName, _number];
};

[_object, _category, _actionName, _vehName, _className, _icon, _customPos, _gear] remoteExecCall ["NURMI_NL_fnc_addAction", _side, true];