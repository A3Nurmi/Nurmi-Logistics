/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Module <OBJECT>
 * 0: Object <OBJECT>
 * 1: Main Module <OBJECT>
 *
 * Example:
 * [Module, FlagPole, MainModule] call NURMI_NL_fnc_addLoadout;
 *
 * Discription:
 * <Placeholder>
 *
 */

if (!isServer) exitWith {};

params ["_module", "_object", "_side"];
private ["_roleName", "_gear", "_actionName", "_icon", "_customPos", "_className", "_hashMap"];

//Get defined values from the module
_roleName = _module getVariable ["NL_ModuleName", ""];
_gear = _module getVariable ["NL_ModuleGear", ""];

//DEBUG
if (count _gear == 0) exitWith {hint localize "STR_NL_Error_NoGear"};

if (count _roleName == 0) then {
	_roleName = _gear;
};

//Action Name
_actionName = format ["NURMI_spawn_%1", _roleName];

_icon = "";
_className = "";
_customPos = "";

[_object, "NURMI_ChanceLoadout", _actionName, _roleName, _className, _icon, _customPos, _gear] remoteExecCall ["NURMI_NL_fnc_addAction", _side, true];