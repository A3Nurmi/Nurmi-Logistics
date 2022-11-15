/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Vehicle Name <STRING>
 * 2: Vehicle Amount <NUMBER>
 * 3: Side <SIDE>
 *
 * Example:
 * ["Vehicle", 0, WEST] call NURMI_NL_fnc_addGlobalValue;
 *
 * Return Value:
 * None
 *
 * Description:
 * <Placeholder>
 *
 */

params [["_vehName", ""], ["_amount", 0], ["_side", nil]];

//Debug
if (isNil "_side") exitWith {hint localize "STR_NL_Error_NoHashmapSide";};
if (count _vehName == 0) exitWith {hint localize "STR_NL_Error_NoHashmapName";};

private _publicVar = switch (_side) do {
	case East: { NURMI_NL_VehiclesEast; };
	case West: { NURMI_NL_VehiclesWest; };
	case Independent: { NURMI_NL_VehiclesIndependent; };
	case Civilian: { NURMI_NL_VehiclesCivilian; };
};

_publicVar set [_vehName, _amount];
publicVariable str _publicVar;