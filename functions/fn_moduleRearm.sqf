/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Module <LOGIC>
 *
 * Example:
 * [] call NURMI_NL_fnc_moduleRearm
 *
 * Return Value:
 * None
 *
 * Description:
 * <Placeholder>
 *
 */

if (!isServer) exitWith {};

//Get defined values from the module
private _logic = param [0, objNull, [objNull]];
private _moduleSide = _logic getVariable ["NL_ModuleSide", ""];
private _moduleObjects = (_logic getVariable ["NL_ModuleObject", ""]) splitString ", ";
private _createMarker = _logic getVariable ["NL_ModuleMarker", false];

//Debug
if (count _moduleSide == 0) exitWith {hint format ["[NL] fnc_moduleRearm:\n%1", localize "STR_NL_Error_NoSide"];};

//Get side from string
private _side = [WEST,EAST,INDEPENDENT,CIVILIAN] select (["WEST","EAST","INDEPENDENT","CIVILIAN"] find _moduleSide);

{
	private _object = missionNameSpace getVariable [_x, objNull];

	//Debug
	if (_object isEqualTo objNull) exitWith {hint format ["[NL] fnc_moduleRearm:\n%1", localize "STR_NL_Error_NoObject"];};

	//Create marker
	if (_createMarker) then {
		[_object, _side] remoteExecCall ["NURMI_NL_fnc_createMarker", _side, true];
	};

	//Debug
	if (NURMI_NL_debug) then {diag_log text format ["[NL] Rearm Added - Object: %1, Side: %2", _object, _side];};

	//Update hashMap
	private _array = NURMI_NL_RearmObjects getOrDefault [_side, []];
	_array pushBackUnique _object;
	NURMI_NL_RearmObjects set [_side, _array];
	publicVariable "NURMI_NL_RearmObjects";
} forEach _moduleObjects;