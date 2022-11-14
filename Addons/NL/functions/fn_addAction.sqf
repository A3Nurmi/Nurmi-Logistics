/*
 * Author: Nurmi
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Action Type <STRING>
 * 2: Action Name <STRING>
 * 3: Name of the action shown in the menu <STRING>
 * 4: Vehicle ClassName <STRING>
 * 5: Path to the icon <STRING>
 * 6: Custom position where vehicle will spawn <ARRAY>
 * 7: Name of the gear that will be search from the Tuntematon Geariscript functiot <STRING>
 *
 * Example:
 * [FlagPole, "ActionType", "ActionName", "VehicleName", "VehicleClassName", "IconPath", [], "ROLE"] call NURMI_NL_fnc_addAction;
 *
 * Return Value:
 * None
 *
 * Description:
 * <Placeholder>
 *
 */

params [["_object", objNull], ["_actionType", ""], ["_actionName", ""], ["_vehName", ""], ["_className", ""], ["_icon", ""], ["_customPos", []], ["_gear", ""]];

private _statement = {true};
private _condition = {true};
private _insertChildren = {};

switch (_actionType) do {
	case "NURMI_ChanceLoadout": {
		_statement = {
			_this remoteExecCall ["NURMI_NL_fnc_chanceLoadout", _this select 1, false];
		};
	};

	default {
		_statement = {
			_this remoteExecCall ["NURMI_NL_fnc_spawnObject", 0, false];
		};

		if (NURMI_NL_DeleteWhenEmpty) then {
			if (NURMI_NL_UseGlobalAmount) then {
				_condition = {
					params ["_object", "_player", "_params"];
					private _index = [WEST, EAST, INDEPENDENT, CIVILIAN] find (side _player);
					private _hashMap = [NURMI_NL_VehiclesWest, NURMI_NL_VehiclesEast, NURMI_NL_VehiclesIndependent, NURMI_NL_VehiclesCivilian] select _index;
					private _amount = _hashMap getOrDefault [_params select 0, 0];
					private _hasVeh = (_amount > 0) OR (_amount < 0);
					_hasVeh;
				};
			} else {
				_condition = {
					params ["_object", "_player", "_params"];
					private _hashMap = _object getVariable ["NURMI_NL_spawnList", createHashMap];
					private _amount = _hashMap getOrDefault [_params select 0, 0];
					private _hasVeh = (_amount > 0) OR (_amount < 0);
					_hasVeh;
				};
			};
		};
	};
};

private _action = [_actionName, _vehName, _icon, _statement, _condition, _insertChildren, [_vehName, _className, _customPos, _gear]] call ace_interact_menu_fnc_createAction;
[_object, 0, ["NURMI_spawnAction", _actionType], _action] call ace_interact_menu_fnc_addActionToObject;