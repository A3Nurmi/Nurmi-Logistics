/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Object <OBJECT>
 * 2: Classname <STRING>
 *
 * Example:
 * [Player, "vehicle_classname"] call NURMI_NL_fnc_addActionRearm
 *
 * Return Value:
 * None
 *
 * Description:
 * <Placeholder>
 *
 */

params [["_object", objNull],["_classname", ""]];

//Debug
if (_object isEqualTo objNull) exitWith {};

private _statement = {
    params ["_object", "_player", "_params"];
    [NURMI_NL_RearmTime, _this, {_this select 0 remoteExecCall ["NURMI_NL_fnc_rearmVehicle", _this select 0 select 0]}, {"Aborted!" remoteExecCall ["hintSilent", _player]}, "Rearming"] call ace_common_fnc_progressBar;
};

private _condition = {
	params ["_object", "_player", "_params"];
	(_object distance (_params select 0)) < NURMI_NL_RearmRadius;
};

private _action = ["Rearme", "Rearme", "a3\ui_f\data\igui\cfg\actions\repair_ca.paa", _statement, _condition, {}, [_object]] call ace_interact_menu_fnc_createAction;
[_classname, 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;