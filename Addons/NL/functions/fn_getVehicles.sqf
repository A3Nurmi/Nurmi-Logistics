/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Object were to get vehicles in range <OBJECT>
 * 2: Range (Optional) <NUMBER>
 *
 * Example:
 * [Player, 50] call NURMI_NL_fnc_getVehicles
 *
 * Return Value:
 * Array of vehicles that are stationary in range <ARRAY>
 *
 * Description:
 * <Placeholder>
 *
 */

params [["_object", objNull], ["_radius", 50]];

//Debug
if (_object isEqualTo objNull) exitWith {};

//Get vehicles in range
private _array = nearestObjects [_object, ["Car","Tank","Air","Ship"], _radius];

private _arrayBase = + _array;

//Delete vehicles that are moveing
{
	if (speed _x > 1) then {
		_array deleteAt _forEachIndex;
	};
} forEach _arrayBase;

_array