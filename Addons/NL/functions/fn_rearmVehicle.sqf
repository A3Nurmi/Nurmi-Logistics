/*
 * Author: Nurmi
 *
 * Arguments:
 * Params passed by ace_interact_menu_fnc_createAction;
 *
 * Example:
 * [] call NURMI_NL_fnc_rearmVehicle
 *
 * Return Value:
 * None
 *
 * Description:
 * <Placeholder>
 *
 */

params ["_object", "_player", "_params"];

private _classname = typeOf _object;
private _hashMap = NURMI_NL_VehicleMagazines getOrDefault [_classname, []];

if (count _hashMap == 0) exitWith {};

private _magazines = keys _hashMap;

_object setVehicleAmmo 0;

//Add magazines to turret or pylon
{
	private _array = _hashMap get _x;
	_array params ["_path", "_rounds", "_magCount", "_pylons"];

	if (count _pylons == 0) then {
		_object setMagazineTurretAmmo [_x, _rounds, _path];
		if (_magCount > 1) then {
			for "_i" from 1 to (_magCount - 1) do {_object addMagazineTurret [_x, _path, _rounds]};
		};
	} else {
		{
			_object setAmmoOnPylon [_x, _rounds];
		} forEach _pylons;
	};
} forEach _magazines;

["Vehicle Rearmed"] remoteExecCall ["CBA_fnc_notify", _player];