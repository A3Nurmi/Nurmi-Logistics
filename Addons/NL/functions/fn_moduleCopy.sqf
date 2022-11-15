/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Module <LOGIC>
 *
 * Example:
 * [] call NURMI_NL_fnc_moduleCopyInit;
 *
 * Return Value:
 * None
 *
 * Description:
 * <Placeholder>
 *
 */

if (!isServer) exitWith {};

private ["_logic", "_moduleSide", "_moduleObject", "_moduleCopyFrom", "_object", "_copyFrom", "_side"];

//Get defined values from the module
_logic = param [0, objNull, [objNull]];
_moduleSide = _logic getVariable ["NL_ModuleSide", ""];
_moduleObject = _logic getVariable ["NL_ModuleObject", ""];
_moduleCopyFrom = _logic getVariable ["NL_ModuleCopyFrom", ""];

_object = missionNameSpace getVariable [_moduleObject, objNull];
_copyFrom = missionNameSpace getVariable [_moduleCopyFrom, objNull];

//Get side from string
_side = [WEST,EAST,INDEPENDENT,CIVILIAN] select (["WEST","EAST","INDEPENDENT","CIVILIAN"] find _moduleSide);

//Debug
if (_object isEqualTo objNull) exitWith {hint localize "STR_NL_Error_NoObject"};
if (_copyFrom isEqualTo objNull) exitWith {hint localize "STR_NL_Error_NoObject"};
if (count _moduleSide == 0) exitWith {hint localize "STR_NL_Error_NoSide"};

[{
	//Get actions that will be copied
	private _array = _this select 0 getVariable ["ace_interact_menu_actions",[]];

	//Copy object actions to new object
	if (NURMI_NL_UseGlobalAmount) then {
		[_this select 0, _this select 1, _array] remoteExecCall ["NURMI_NL_fnc_copyActions", _this select 2, true];
	} else {
		//Debug
		hint localize "STR_NL_Error_CBA_Global";
	};
}, [_copyFrom, _object, _side], 5] call CBA_fnc_waitAndExecute;