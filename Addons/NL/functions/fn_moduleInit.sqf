/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Module <LOGIC>
 *
 * Example:
 * [] call NURMI_NL_fnc_moduleInit
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
private _moduleSide = _logic getVariable ["NL_ModuleSide", ""];
private _moduleObjects = (_logic getVariable ["NL_ModuleObject", ""]) splitString ", ";
private _createMarker = _logic getVariable ["NL_ModuleMarker", false];

//Debug
if (count _moduleSide == 0) exitWith {hint format ["[NL] fnc_moduleMain:\n%1", localize "STR_NL_Error_NoSide"];};

//Get side from string
private _side = [WEST,EAST,INDEPENDENT,CIVILIAN] select (["WEST","EAST","INDEPENDENT","CIVILIAN"] find _moduleSide);

//Update hashMap
{
	private _object = missionNameSpace getVariable [_x, objNull];
	if (isNull _object) then {
		_object = _x;
		hint format ["[NL] fnc_moduleInit:\n%1\n%2", localize "STR_NL_Error_NoMarker", localize "STR_NL_Error_NoObject"];
	} else {
		//Create marker
		if (_createMarker) then {
			[_object, _side, "Vehicle Depot"] remoteExecCall ["NURMI_NL_fnc_createMarker", _side, true];
		};
	};

	private _array = NURMI_NL_ActionObjects getOrDefault [_side, []];
	_array pushBackUnique _object;
	NURMI_NL_ActionObjects set [_side, _array];
	publicVariable "NURMI_NL_ActionObjects";
} forEach _moduleObjects;

//Wait mission start
[{CBA_missionTime > 0}, {_this call NURMI_NL_fnc_moduleMain;}, [_logic, _side, _moduleObjects, _createMarker]] call CBA_fnc_waitUntilAndExecute;