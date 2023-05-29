/*
 * Author: Nurmi
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Side <SIDE>
 * 2: Classname <STRING>
 * 3: VehicleName <STRING>
 * 4: Amount <NUMBER>
 * 5: Gear <STRING>
 * 6: CustomPos <ARRAY>
 *
 * Example:
 * [Object, WEST, "Classname", "VehicleName", 2, "", []] call NURMI_NL_fnc_addObject;
 *
 * Return Value:
 * True
 * False
 *
 * Description:
 * <Placeholder>
 *
 */

if (!isServer) exitWith {};

params [["_object", objNull], ["_side", nil], ["_className", ""], ["_vehName", ""], ["_number", -1], ["_code", ""], ["_customPos", []], ["_accessTo", []]];
private ["_text", "_actionName", "_icon", "_hashMap", "_category"];

//DEBUG
if (count _className == 0) exitWith {hint format ["[NL] fnc_addVehicle:\n%1", localize "STR_NL_Error_NoClassName"];false};

//DEBUG
if (count _customPos > 0) then {
	{
		if (isNil {_x}) exitWith {
			hint format ["[NL] fnc_spawnObject:\n%1", localize "STR_NL_Error_CustomPos"];
		};

		switch (typeName _x) do {
			case "OBJECT": {true};
			case "ARRAY": {
				if (count _x < 2) then {
					hint format ["[NL] fnc_spawnObject:\n%1", localize "STR_NL_Error_Array"];
				};
			};
			case "STRING": {
				if (getMarkerType _x == "") then {
					hint format ["[NL] fnc_spawnObject:\n%1", localize "STR_NL_Error_String"];
				};
			};
			default {
				hint format ["[NL] fnc_spawnObject:\n%1", localize "STR_NL_Error_CustomPos"];
			};
		};
	} forEach _customPos;
};

//Name of the action shown in the menu
if (count _vehName == 0) then {_vehName = getText (configFile >> "CfgVehicles" >> _className >> "displayName")};

//Action Name
_text = (_vehName splitString "-,.[]/:; ") joinString "_";
_actionName = format ["NURMI_Action_%1", _text];

//Action Type
if (_className isKindOf "Thing") then {
	_icon = "";
	_category = "NURMI_SpawnSupplies";
} else {
	_category = "NURMI_SpawnVehicle";
	_icon = getText (configFile >> "CfgVehicles" >> _className >> "picture");
};

//Update the hashmap
if (NURMI_NL_UseGlobalAmount) then {
	[_vehName, _number, _side] call NURMI_NL_fnc_addGlobalValue;
} else {
	_hashMap = _object getVariable ["NURMI_NL_spawnList", createHashMap];
	_hashMap set [_vehName, _number];
};

//Debug
if (NURMI_NL_debug) then {diag_log text format ["[NL] Vehicle Added - Object: %1, Side: %5, Vehicle: %2, ClassName: %3, Action: %4", _object, _vehName, _className, _category, _side];};

//Action Path
private _parentAction = [_object] call NURMI_NL_fnc_getParentAction;
_parentAction pushBackUnique "NURMI_spawnAction";
_parentAction pushBackUnique _category;

[_object, _parentAction, _actionName, _vehName, _className, _icon, _customPos, _code] remoteExecCall ["NURMI_NL_fnc_addAction", _accessTo, true];

true