/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Object were to get vehicles in range <OBJECT>
 * 2: Range (Optional) <NUMBER>
 *
 * Example:
 * [Player, 10] call NURMI_NL_fnc_getVehicles
 *
 * Return Value:
 * Vehicles that are stationery <OBJECT>
 *
 * Description:
 * <Placeholder>
 *
 */

params [["_object", objNull], ["_range", 50]];

//Debug
if (_object isEqualTo objNull) exitWith {};

//Get vehicles in range
private _array = nearestObjects [_object, ["Car","Truck","Tank","Air","Ship"], _range];

//Delete vehicles that are moveing
{
	if (speed _x > 1) then {
		_array deleteAt _forEachIndex;
	};
} forEach _array;

_array