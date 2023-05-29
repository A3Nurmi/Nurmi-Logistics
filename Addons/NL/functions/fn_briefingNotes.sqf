/*
 * Author: Nurmi
 *
 * Arguments:
 * NONE
 *
 * Example:
 * [] call NURMI_NL_fnc_briefingNotes
 *
 * Return Value:
 * NONE
 *
 * Description:
 * <Placeholder>
 *
 */

if (!hasInterface) exitWith {};	//Exit if headless clients or dedicated server
if (playerSide isEqualTo sideLogic) exitWith {};	// Exit if a virtual entity

////////////////////////////////////
/////////INFO ABOUT THE MOD/////////
////////////////////////////////////

private _access = ["Everyone","Group Leaders","Synchronized Players"] select NURMI_NL_ActionCondition;

private _textHideEmpty = format ["<font face='TahomaB'>%1 - %2</font><br/>%3", localize "STR_NL_CBA_DeleteWhenEmpty_Name", NURMI_NL_DeleteWhenEmpty, localize "STR_NL_CBA_DeleteWhenEmpty_Tooltip"];
private _textGlobalAmount = format ["<font face='TahomaB'>%1 - %2</font><br/>%3", localize "STR_NL_CBA_UseGlobalAmount_Name", NURMI_NL_UseGlobalAmount, localize "STR_NL_CBA_UseGlobalAmount_Tooltip"];
private _textAccess = format ["<font face='TahomaB'>%1 - %2</font><br/>%3", localize "STR_NL_CBA_ActionCondition_Name", _access, localize "STR_NL_CBA_ActionCondition_Tooltip"];
private _textSearchTime = format ["<font face='TahomaB'>%1 - %2</font><br/>%3", localize "STR_NL_CBA_SearchTime_Name", NURMI_NL_SearchTime, localize "STR_NL_CBA_SearchTime_Tooltip"];
private _textSearchRadius = format ["<font face='TahomaB'>%1 - %2</font><br/>%3", localize "STR_NL_CBA_SearchRadius_Name", NURMI_NL_SearchRadius, localize "STR_NL_CBA_SearchRadius_Tooltip"];
private _textRearmTime = format ["<font face='TahomaB'>%1 - %2</font><br/>%3", localize "STR_NL_CBA_RearmTime_Name", NURMI_NL_RearmTime, localize "STR_NL_CBA_RearmTime_Tooltip"];
private _textRearmRadius = format ["<font face='TahomaB'>%1 - %2</font><br/>%3", localize "STR_NL_CBA_RearmRadius_Name", NURMI_NL_RearmRadius, localize "STR_NL_CBA_RearmRadius_Tooltip"];
private _textDebug = format ["<font face='TahomaB'>%1 - %2</font><br/>%3", localize "STR_NL_CBA_Debug_Name", NURMI_NL_debug, localize "STR_NL_CBA_Debug_Tooltip"];

private _textSettings = format ["<br/>%1<br/><br/>%2<br/><br/>%3<br/><br/>%4<br/><br/>%5<br/><br/>%6<br/><br/>%7<br/><br/>%8", _textHideEmpty, _textGlobalAmount, _textAccess, _textSearchTime, _textSearchRadius, _textRearmTime, _textRearmRadius, _textDebug];

private _textInstructions = format ["
<br/>
<font face='TahomaB'>Spawn Vehicles</font><br/>
Objects(s) assigned by the mission creator will have ACE action ""%1"" -> ""%2"" that will contain sub actions containing vehicle names that can be spawned.<br/>
<br/>
<br/>
<font face='TahomaB'>Change Loadout</font><br/>
Object(s) assigned by the mission creator will have ACE action ""%1"" -> ""%3"" that will contain sub actions with corresponding loadout names.<br/>
Selecting one of them will change the player's loadout to selected one. Be advised that this change is permanent, and that you can't get your previous loadout back!<br/>
<br/>
<br/>
<font face='TahomaB'>Vehicle Depot</font><br/>
To rearme vehicle, drive the vehicle close to an vehicle depot assigned by the mission creator (vehicle needs to be inside of the rearm radius that has been set from CBA settings).<br/>
When close to the vehicle depot, ACE action ""%4"" will apear in the vehicles interaction menu. If pressed, ACE progress bar will be shown and after its completed the vehicle is rearmed.<br/>
", localize "STR_NL_Actions_Main", localize "STR_NL_Actions_Main_Vehicle", localize "STR_NL_Actions_Main_Loadout", localize "STR_NL_Actions_Rearme"];

private _textInfo = "<br/><font face='TahomaB'>Mod Author: Nurmi</font><br/><br/><font face='TahomaB'>Version Number: v1.0.6</font>";

player createDiarySubject ["NurmiLogistics", localize "STR_NL_Mod_Name"];
player createDiaryRecord ["NurmiLogistics", ["CBA Settings", _textSettings]];
player createDiaryRecord ["NurmiLogistics", ["Instructions", _textInstructions]];
private _diary = player createDiaryRecord ["NurmiLogistics", ["Info", _textInfo]];

////////////////////////////////////////
/////////INFO ABOUT THE MODULES/////////
////////////////////////////////////////

private _textObjects = "Object(s) from where to spawn vehicles:<br/>";
private _textRearmDepot = "";
private _objects = NURMI_NL_ActionObjects get playerSide;
private _rearmDepots = NURMI_NL_RearmObjects get playerSide;

{
	private _localMarker = createMarkerLocal [format ["Marker:%1", _x], getPos _x];
	private _objectName = getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName");
	_textObjects = _textObjects + format ["<marker name='%1'>%2</marker>  ", _localMarker, _objectName];
} forEach _objects;

if (count _rearmDepots > 0) then {
	_textRearmDepot = "Rearm Depot(s):<br/>";
	{
		private _localMarker = createMarkerLocal [format ["Marker:%1", _x], getPos _x];
		private _objectName = getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName");
		_textRearmDepot = _textRearmDepot + format ["<marker name='%1'>%2</marker>  ", _localMarker, _objectName];
	} forEach _rearmDepots;
};

private _text = format ["
<br/>
%1<br/>
<br/>
%2<br/>
<br/>
More info about the mod (CBA settings, Instructions and more) can be found from ", _textObjects, _textRearmDepot] + createDiaryLink ["NurmiLogistics", _diary, localize "STR_NL_Mod_Name"] + " page.";

player createDiaryRecord ["Diary", [localize "STR_NL_Mod_Name", _text]];