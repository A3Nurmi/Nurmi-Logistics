/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Vehicle <OBJECT>
 *
 * Example:
 * [vehicle player] call NURMI_NL_fnc_getVehicleAmmo
 *
 * Return Value:
 * HashMap containing info about vehicle ammo <HashMap>
 *
 * Description:
 * <Placeholder>
 *
 */

params ["_vehicle"];

private _mags = magazinesAllTurrets [_vehicle, true];
private _array = [];
private _magCount = createHashMap;
private _magazines = createHashMap;

if (count _mags == 0) exitWith {_magazines};

for "_i" from 0 to (count _mags - 1) do {
	private _classname = _mags select _i select 0;
	private _path = _mags select _i select 1;
	private _rounds = _mags select _i select 2;
	private _num = _array pushBackUnique [_classname, _path, _rounds];

	if (_num > -1) then {
		_magCount set [_classname, 1];
	} else {
		private _value = _magCount get _classname;
		_magCount set [_classname, (_value + 1), false];
	};
};

{
	private _value = _magCount get (_x select 0);
	_magazines set [_x select 0, [_x select 1, _x select 2, _value, []], false];
} forEach _array;

//If vehicle is helicopter or plane
if (_vehicle isKindOf "Air") then {
	private _mags = getAllPylonsInfo _vehicle;

	{
		private _pylonIndex = _x select 0;
		private _classname = _x select 3;

		if (count _classname <= 1) then {continue};

		private _array = _magazines get _classname;
		private _pylons = _array select 3;
		_pylons pushBack _pylonIndex;
		_array set [3, _pylons];
		_magazines set [_classname, _array, false];
	} forEach _mags;
};

_magazines