/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Module <LOGIC>
 *
 * Example:
 * [] call NURMI_NL_fnc_moduleMainInit;
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

//Debug
if (count _moduleSide == 0) exitWith {hint format ["[NL] fnc_moduleMain:\n%1", localize "STR_NL_Error_NoSide"];};

//Get side from string
private _side = [WEST,EAST,INDEPENDENT,CIVILIAN] select (["WEST","EAST","INDEPENDENT","CIVILIAN"] find _moduleSide);

{
	private ["_offSet", "_hasVehicles", "_hasSupplies", "_hasLoadouts"];
	private _object = missionNameSpace getVariable [_x, objNull];
	private _accessTo = [];

	//Debug
	if (_object isEqualTo objNull) exitWith {hint format ["[NL] fnc_moduleMain:\n%1", localize "STR_NL_Error_NoObject"];};

	//Update hashMap
	private _list = NURMI_NL_ActionObjects getOrDefault [_side, []];
	_list pushBackUnique _object;
	NURMI_NL_ActionObjects set [_side, _list];
	publicVariable "NURMI_NL_ActionObjects";

	//Create hashMap to store the info from modules
	if (!NURMI_NL_UseGlobalAmount) then {
		_object setVariable ["NURMI_NL_spawnList", createHashMap, false];
	};

	//Get parent action
	private _parentAction = [_object] call NURMI_NL_fnc_getParentAction;

	//Get object hight, so we can get an offset for the actions (only if no parent action exists)
	if (count _parentAction == 0) then {
		_offSet = [_object] call NURMI_NL_fnc_getOffSet;
	} else {
		_offSet = [];
	};

	//Get all synchronized modules
	private _syncObjects = synchronizedObjects _logic;

	//Select how can access the spawn actions
	if (NURMI_NL_ActionCondition == 0) then {
		_accessTo = [_side];
	} else {
		if (NURMI_NL_ActionCondition == 1) then {
			private _allGroups = [];

			//All groups with players
			{
				if (side _x == _side) then {
					_allGroups pushBackUnique group _x;
				};
			} forEach allPlayers;

			//All group leaders
			{
				private _leader = leader _x;
				private _id = owner _leader;
				_accessTo pushBackUnique _id;
			} forEach _allGroups;
		};

		if (NURMI_NL_ActionCondition == 2) then {
			{
				if (isPlayer _x) then {
					private _id = owner _x;
					_accessTo pushBackUnique _id;
				};
			} forEach _syncObjects;
		};
	};

	//Debug
	if (count _accessTo == 0) exitWith {
		if (NURMI_NL_debug) then {diag_log text format ["[NL] None were set to access the spawn menu - Object: %1 Side: %2", _object, _side];};
		hint format ["[NL] fnc_moduleMain:\nNone were set to access the spawn menu\nObject: %1\nSide: %2", _object, _side];
	};
	if (NURMI_NL_debug) then {diag_log text format ["[NL] Module Added - Object: %2, Side: %3, Access: %1", _accessTo, _object, _side];};

	if ((_syncObjects findIf {typeOf _x == "NL_ModuleVehicle"}) > -1) then {_hasVehicles = true;} else {_hasVehicles = false;};
	if ((_syncObjects findIf {typeOf _x == "NL_ModuleSupplie"}) > -1) then {_hasSupplies = true;} else {_hasSupplies = false;};
	if ((_syncObjects findIf {typeOf _x == "NL_ModuleLoadout"}) > -1) then {_hasLoadouts = true;} else {_hasLoadouts = false;};

	[_object, _hasVehicles, _hasSupplies, _hasLoadouts, _offSet, _parentAction] remoteExecCall ["NURMI_NL_fnc_addMainActions", _side, true];

	{
		if (_x isKindOf "Man") then {continue};
		switch (typeOf _x) do {
			case "NL_ModuleLoadout": {
				[_x, _object, _side] remoteExecCall ["NURMI_NL_fnc_addLoadout", 2];
			};
			default {
				[_x, _object, _side, _accessTo] remoteExecCall ["NURMI_NL_fnc_moduleVehicle", 2];
			};
		};
	} forEach _syncObjects;
} forEach _moduleObjects;