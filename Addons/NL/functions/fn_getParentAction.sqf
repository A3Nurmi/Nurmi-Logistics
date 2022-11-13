/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Object <OBJECT>
 *
 * Example:
 * [Object] call NURMI_NL_fnc_getParentAction;
 *
 * Return Value:
 * Parent Action Path in array, if no parent action exists empty array is returned
 *
 * Discription:
 * <Placeholder>
 *
 */

param ["_object", objNull];

private _parentAction = [];
private _mainAction = ace_interact_menu_ActNamespace getVariable [typeOf _object, []];
private _actions = _object getVariable ["ace_interact_menu_actions",[]];

if (count _mainAction > 0) then {
	_parentAction append [_mainAction select 0 select 0 select 0];
} else {
	if (count _actions > 0) then {
		_parentAction append [_actions select 0 select 0 select 0];
	};
};

_parentAction;