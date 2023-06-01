/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Classname of the new controllable object <STRING>
 *
 * Example:
 * [] call NURMI_NL_fnc_newVehicle
 *
 * Return Value:
 * None
 *
 * Description:
 * <Placeholder>
 *
 */

params ["_type"];

if ((_type isKindOf "Man") OR (_type in NURMI_NL_VehicleMagazines)) exitWith {};

if ((_type isKindOf "Car") OR (_type isKindOf "Tank") OR (_type isKindOf "Air") OR (_type isKindOf "Ship")) then {
	private _vehicle = _type createVehicleLocal [0,0,0];
	private _magazines = [_vehicle] call NURMI_NL_fnc_getVehicleAmmo;
	deleteVehicle _vehicle;

	//If vehicle has turret/ammo add rearm interaction to it
	if (count _magazines > 0) then {
		NURMI_NL_VehicleMagazines set [_type, _magazines];
		publicVariable "NURMI_NL_VehicleMagazines";

		{
			private _side = _x;
			{
				[_x, _type] remoteExecCall ["NURMI_NL_fnc_addActionRearm", _side, true];
			} forEach _y;
		} forEach NURMI_NL_RearmObjects;
	};

	//Debug
	hint format ["New vehicle type detected: %1", _type];
	if (NURMI_NL_debug) then {diag_log text format ["[NL] New Vehicle Detected - Classname: %1", _type];};
};