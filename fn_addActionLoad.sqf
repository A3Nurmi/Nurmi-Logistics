/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Object <OBJECT>
 * 2: Action Path <ARRAY>
 *
 * Example:
 * [Player, ["ActionPath"]] call NURMI_NL_fnc_addActionLoad
 *
 * Return Value:
 * true
 *
 * Description:
 * <Placeholder>
 *
 */

params [["_object", objNull], "_actionPath", "_actionName", "_params"];

//Debug
if (_object isEqualTo objNull) exitWith {};

[{
	_this select 0 params ["_object", "_actionPath", "_actionName", "_params"];

	//Get all vehicles in range
	private _vehicles = [_object, NURMI_NL_SearchRadius] call NURMI_NL_fnc_getVehicles;

	private _array = _object getVariable ["NURMI_NL_vehiclesDetected",[]];
	_vehicles = _vehicles - (_vehicles arrayIntersect _array);

	if (count _vehicles == 0) exitWith {};

	_array append _vehicles;
	_object setVariable ["NURMI_NL_vehiclesDetected", _array];

	//Add action for the new vehicles
	{
		private _statement = {
			_this remoteExecCall ["NURMI_NL_fnc_spawnObject", 2, false];
		};

		private _condition = {
			params ["_target", "_player", "_params", "_actionData"];
			(_target distance (_params select 5)) < NURMI_NL_SearchRadius;
		};

		private _modifierFunc = {
		    params ["_target", "_player", "_params", "_actionData"];
		    _actionData set [1, format ["%2 (%1m)", round(_target distance (_params select 5)), _params select 5]];
		};

		private _classname = typeOf _x;
	    private _icon = getText (configFile >> "CfgVehicles" >> _classname >> "picture");
	    private _vehName = getText (configFile >> "CfgVehicles" >> _classname >> "displayName");

	    private _action = [format ["vehicle:%1", _x], format ["%1 (%2m)", _vehName, round(_object distance _x)], _icon, _statement, _condition, {}, _params + [_x, _vehName], _modifierFunc] call ace_interact_menu_fnc_createAction;
	    [_object, 0, _actionPath + [_actionName], _action] call ace_interact_menu_fnc_addActionToObject;
	} forEach _vehicles;
}, NURMI_NL_SearchTime, _this] call CBA_fnc_addPerFrameHandler;

true