/*
 * Author: Nurmi
 *
 * Discription:
 * <Placeholder>
 *
 */

params ["_object", "_player", "_params"];

private _roleName = _params select 0;
private _gear = _params select 3;
private _path = _player getVariable "Tun_Respawn_GearPath";
[_gear, _player] call compile preprocessFileLineNumbers _path;

(format ["Loadout chanced to:\n%1", toLower _roleName]) remoteExecCall ["hintSilent", _player];