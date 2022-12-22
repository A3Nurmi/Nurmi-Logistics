/*
 * Author: Nurmi
 *
 * Arguments:
 * None
 *
 * Example:
 * [] call NURMI_NL_fnc_init
 *
 * Return Value:
 * None
 *
 * Description:
 * <Placeholder>
 *
 */

if (!isServer) exitWith {};

NURMI_NL_ActionObjects = createHashMapFromArray [[WEST,[]], [EAST,[]], [INDEPENDENT,[]], [CIVILIAN,[]]];
publicVariableServer "NURMI_NL_ActionObjects";

if (NURMI_NL_UseGlobalAmount) then {
	NURMI_NL_VehiclesEast = createHashMap;
	publicVariable "NURMI_NL_VehiclesEast";
	NURMI_NL_VehiclesWest = createHashMap;
	publicVariable "NURMI_NL_VehiclesWest";
	NURMI_NL_VehiclesIndependent = createHashMap;
	publicVariable "NURMI_NL_VehiclesIndependent";
	NURMI_NL_VehiclesCivilian = createHashMap;
	publicVariable "NURMI_NL_VehiclesCivilian";
};