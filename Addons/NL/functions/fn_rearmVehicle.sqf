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
private _hashMap = NURMI_NL_VehicleList getOrDefault [_classname, []];

if (count _hashMap == 0) exitWith {};

private _magazines = keys _hashMap;

_object setVehicleAmmo 0;

//Add magazines to turret or pylon
{
	private _array = _hashMap get _x;
	_array params ["_path", "_rounds", "_magCount", ["_pylon1", nil], ["_pylon2", nil], ["_pylon3", nil], ["_pylon4", nil]];

	if (isNil "_pylon1") then {
		_object setMagazineTurretAmmo [_x, _rounds, _path];
		if (_magCount > 1) then {
			for "_i" from 1 to (_magCount - 1) do {_object addMagazineTurret [_x, _path, _rounds]};
		};
	} else {
		if (!isNil "_pylon1") then {_object setAmmoOnPylon [_pylon1, _rounds]};
		if (!isNil "_pylon2") then {_object setAmmoOnPylon [_pylon2, _rounds]};
		if (!isNil "_pylon3") then {_object setAmmoOnPylon [_pylon3, _rounds]};
		if (!isNil "_pylon4") then {_object setAmmoOnPylon [_pylon4, _rounds]};
	};
} forEach _magazines;

["Vehicle Rearmed"] remoteExecCall ["CBA_fnc_notify", _player];