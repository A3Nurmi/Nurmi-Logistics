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

private _missionVehicles = allMissionObjects "Car" + allMissionObjects "Tank" + allMissionObjects "Air" + allMissionObjects "Ship";
private _array = [];

{
	private _type = typeOf _x;
	_array pushBackUnique _type;
	private _magazines = [_x] call NURMI_NL_fnc_getVehicleAmmo;
	if (count _magazines > 0) then {
		NURMI_NL_VehicleMagazines set [_type, _magazines];
	};
} forEach _missionVehicles;

publicVariable "NURMI_NL_VehicleMagazines";

//Add action for the vehicle class
{
	private _side = _x;
	{
		private _object = _x;
		{
			[_object, _x] remoteExecCall ["NURMI_NL_fnc_addActionRearm", _side, true];
		} forEach _array;
	} forEach _y;
} forEach NURMI_NL_RearmObjects;

//Event Handler to update HashMap
["ace_interact_menu_newControllableObject", {
    params ["_type"];

    if ((_type isKindOf "Man") OR (_type in NURMI_NL_VehicleMagazines)) exitWith {};

    if ((_type isKindOf "Car") OR (_type isKindOf "Tank") OR (_type isKindOf "Air") OR (_type isKindOf "Ship")) then {
		private _vehicle = _type createVehicleLocal [0,0,0];

		private _magazines = [_vehicle] call NURMI_NL_fnc_getVehicleAmmo;
		if (count _magazines > 0) then {
			NURMI_NL_VehicleMagazines set [_type, _magazines];
			publicVariable "NURMI_NL_VehicleMagazines";
		};

		deleteVehicle _vehicle;

		{
			private _side = _x;
			{
				[_x, _type] remoteExecCall ["NURMI_NL_fnc_addActionRearm", _side, true];
			} forEach _y;
		} forEach NURMI_NL_RearmObjects;
    };
}] call CBA_fnc_addEventHandler;