/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Module <LOGIC>
 * 0: Object <OBJECT>
 * 1: Side <SIDE>
 *
 * Example:
 * [Module, Object, WEST] call NURMI_NL_fnc_addObjects;
 *
 * Return Value:
 * True
 * False
 *
 * Description:
 * <Placeholder>
 *
 */

if (!isServer) exitWith {};

params [["_module", objNull], ["_object", objNull], ["_side", nil]];
private ["_className", "_vehName", "_number", "_customPos", "_gear", "_text", "_actionName", "_icon", "_hashMap", "_category"];

//Get defined values from the module
_className = _module getVariable ["NL_ModuleClassName", ""];
_vehName = _module getVariable ["NL_ModuleCustomName", ""];
_number = _module getVariable ["NL_ModuleAmount", -1];
_gear = _module getVariable ["NL_ModuleGear", ""];
_customPos = call compile (_module getVariable ["NL_ModulePosition", "[]"]);

[_object, _side, _className, _vehName, _number, _gear, _customPos] remoteExecCall ["NURMI_NL_fnc_addObject", 2];