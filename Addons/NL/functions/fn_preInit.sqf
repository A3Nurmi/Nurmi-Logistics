/*
 * Author: Nurmi
 *
 * Arguments:
 * None
 *
 * Example:
 * [] call NURMI_NL_fnc_preInit
 *
 * Return Value:
 * None
 *
 * Description:
 * <Placeholder>
 *
 */

if (!isServer) exitWith {};

////Create HashMap that contains all object with spawn action
NURMI_NL_ActionObjects = createHashMapFromArray [[WEST,[]], [EAST,[]], [INDEPENDENT,[]], [CIVILIAN,[]]];
publicVariableServer "NURMI_NL_ActionObjects";

NURMI_NL_RearmObjects = createHashMapFromArray [[WEST,[]], [EAST,[]], [INDEPENDENT,[]], [CIVILIAN,[]]];
publicVariableServer "NURMI_NL_RearmObjects";

//Create HashMap if global amounts are used
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

//Create HashMap that contains vehicles used in mission
NURMI_NL_VehicleMagazines = createHashMap;
publicVariable "NURMI_NL_VehicleMagazines";