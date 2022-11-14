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
private _gear = _params select 3;
private _path = _player getVariable "Tun_Respawn_GearPath";
[_gear, _player] call compile preprocessFileLineNumbers _path;

(format ["%1%2", localize "STR_NL_Notification_Chanced", _roleName]) remoteExecCall ["hintSilent", _player];