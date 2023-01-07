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

private _logic = param [0, objNull, [objNull]];

//Get defined values from the module
private _moduleSide = _logic getVariable ["NL_ModuleSide", ""];
private _moduleObjects = (_logic getVariable ["NL_ModuleObject", ""]) splitString ", ";

//Debug
if (count _moduleSide == 0) exitWith {hint format ["[NL] fnc_moduleRearm:\n%1", localize "STR_NL_Error_NoSide"];};

//Get side from string
private _side = [WEST,EAST,INDEPENDENT,CIVILIAN] select (["WEST","EAST","INDEPENDENT","CIVILIAN"] find _moduleSide);

{
	private _object = missionNameSpace getVariable [_x, objNull];

	//Debug
	if (_object isEqualTo objNull) exitWith {hint format ["[NL] fnc_moduleRearm:\n%1", localize "STR_NL_Error_NoObject"];};

	//Update serverside hashMap
	private _array = NURMI_NL_RearmObjects getOrDefault [_side, []];
	_array pushBackUnique _object;
	NURMI_NL_RearmObjects set [_side, _array];
} forEach _moduleObjects;