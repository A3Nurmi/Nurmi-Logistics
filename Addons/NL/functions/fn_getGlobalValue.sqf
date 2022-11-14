/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Vehicle Name <STRING>
 * 3: Side <SIDE>
 *
 * Example:
 * ["Vehicle", WEST] call NURMI_NL_fnc_getGlobalValue;
 *
 * Return Value:
 * Number
 *
 * Description:
 * <Placeholder>
 *
 */

params [["_vehName", ""], ["_side", nil]];

//Debug
if (isNil "_side") exitWith {hint localize "STR_NL_Error_NoHashmapSide";};
if (count _vehName == 0) exitWith {hint localize "STR_NL_Error_NoHashmapName";};

private _amount = 0;

switch (_side) do {
	case East: {
		if (isNil "NURMI_NL_VehiclesEast") exitWith {};
		_amount = NURMI_NL_VehiclesEast getOrDefault [_vehName, 0];
	};
	case West: {
		if (isNil "NURMI_NL_VehiclesWest") exitWith {};
		_amount = NURMI_NL_VehiclesWest getOrDefault [_vehName, 0];
	};
	case Independent: {
		if (isNil "NURMI_NL_VehiclesIndependent") exitWith {};
		_amount = NURMI_NL_VehiclesIndependent getOrDefault [_vehName, 0];
	};
	case Civilian: {
		if (isNil "NURMI_NL_VehiclesCivilian") exitWith {};
		_amount = NURMI_NL_VehiclesCivilian getOrDefault [_vehName, 0];
	};
};

_amount