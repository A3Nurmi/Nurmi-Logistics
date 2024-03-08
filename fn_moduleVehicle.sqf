/*
 * Author: Nurmi
 *
 * Arguments:
 * 0: Module <LOGIC>
 * 1: Object <OBJECT>
 * 2: Side <SIDE>
 * 3: How can access the actions <SIDE,OBJECT,NETID,GROUP,ARRAY of any combination of the types listed>
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

params [["_module", objNull], ["_object", objNull], ["_side", nil], ["_accessTo", []]];
private ["_className", "_vehName", "_number", "_customPos", "_code", "_text", "_actionName", "_icon", "_hashMap", "_category"];

//Get defined values from the module
_className = _module getVariable ["NL_ModuleClassName", ""];
_vehName = _module getVariable ["NL_ModuleCustomName", ""];
_number = _module getVariable ["NL_ModuleAmount", -1];
_rearmes = _module getVariable ["NL_ModuleRearms", -1];
_code = _module getVariable ["NL_ModuleCode", ""];
_customPos = call compile (_module getVariable ["NL_ModulePosition", "[]"]);

[_object, _side, _className, _vehName, _number, _rearmes, _code, _customPos, _accessTo] remoteExecCall ["NURMI_NL_fnc_addObject", 2];