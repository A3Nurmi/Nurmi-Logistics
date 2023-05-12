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

params ["_vehicle", "_player"];

private _classname = typeOf _vehicle;
private _hashMap = NURMI_NL_VehicleMagazines getOrDefault [_classname, []];

if (count _hashMap == 0) exitWith {};

private _magazines = keys _hashMap;

_vehicle setVehicleAmmo 0;

//Add magazines to turret or pylon
{
	private _magazineClass = _x;
	private _array = _hashMap get _magazineClass;
	_array params ["_paths", "_rounds", "_magCount", "_pylons"];

	if (count _pylons == 0) then {
		if (count _paths == 1) then {
			_vehicle addMagazineTurret [_magazineClass, _paths, _rounds];
			if (_magCount > 1) then {
				for "_i" from 1 to (_magCount - 1) do {_vehicle addMagazineTurret [_magazineClass, _paths, _rounds]};
			};
		} else {
			{
				_vehicle addMagazineTurret [_magazineClass, _x, _rounds];
			} forEach _paths;
		};
	} else {
		{
			_vehicle setAmmoOnPylon [_x, _rounds];
		} forEach _pylons;
	};
} forEach _magazines;

["Vehicle Rearmed"] remoteExecCall ["CBA_fnc_notify", _player];