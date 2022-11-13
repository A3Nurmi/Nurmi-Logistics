/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Module <LOGIC>
 * 0: Object <OBJECT>
 * 1: Side <SIDE>
 *
 * Example:
 * [Module, Object, WEST] call NURMI_NL_fnc_addLoadout;
 *
 * Return Value:
 * True
 * False
 *
 * Discription:
 * <Placeholder>
 *
 */

if (!isServer) exitWith {};

params [["_module", objNull], ["_object", objNull], ["_side", nil]];
private ["_roleName", "_gear", "_actionName", "_icon", "_customPos", "_className", "_hashMap"];

//Get defined values from the module
_roleName = _module getVariable ["NL_ModuleName", ""];
_gear = _module getVariable ["NL_ModuleGear", ""];

//DEBUG
if (count _gear == 0) exitWith {hint localize "STR_NL_Error_NoGear";false};

if (count _roleName == 0) then {
	_roleName = _gear;
};

//Action Name
_actionName = format ["NURMI_spawn_%1", _roleName];

_icon = "";
_className = "";
_customPos = "";

[_object, "NURMI_ChanceLoadout", _actionName, _roleName, _className, _icon, _customPos, _gear] remoteExecCall ["NURMI_NL_fnc_addAction", _side, true];

true