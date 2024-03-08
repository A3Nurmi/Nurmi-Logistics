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

//Get mission vehicles and add them to hashMap
if (isServer) then {
	if (count allMissionObjects "NL_ModuleRearm" > 0) then {
		private _missionVehicles = allMissionObjects "Car" + allMissionObjects "Tank" + allMissionObjects "Air" + allMissionObjects "Ship";
		private _array = [];

		{
			if (_x getVariable ["NurmiSkipObject", false]) then {continue};
			private _type = typeOf _x;
			_array pushBackUnique _type;
			private _magazines = [_x] call NURMI_NL_fnc_getVehicleAmmo;
			NURMI_NL_VehicleMagazines set [_type, _magazines];
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
	};
};

//Event Handler to update the hashMap
["ace_interact_menu_newControllableObject", {_this remoteExecCall ["NURMI_NL_fnc_newVehicle", 2];}] call CBA_fnc_addEventHandler;