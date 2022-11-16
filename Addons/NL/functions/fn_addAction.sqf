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

params [["_object", objNull], ["_actionPath", ""], ["_actionName", ""], ["_vehName", ""], ["_className", ""], ["_icon", ""], ["_customPos", []], ["_gear", ""]];

private _statement = {true};
private _condition = {true};

switch (_actionPath select ((count _actionPath) - 1)) do {
	case "NURMI_ChanceLoadout": {
		_statement = {
			_this remoteExecCall ["NURMI_NL_fnc_chanceLoadout", _this select 1, false];
		};
	};

	default {
		_statement = {
			_this remoteExecCall ["NURMI_NL_fnc_spawnObject", 2, false];
		};

		if (NURMI_NL_DeleteWhenEmpty) then {
			if (NURMI_NL_UseGlobalAmount) then {
				_condition = {
					private _index = [WEST, EAST, INDEPENDENT, CIVILIAN] find (side (_this select 1));
					private _hashMap = [NURMI_NL_VehiclesWest, NURMI_NL_VehiclesEast, NURMI_NL_VehiclesIndependent, NURMI_NL_VehiclesCivilian] select _index;
					private _amount = _hashMap getOrDefault [(_this select 2) select 0, 0];
					private _hasVeh = (_amount > 0) OR (_amount < 0);
					_hasVeh;
				};
			} else {
				_condition = {
					private _hashMap = (_this select 0) getVariable ["NURMI_NL_spawnList", createHashMap];
					private _amount = _hashMap getOrDefault [(_this select 2) select 0, 0];
					private _hasVeh = (_amount > 0) OR (_amount < 0);
					_hasVeh;
				};
			};
		};
	};
};

private _action = [_actionName, _vehName, _icon, _statement, _condition, {}, [_vehName, _className, _customPos, _gear]] call ace_interact_menu_fnc_createAction;
[_object, 0, _actionPath, _action] call ace_interact_menu_fnc_addActionToObject;