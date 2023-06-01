/*
 * Author: Nurmi
 *
 * Arguments:
 * 0: Module <LOGIC>
 * 2: Side <SIDE>
 * 3: Objects <STRING>
 * 4: Create marker <BOOLEAN>
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

params ["_logic", "_side", "_moduleObjects", "_createMarker"];
private ["_hasVehicles", "_hasSupplies", "_hasLoadouts"];

//Get all synchronized modules
private _syncObjects = synchronizedObjects _logic;

//Select how can access the spawn actions
private _accessTo = [];

switch (NURMI_NL_ActionCondition) do {
	//Only group leaders can access
	case 1: {
		private _allGroups = [];

		{
			if (side _x == _side) then {
				_allGroups pushBackUnique group _x;
			};
		} forEach call BIS_fnc_listPlayers;

		{
			private _id = owner leader _x;
			_accessTo pushBackUnique _id;
		} forEach _allGroups;
	};
	//Only synchronized players can access
	case 2: {
		{
			if (_x isKindOf "Man") then {
				_accessTo pushBackUnique owner _x;
			};
		} forEach _syncObjects;

		//Debug
		if (count _accessTo == 0) then {
			if (NURMI_NL_debug) then {diag_log text format ["[NL] None were set to access the spawn menu - Side: %1", _side];};
			hint format ["[NL] fnc_moduleMain:\nNone were set to access the spawn menu\nSide: %1", _side];
		};
	};
	//Everyone from side can access
	case default {
		_accessTo = _side;
	};
};

if ((_syncObjects findIf {typeOf _x == "NL_ModuleVehicle"}) > -1) then {_hasVehicles = true;} else {_hasVehicles = false;};
if ((_syncObjects findIf {typeOf _x == "NL_ModuleSupplie"}) > -1) then {_hasSupplies = true;} else {_hasSupplies = false;};
if ((_syncObjects findIf {typeOf _x == "NL_ModuleLoadout"}) > -1) then {_hasLoadouts = true;} else {_hasLoadouts = false;};

{
	private _offSet = [];
	private _object = missionNameSpace getVariable [_x, objNull];

	//Debug
	if (_object isEqualTo objNull) exitWith {hint format ["[NL] fnc_moduleMain:\n%1", localize "STR_NL_Error_NoObject"];};

	//Create hashMap to store the info from modules
	if (!NURMI_NL_UseGlobalAmount) then {
		_object setVariable ["NURMI_NL_spawnList", createHashMap, false];
	};

	//Get parent action
	private _parentAction = [_object] call NURMI_NL_fnc_getParentAction;

	//Get object hight, so we can get an offset for the actions (only if no parent action exists)
	if (count _parentAction == 0) then {
		_offSet = [_object] call NURMI_NL_fnc_getOffSet;
	};

	//Debug
	if (NURMI_NL_debug) then {diag_log text format ["[NL] Module Added - Object: %2, Side: %3, Access: %1", _accessTo, _object, _side];};

	//Add interactions
	[_object, _hasVehicles, _hasSupplies, _hasLoadouts, _offSet, _parentAction] remoteExecCall ["NURMI_NL_fnc_addMainActions", _side];

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