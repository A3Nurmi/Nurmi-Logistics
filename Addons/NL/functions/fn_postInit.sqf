/*
 * Author: Nurmi
 *
 * Arguments:
 * None
 *
 * Example:
 * [] call NURMI_NL_fnc_postInit
 *
 * Return Value:
 * None
 *
 * Description:
 * <Placeholder>
 *
 */

if (!isServer) exitWith {};

//Event Handler to update HashMap
["ace_interact_menu_newControllableObject", {
    params ["_type"];

    if ((_type in NURMI_NL_VehicleList) OR (_type isKindOf "Man")) exitWith {};

    if ((_type isKindOf "Car") OR (_type isKindOf "Tank") OR (_type isKindOf "Air") OR (_type isKindOf "Ship")) then {
		private _vehicle = _type createVehicleLocal [0,0,0];

		private _magazines = [_vehicle] call NURMI_NL_fnc_getVehicleAmmo;
		if (count _magazines > 0) then {
			NURMI_NL_VehicleList set [_type, _magazines];
			publicVariable "NURMI_NL_VehicleList";
		};

		deleteVehicle _vehicle;

		//Add action for the vehicle class
		{
			private _side = _x;
			{
				[_x, _type] remoteExecCall ["NURMI_NL_fnc_addActionRearm", _side, true];
			} forEach _y;
		} forEach NURMI_NL_RearmObjects;
    };
}] call CBA_fnc_addEventHandler;