class CfgPatches
{
    class NURMI_NL
    {
        name = $STR_NL_Mod_Name;
        author = "Nurmi";
        authorUrl = "https://armafinland.fi/";
        version = 1.0;

        units[] = {"NURMI_NL"};
        requiredVersion = 1.0;
        requiredAddons[] = {"A3_Modules_F","cba_main","ace_interaction"};
    };
};

class CfgFunctions
{
    class NURMI_NL
    {
        class functions
        {
            file = "\Nurmi_Logistics\functions";

            class preInit {preInit = 1;};
            class postInit {postInit = 1;};

            class moduleInit {};
            class moduleMain {};
            class moduleVehicle {};
            class moduleRearm {};

            class addGlobalValue {};
            class getGlobalValue {};

            class addAction {};
            class addActionLoad {};
            class addMainActions {};
            class addActionRearm {};

            class getParentAction {};
            class getOffSet {};
            class getVehicles {};
            class getVehicleAmmo {};

            class addObject {};
            class addLoadout {};

            class rearmVehicle {};
            class spawnObject {};
            class chanceLoadout {};
        };
    };
};

class Extended_PreInit_EventHandlers
{
    class NURMI_NL
    {
        init = "call compile preprocessFileLineNumbers '\Nurmi_Logistics\XEH_preInit.sqf'";
    };
};

class CfgFactionClasses
{
    class NO_CATEGORY;
    class NURMI_NL: NO_CATEGORY
    {
        displayName = $STR_NL_Mod_Name;
    };
};

class CfgVehicles
{
    class Logic;

    class Module_F: Logic
    {
        class AttributesBase
        {
            class Default;
            class Edit;                 // Default edit box (i.e., text input field)
            class Combo;                // Default combo box (i.e., drop-down menu)
            class Checkbox;             // Default checkbox (returned value is Boolean)
            class CheckboxNumber;       // Default checkbox (returned value is Number)
            class ModuleDescription;    // Module description
            class Units;                // Selection of units on which the module is applied
        };

        // Description base classes, for more information see below
        class ModuleDescription
        {
            class AnyBrain;
        };
    };

    //NL Modules - Main Module
    class NL_ModuleMain: Module_F
    {
        scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
        scopeCurator = 0; // 2 = class is available in Zeus; 0 = class is unavailable in Zeus.
        displayName = $STR_NL_ModuleMain_DisplayName; // Name displayed in the menu
        //icon = ""; // Map icon. Delete this entry to use the default icon
        category = "NURMI_NL";

        function = "NURMI_NL_fnc_moduleInit"; // Name of function triggered once conditions are met
        functionPriority = 1; // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
        isGlobal = 0; // 0 for server only execution, 1 for global execution, 2 for persistent global execution
        isTriggerActivated = 0; // 1 for module waiting until all synced triggers are activated
        isDisposable = 1; // 1 if modules is to be disabled once it is activated (i.e., repeated trigger activation won't work)
        is3DEN = 0; // 1 to run init function in Eden Editor as well

        // Module attributes
        class Attributes: AttributesBase
        {
            // Module specific arguments
            class NL_ModuleSide: Combo
            {
                // Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
                property = "NURMI_NL_ModuleMain_Side";
                displayName = $STR_NL_ModuleMain_Side;
                tooltip = $STR_NL_ModuleMain_Side_Tooltip;
                typeName = "STRING";
                class Values
                {
                    // Listbox items
                    class EAST {name = "East"; value = "EAST";};
                    class WEST {name = "West"; value = "WEST";};
                    class INDEPENDENT {name = "Independent"; value = "INDEPENDENT";};
                    class CIVILIAN {name = "Civilian"; value = "CIVILIAN";};
                };
            };

            class NL_ModuleObject: Edit
            {
                property = "NURMI_NL_ModuleMain_Object";
                displayName = $STR_NL_ModuleMain_Object;
                tooltip = $STR_NL_ModuleMain_Object_Tooltip;
                typeName = "STRING";
            };

            class ModuleDescription: ModuleDescription{}; // Module description should be shown last
        };

        // Module description. Must inherit from base class, otherwise pre-defined entities won't be available
        class ModuleDescription: ModuleDescription
        {
            description = $STR_NL_ModuleMain_Description; // Short description, will be formatted as structured text
        };
    };

    //NL Modules - Vehicle Module
    class NL_ModuleVehicle: Module_F
    {
        scope = 2;
        scopeCurator = 0;
        displayName = $STR_NL_ModuleVehicle_DisplayName;
        icon = "a3\ui_f\data\igui\cfg\actions\repair_ca.paa";
        category = "NURMI_NL";

        function = "";
        functionPriority = 5;
        isGlobal = 0;
        isTriggerActivated = 0;
        isDisposable = 1;
        is3DEN = 0;

        class Attributes: AttributesBase
        {
            class NL_ModuleClassName: Edit
            {
                property = "NURMI_NL_moduleVehicle_ClassName";
                displayName = $STR_NL_ModuleVehicle_ClassName;
                tooltip = $STR_NL_ModuleVehicle_ClassName_Tooltip;
                typeName = "STRING";
            };

            class NL_ModuleCustomName: Edit
            {
                property = "NURMI_NL_moduleVehicle_Name";
                displayName = $STR_NL_ModuleVehicle_Name;
                tooltip = $STR_NL_ModuleVehicle_Name_Tooltip;
                typeName = "STRING";
            };

            class NL_ModuleAmount: Edit
            {
                property = "NURMI_NL_moduleVehicle_Amount";
                displayName = $STR_NL_ModuleVehicle_Amount;
                tooltip = $STR_NL_ModuleVehicle_Amount_Tooltip;
                typeName = "NUMBER";
                defaultValue = "-1";
            };

            class NL_ModulePosition: Edit
            {
                property = "NURMI_NL_moduleVehicle_Position";
                displayName = $STR_NL_ModuleVehicle_Position;
                tooltip = $STR_NL_ModuleVehicle_Position_Tooltip;
                typeName = "STRING";
                defaultValue = "[]";
            };

            class NL_ModuleGear: Edit
            {
                property = "NURMI_NL_moduleSupplie_Gear";
                displayName = $STR_NL_ModuleVehicle_Gear;
                tooltip = $STR_NL_ModuleVehicle_Gear_Tooltip;
                typeName = "STRING";
            };

            class ModuleDescription: ModuleDescription{};
        };

        class ModuleDescription: ModuleDescription
        {
            description = $STR_NL_ModuleVehicle_Description;
        };
    };

    //NL Modules - Supplie Module
    class NL_ModuleSupplie: Module_F
    {
        scope = 2;
        scopeCurator = 0;
        displayName = $STR_NL_ModuleSupplie_DisplayName;
        icon = "a3\ui_f\data\igui\cfg\actions\reload_ca.paa";
        category = "NURMI_NL";

        function = "";
        functionPriority = 5;
        isGlobal = 0;
        isTriggerActivated = 0;
        isDisposable = 1;
        is3DEN = 0;

        class Attributes: AttributesBase
        {
            class NL_ModuleClassName: Edit
            {
                property = "NURMI_NL_moduleSupplie_ClassName";
                displayName = $STR_NL_ModuleSupplie_ClassName;
                tooltip = $STR_NL_ModuleSupplie_ClassName_Tooltip;
                typeName = "STRING";
            };

            class NL_ModuleCustomName: Edit
            {
                property = "NURMI_NL_moduleSupplie_Name";
                displayName = $STR_NL_ModuleSupplie_Name;
                tooltip = $STR_NL_ModuleSupplie_Name_Tooltip;
                typeName = "STRING";
            };

            class NL_ModuleAmount: Edit
            {
                property = "NURMI_NL_moduleSupplie_Amount";
                displayName = $STR_NL_ModuleSupplie_Amount;
                tooltip = $STR_NL_ModuleSupplie_Amount_Tooltip;
                typeName = "NUMBER";
                defaultValue = "-1";
            };


            class NL_ModuleGear: Edit
            {
                property = "NURMI_NL_moduleSupplie_Gear";
                displayName = $STR_NL_ModuleSupplie_Gear;
                tooltip = $STR_NL_ModuleSupplie_Gear_Tooltip;
                typeName = "STRING";
            };

            class ModuleDescription: ModuleDescription{};
        };

        class ModuleDescription: ModuleDescription
        {
            description = $STR_NL_ModuleSupplie_Description;
        };
    };

    //NL Modules - Loadout Module
    class NL_ModuleLoadout: Module_F
    {
        scope = 2;
        scopeCurator = 0;
        displayName = $STR_NL_ModuleLoadout_DisplayName;
        icon = "a3\ui_f\data\igui\cfg\actions\reammo_ca.paa";
        category = "NURMI_NL";

        function = "";
        functionPriority = 5;
        isGlobal = 0;
        isTriggerActivated = 0;
        isDisposable = 1;
        is3DEN = 0;

        class Attributes: AttributesBase
        {
            class NL_ModuleName: Edit
            {
                property = "NURMI_NL_moduleLoadout_Name";
                displayName = $STR_NL_ModuleLoadout_Name;
                tooltip = $STR_NL_ModuleLoadout_Name_Tooltip;
                typeName = "STRING";
            };

            class NL_ModuleGear: Edit
            {
                property = "NURMI_NL_moduleLoadout_Gear";
                displayName = $STR_NL_ModuleLoadout_Gear;
                tooltip = $STR_NL_ModuleLoadout_Gear_Tooltip;
                typeName = "STRING";
            };

            class ModuleDescription: ModuleDescription{};
        };

        class ModuleDescription: ModuleDescription
        {
            description = $STR_NL_ModuleLoadout_Description;
        };
    };

    //NL Modules - Rearm Module
    class NL_ModuleRearm: Module_F
    {
        scope = 2;
        scopeCurator = 0;
        displayName = $STR_NL_ModuleRearm_DisplayName;
        icon = "a3\ui_f\data\igui\cfg\actions\refuel_ca.paa";
        category = "NURMI_NL";

        function = "NURMI_NL_fnc_moduleRearm";
        functionPriority = 10;
        isGlobal = 0;
        isTriggerActivated = 0;
        isDisposable = 1;
        is3DEN = 0;

        class Attributes: AttributesBase
        {
            class NL_ModuleSide: Combo
            {
                property = "NURMI_NL_ModuleRearm_Side";
                displayName = $STR_NL_ModuleMain_Side;
                tooltip = $STR_NL_ModuleMain_Side_Tooltip;
                typeName = "STRING";
                class Values
                {
                    // Listbox items
                    class EAST {name = "East"; value = "EAST";};
                    class WEST {name = "West"; value = "WEST";};
                    class INDEPENDENT {name = "Independent"; value = "INDEPENDENT";};
                    class CIVILIAN {name = "Civilian"; value = "CIVILIAN";};
                };
            };

            class NL_ModuleObject: Edit
            {
                property = "NURMI_NL_ModuleRearm_Object";
                displayName = $STR_NL_ModuleRearm_Object;
                tooltip = $STR_NL_ModuleRearm_Object_Tooltip;
                typeName = "STRING";
            };

            class ModuleDescription: ModuleDescription{};
        };

        class ModuleDescription: ModuleDescription
        {
            description = $STR_NL_ModuleRearm_Description;
        };
    };
};