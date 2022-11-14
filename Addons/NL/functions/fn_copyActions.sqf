/*
 * Author: Nurmi
 *
 * Arguments:
 * 0: Old Object <OBJECT>
 * 1: New Object <OBJECT>
 * 2: Array of actions to be copied <ARRAY>
 *
 * Example:
 * [original, newObject, []] call NURMI_NL_fnc_copyActions;
 *
 * Return Value:
 * true
 *
 * Description:
 * Copy ace interactions from the old object to the new object
 *
 */

params [["_original", objNull], ["_copyTo", objNull], ["_array", []]];

//Debug
if (count _array == 0) exitWith {hint localize "STR_NL_Error_NoActions"};

//Get parent action
private _offSet = [];
private _parentAction = [_copyTo] call NURMI_NL_fnc_getParentAction;

//Get offset for the actions (only if no parent action exists)
if (count _parentAction == 0) then {
	_offSet = [_copyTo] call NURMI_NL_fnc_getOffSet;
};

{
	private _params = +(_x select 0);
	private _actionPath = _x select 1;

	_actionPath = _parentAction + _actionPath;

	if (count _actionPath == 0) then {
		_params set [7, _offSet];
	};

	private _action = _params call ace_interact_menu_fnc_createAction;
	[_copyTo, 0, _actionPath, _action] call ace_interact_menu_fnc_addActionToObject;
} forEach _array;

true