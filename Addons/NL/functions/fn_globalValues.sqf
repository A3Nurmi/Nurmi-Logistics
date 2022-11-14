/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Vehicle Name <STRING>
 * 2: Vehicle Amount <NUMBER>
 * 3: Side <SIDE>
 *
 * Example:
 * ["Vehicle", 0, WEST] call NURMI_NL_fnc_globalValue;
 *
 * Return Value:
 * None
 *
 * Description:
 * <Placeholder>
 *
 */

if (!isServer) exitWith {};

params [["_vehName", ""], ["_amount", 0], ["_side", nil]];

//Debug
if (isNil "_side") exitWith {hint localize "STR_NL_Error_NoHashmapSide";};
if (count _vehName == 0) exitWith {hint localize "STR_NL_Error_NoHashmapName";};

switch (_side) do {
	case East: {
		if (isNil "NURMI_NL_VehiclesEast") then {NURMI_NL_VehiclesEast = createHashMap;};
		NURMI_NL_VehiclesEast set [_vehName, _amount];
		publicVariable "NURMI_NL_VehiclesEast";
	};
	case West: {
		if (isNil "NURMI_NL_VehiclesWest") then {NURMI_NL_VehiclesWest = createHashMap;};
		NURMI_NL_VehiclesWest set [_vehName, _amount];
		publicVariable "NURMI_NL_VehiclesWest";
	};
	case Independent: {
		if (isNil "NURMI_NL_VehiclesIndependent") then {NURMI_NL_VehiclesIndependent = createHashMap;};
		NURMI_NL_VehiclesIndependent set [_vehName, _amount];
		publicVariable "NURMI_NL_VehiclesIndependent";
	};
	case Civilian: {
		if (isNil "NURMI_NL_VehiclesCivilian") then {NURMI_NL_VehiclesCivilian = createHashMap;};
		NURMI_NL_VehiclesCivilian set [_vehName, _amount];
		publicVariable "NURMI_NL_VehiclesCivilian";
	};
};