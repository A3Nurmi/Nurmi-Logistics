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

	private _cfgParents = [configFile >> "CfgMagazines" >> _magazineClass, true] call BIS_fnc_returnParents;

	if (count _pylons == 0) then {
		if ("SmokeLauncherMag" in _cfgParents OR "SmokeLauncherMag_boat" in _cfgParents) then {
			//Solution found by HTom https://forums.bohemia.net/forums/topic/184898-rearm-smokelauncher-and-flares/?do=findComment&comment=3277335
			{
				_vehicle removeMagazinesTurret [_magazineClass, _x];
				_vehicle removeWeaponTurret ["SmokeLauncher", _x];
				_vehicle addMagazineTurret [_magazineClass, _x];
				_vehicle addWeaponTurret ["SmokeLauncher", _x];
			} forEach _paths;
		} else {
			if ("60Rnd_CMFlareMagazine" in _cfgParents) then {
				{
					_vehicle removeMagazinesTurret [_magazineClass, _x];
					_vehicle removeWeaponTurret ["CMFlareLauncher", _x];
					_vehicle addMagazineTurret [_magazineClass, _x];
					_vehicle addWeaponTurret ["CMFlareLauncher", _x];
				} forEach _paths;
			} else {
				{
					for "_i" from 1 to _magCount do {_vehicle addMagazineTurret [_magazineClass, _x, _rounds]};
				} forEach _paths;
			};
		};
	} else {
		{
			_vehicle setAmmoOnPylon [_x, _rounds];
		} forEach _pylons;
	};
} forEach _magazines;