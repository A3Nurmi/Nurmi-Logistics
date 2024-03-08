/*
 * Author: Nurmi
 *
 * Arguments:
 * 0: Object the action should be assigned to <OBJECT>
 * 1: Create vehicle action <BOOL>
 * 2: Create supplie action <BOOL>
 * 3: Create loadout action <BOOL>
 * 4: Action offset <ARRAY>, <CODE> or <STRING>
 * 5: Parent action to which the actions will be added <ARRAY>
 *
 * Example:
 * [objNull, false, false false, [], []] call NURMI_NL_fnc_addMainActions;
 *
 * Return Value:
 * True: If NL main action was added
 * False: If object contains already NL main action
 *
 * Description:
 * Add nurmi logistics main action and additional actions if needed.
 *
 */

params [["_object", objNull], ["_hasVehicles", false], ["_hasSupplies", false], ["_hasLoadouts", false], ["_offSet",[]], ["_parentAction",[]]];

private _actionPath = _parentAction + ["NURMI_spawnAction"];

//Look if actions already exists for client
private _index = _object getVariable ["ace_interact_menu_actions", []] findIf {_x select 0 select 0 == "NURMI_spawnAction"};
if (_index != -1) exitWith {};

//Add main action
private _actionMain = ["NURMI_spawnAction", localize "STR_NL_Actions_Main", "", {true}, {true}, nil, nil, _offSet, 8] call ace_interact_menu_fnc_createAction;
[_object, 0, _parentAction, _actionMain] call ace_interact_menu_fnc_addActionToObject;

//Add Vehicles
if (_hasVehicles) then {
    private _actionSpawn = ["NURMI_SpawnVehicle", localize "STR_NL_Actions_Main_Vehicle", "a3\ui_f\data\igui\cfg\actions\repair_ca.paa", {true}, {true}] call ace_interact_menu_fnc_createAction;
    [_object, 0, _actionPath, _actionSpawn] call ace_interact_menu_fnc_addActionToObject;
};

//Add Supplies
if (_hasSupplies) then {
    private _actionSupplies = ["NURMI_SpawnSupplies", localize "STR_NL_Actions_Main_Supplies", "a3\ui_f\data\igui\cfg\actions\reload_ca.paa", {true}, {true}] call ace_interact_menu_fnc_createAction;
    [_object, 0, _actionPath, _actionSupplies] call ace_interact_menu_fnc_addActionToObject;
};

//Chance Loadout
if (_hasLoadouts) then {
    private _actionLoadout = ["NURMI_ChanceLoadout", localize "STR_NL_Actions_Main_Loadout", "a3\ui_f\data\igui\cfg\actions\reammo_ca.paa", {true}, {true}] call ace_interact_menu_fnc_createAction;
    [_object, 0, _actionPath, _actionLoadout] call ace_interact_menu_fnc_addActionToObject;
};

true