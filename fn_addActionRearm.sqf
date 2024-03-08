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
	params ["_vehicle", "_player", "_object"];
    private _value = _vehicle getVariable ["NurmiAmountOfRearmes", -1];
    if (_value == 0) then {
    	(call compile localize "STR_NL_Notification_NoAmmo") remoteExecCall ["CBA_fnc_notify", _player];
	} else {
		_value = _value - 1;
		if (_value >= 0) then {_vehicle setVariable ["NurmiAmountOfRearmes", _value];} else {_value = "∞"};
    	[NURMI_NL_RearmTime, [_vehicle, _player, _value], {[[localize "STR_NL_Notification_Rearmed"],[format ["%1: %2", localize "STR_NL_Notification_RearmesLeft", _this select 0 select 2]]] remoteExecCall ["CBA_fnc_notify", _this select 0 select 1];_this select 0 select 0 remoteExecCall ["NURMI_NL_fnc_rearmVehicle", 0]}, {localize "STR_NL_Notification_Aborted" remoteExecCall ["CBA_fnc_notify", _this select 0 select 1]}, localize "STR_NL_Notification_Rearming"] call ace_common_fnc_progressBar;
	};
};

private _condition = {
	params ["_vehicle", "_player", "_object"];
	(_vehicle distance _object) < NURMI_NL_RearmRadius;
};

private _action = ["Rearme", localize "STR_NL_Actions_Rearme", "a3\ui_f\data\igui\cfg\actions\repair_ca.paa", _statement, _condition, {}, _object] call ace_interact_menu_fnc_createAction;
[_classname, 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;