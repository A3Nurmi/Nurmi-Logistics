/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Object <OBJECT>
 * 2: Side <SIDE>
 *
 * Example:
 * [] call NURMI_NL_fnc_createMarker
 *
 * Return Value:
 * None
 *
 * Description:
 * <Placeholder>
 *
 */

params ["_object", "_side", "_text"];

private _marker = createMarkerLocal [format ["Depot_%1", _object], getPos _object];

private _array = switch (_side) do {
	case EAST: {["colorOPFOR","o_maint"]};
	case WEST: {["colorBLUFOR","b_maint"]};
	case INDEPENDENT: {["colorIndependent","n_maint"]};
	case CIVILIAN: {["colorCivilian","c_unknown"]};
};

_marker setMarkerTextLocal _text;
_marker setMarkerColorLocal (_array select 0);
_marker setMarkerTypeLocal (_array select 1);