//Main settings
[
    "NURMI_NL_DeleteWhenEmpty", // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_NL_CBA_DeleteWhenEmpty_Name" call BIS_fnc_localize, "STR_NL_CBA_DeleteWhenEmpty_Tooltip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_NL_CBA_Category_Main" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    "NURMI_NL_UseGlobalAmount",
    "CHECKBOX",
    ["STR_NL_CBA_UseGlobalAmount_Name" call BIS_fnc_localize, "STR_NL_CBA_UseGlobalAmount_Tooltip" call BIS_fnc_localize],
    ["STR_NL_CBA_Category_Main" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    "NURMI_NL_ActionCondition",
    "LIST",
    ["STR_NL_CBA_ActionCondition_Name" call BIS_fnc_localize, "STR_NL_CBA_ActionCondition_Tooltip" call BIS_fnc_localize],
    ["STR_NL_CBA_Category_Main" call BIS_fnc_localize],
    [[0, 1, 2], ["Everyone","Group Leaders","Synchronized Players"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

//Briefing Notes
[
    "NURMI_NL_BriefingNotes_BLUFOR",
    "CHECKBOX",
    ["BLUFOR", "STR_NL_CBA_Briefing_Tooltip" call BIS_fnc_localize],
    ["STR_NL_CBA_Category_Main" call BIS_fnc_localize, "STR_NL_CBA_Category_Briefing" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    "NURMI_NL_BriefingNotes_OPFOR",
    "CHECKBOX",
    ["OPFOR", "STR_NL_CBA_Briefing_Tooltip" call BIS_fnc_localize],
    ["STR_NL_CBA_Category_Main" call BIS_fnc_localize, "STR_NL_CBA_Category_Briefing" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    "NURMI_NL_BriefingNotes_INDEPENDENT",
    "CHECKBOX",
    ["INDEPENDENT", "STR_NL_CBA_Briefing_Tooltip" call BIS_fnc_localize],
    ["STR_NL_CBA_Category_Main" call BIS_fnc_localize, "STR_NL_CBA_Category_Briefing" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

//Search Category
[
    "NURMI_NL_SearchTime",
    "SLIDER",
    ["STR_NL_CBA_SearchTime_Name" call BIS_fnc_localize, "STR_NL_CBA_SearchTime_Tooltip" call BIS_fnc_localize],
    ["STR_NL_CBA_Category_Main" call BIS_fnc_localize, "STR_NL_CBA_Category_Search" call BIS_fnc_localize],
    [0, 60, 15, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    "NURMI_NL_SearchRadius",
    "SLIDER",
    ["STR_NL_CBA_SearchRadius_Name" call BIS_fnc_localize, "STR_NL_CBA_SearchRadius_Tooltip" call BIS_fnc_localize],
    ["STR_NL_CBA_Category_Main" call BIS_fnc_localize, "STR_NL_CBA_Category_Search" call BIS_fnc_localize],
    [1, 100, 50, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

//Rearm Category
[
    "NURMI_NL_RearmTime",
    "SLIDER",
    ["STR_NL_CBA_RearmTime_Name" call BIS_fnc_localize, "STR_NL_CBA_RearmTime_Tooltip" call BIS_fnc_localize],
    ["STR_NL_CBA_Category_Main" call BIS_fnc_localize, "STR_NL_CBA_Category_Rearm" call BIS_fnc_localize],
    [5, 300, 30, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    "NURMI_NL_RearmRadius",
    "SLIDER",
    ["STR_NL_CBA_RearmRadius_Name" call BIS_fnc_localize, "STR_NL_CBA_RearmRadius_Tooltip" call BIS_fnc_localize],
    ["STR_NL_CBA_Category_Main" call BIS_fnc_localize, "STR_NL_CBA_Category_Rearm" call BIS_fnc_localize],
    [10, 100, 50, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

//Debug Category
[
    "NURMI_NL_debug",
    "CHECKBOX",
    ["STR_NL_CBA_Debug_Name" call BIS_fnc_localize, "STR_NL_CBA_Debug_Tooltip" call BIS_fnc_localize],
    ["STR_NL_CBA_Category_Main" call BIS_fnc_localize, "STR_NL_CBA_Category_Debug" call BIS_fnc_localize],
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;