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
 * Or false if publicVariable dosent exist <BOOLEN>
 *
 * Description:
 * <Placeholder>
 *
 */

params [["_vehName", ""], ["_side", nil]];

//Debug
if (isNil "_side") exitWith {hint localize "STR_NL_Error_NoHashmapSide";};
if (count _vehName == 0) exitWith {hint localize "STR_NL_Error_NoHashmapName";};

private _publicVar = switch (_side) do {
	case East: { NURMI_NL_VehiclesEast; };
	case West: { NURMI_NL_VehiclesWest; };
	case Independent: { NURMI_NL_VehiclesIndependent; };
	case Civilian: { NURMI_NL_VehiclesCivilian; };
};

if (isNil {_publicVar}) exitWith {false};

private _amount = _publicVar getOrDefault [_vehName, 0];

_amount