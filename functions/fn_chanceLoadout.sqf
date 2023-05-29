/*
 * Author: Nurmi
 *
 * Arguments:
 * Params passed by ace_interact_menu_fnc_createAction;
 *
 * Example:
 * [] call NURMI_NL_fnc_chanceLoadout
 *
 * Return Value:
 * None
 *
 * Description:
 * <Placeholder>
 *
 */

params ["_object", "_player", "_params"];

private _roleName = _params select 0;
private _code = _params select 3;

call compile _code;

[[format ["%1", localize "STR_NL_Notification_Chanced"]],[format ["%1", _roleName]]] remoteExecCall ["CBA_fnc_notify", _player];