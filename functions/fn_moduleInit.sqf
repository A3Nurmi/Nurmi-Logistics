/*
 * Author: Nurmi
 *
 * Arguments:
 * 1: Module <LOGIC>
 *
 * Example:
 * [] call NURMI_NL_fnc_moduleInit
 *
 * Return Value:
 * None
 *
 * Description:
 * <Placeholder>
 *
 */

if (!isServer) exitWith {};

private _logic = param [0, objNull, [objNull]];

[{CBA_missionTime > 0}, {
	[_this select 0] call NURMI_NL_fnc_moduleMain;
}, [_logic]] call CBA_fnc_waitUntilAndExecute;