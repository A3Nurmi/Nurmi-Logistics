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
    "NURMI_NL_UseGlobalAmount", // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_NL_CBA_UseGlobalAmount_Name" call BIS_fnc_localize, "STR_NL_CBA_UseGlobalAmount_Tooltip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_NL_CBA_Category_Main" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    "NURMI_NL_SearchTime", // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_NL_CBA_SearchTime_Name" call BIS_fnc_localize, "STR_NL_CBA_SearchTime_Tooltip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_NL_CBA_Category_Main" call BIS_fnc_localize, "STR_NL_CBA_Category_Search" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 60, 10, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    "NURMI_NL_SearchRadius", // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_NL_CBA_SearchRadius_Name" call BIS_fnc_localize, "STR_NL_CBA_SearchRadius_Tooltip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_NL_CBA_Category_Main" call BIS_fnc_localize, "STR_NL_CBA_Category_Search" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 100, 40, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    "NURMI_NL_RearmTime", // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_NL_CBA_RearmTime_Name" call BIS_fnc_localize, "STR_NL_CBA_RearmTime_Tooltip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_NL_CBA_Category_Main" call BIS_fnc_localize, "STR_NL_CBA_Category_Rearm" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [5, 300, 10, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    "NURMI_NL_RearmRadius", // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_NL_CBA_RearmRadius_Name" call BIS_fnc_localize, "STR_NL_CBA_RearmRadius_Tooltip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_NL_CBA_Category_Main" call BIS_fnc_localize, "STR_NL_CBA_Category_Rearm" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [10, 100, 50, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;