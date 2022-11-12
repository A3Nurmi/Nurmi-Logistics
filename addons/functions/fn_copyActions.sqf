/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Old Object <OBJECT>
 * 0: New Object <OBJECT>
 *
 * Example:
 * [original, newObject] call NURMI_NL_fnc_copyActions;
 *
 * Discription:
 * <Placeholder>
 *
 */

params ["_original", "_copyTo"];

//Get parent action
private _offSet = [];
private _array = _original getVariable ["ace_interact_menu_actions",[]];
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