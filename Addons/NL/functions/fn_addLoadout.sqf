/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Module <LOGIC>
 * 0: Object <OBJECT>
 * 1: Array <ARRAY>
 *
 * Example:
 * [Module, Object, [0,1,2]] call NURMI_NL_fnc_addLoadout;
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

params [["_module", objNull], ["_object", objNull], ["_accessTo", []]];

//Get defined values from the module
private _roleName = _module getVariable ["NL_ModuleName", ""];
private _code = _module getVariable ["NL_ModuleCode", ""];

//DEBUG
if (count _code == 0) exitWith {
	hint format ["[NL] fnc_addLoadout:\n%1", localize "STR_NL_Error_NoGear"];
	false;
};

//Action Name
private _actionName = format ["NURMI_Action_%1", _roleName];

//Action Path
private _parentAction = [_object] call NURMI_NL_fnc_getParentAction;
_parentAction pushBackUnique "NURMI_spawnAction";
_parentAction pushBackUnique "NURMI_ChanceLoadout";

[_object, _parentAction, _actionName, _roleName, "", "", "", _code] remoteExecCall ["NURMI_NL_fnc_addAction", _accessTo, true];

true