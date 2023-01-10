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
 * Description:
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
if (count _gear == 0) exitWith {
	hint format ["[NL] fnc_addLoadout:\n%1", localize "STR_NL_Error_NoGear"];
	false;
};

if (count _roleName == 0) then {
	_roleName = _gear;
};

//Action Name
_actionName = format ["NURMI_Action_%1", _roleName];

//Action Path
private _parentAction = [_object] call NURMI_NL_fnc_getParentAction;
_parentAction pushBackUnique "NURMI_spawnAction";
_parentAction pushBackUnique "NURMI_ChanceLoadout";

_icon = "";
_className = "";
_customPos = "";

[_object, _parentAction, _actionName, _roleName, _className, _icon, _customPos, _gear] remoteExecCall ["NURMI_NL_fnc_addAction", _side, true];

true