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
 * Amount of vehicles <NUMBER>
 *
 * Description:
 * <Placeholder>
 *
 */

params [["_vehName", ""], ["_side", nil]];

//Debug
if (isNil "_side") exitWith {hint format ["[NL] fnc_getGlobalValue:\n%1", localize "STR_NL_Error_NoSide"];};
if (count _vehName == 0) exitWith {hint format ["[NL] fnc_getGlobalValue:\n%1", localize "STR_NL_Error_NoVehName"];};
if (!NURMI_NL_UseGlobalAmount) exitWith {hint format ["[NL] fnc_getGlobalValue:\n""%1"" %2", localize "STR_NL_CBA_UseGlobalAmount_Name", localize "STR_NL_Error_CBA_isNotEnabled"];};

private _publicVar = switch (_side) do {
	case East: { NURMI_NL_VehiclesEast; };
	case West: { NURMI_NL_VehiclesWest; };
	case Independent: { NURMI_NL_VehiclesIndependent; };
	case Civilian: { NURMI_NL_VehiclesCivilian; };
};

private _amount = _publicVar getOrDefault [_vehName, 0];

_amount