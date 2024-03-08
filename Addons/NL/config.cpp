class CfgPatches
{
    class NURMI_NL
    {
        name = $STR_NL_Mod_Name;
        author = "Nurmi";
        authorUrl = "https://armafinland.fi/";
        version = 1.0;

        units[] = {"NURMI_NL"};
        requiredVersion = 2.0;
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
            class briefingNotes {postInit = 1;};

            class moduleInit {};
            class moduleMain {};
            class moduleVehicle {};
            class moduleRearm {};

            class addGlobalValue {};

            class addAction {};
            class addActionLoad {};
            class addMainActions {};
            class addActionRearm {};

            class getParentAction {};
            class getOffSet {};
            class getVehicles {};
            class getVehicleAmmo {};
            class createMarker {};
            class newVehicle {};

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
        functionPriority = 10; // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
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

            class NL_ModuleMarker: Checkbox
            {
                property = "NURMI_NL_ModuleMain_Marker";
                displayName = $STR_NL_ModuleRearm_Marker;
                tooltip = $STR_NL_ModuleRearm_Marker_Tooltip;
                typeName = "BOOLEAN";
                defaultValue = true;
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
        functionPriority = 15;
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
                defaultValue = "B_MRAP_01_F";
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

            class NL_ModuleRearms: Edit
            {
                property = "NURMI_NL_moduleVehicle_Rearms";
                displayName = $STR_NL_ModuleVehicle_Rearms;
                tooltip = $STR_NL_ModuleVehicle_Rearms_Tooltip;
                typeName = "NUMBER";
                defaultValue = "-1";
            };

            class NL_ModulePosition: Edit
            {
                property = "NURMI_NL_moduleVehicle_Position";
                displayName = $STR_NL_ModuleVehicle_Position;
                tooltip = $STR_NL_ModuleVehicle_Position_Tooltip;
                typeName = "STRING";
            };

            class NL_ModuleCode: Edit
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
        functionPriority = 15;
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
                defaultValue = "Box_NATO_Equip_F";
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

            class NL_ModulePosition: Edit
            {
                property = "NURMI_NL_moduleSupplie_Position";
                displayName = $STR_NL_ModuleSupplie_Position;
                tooltip = $STR_NL_ModuleSupplie_Position_Tooltip;
                typeName = "STRING";
            };

            class NL_ModuleCode: Edit
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
        functionPriority = 15;
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

            class NL_ModuleCode: Edit
            {
                property = "NURMI_NL_moduleLoadout_Gear";
                displayName = $STR_NL_ModuleLoadout_Code;
                tooltip = $STR_NL_ModuleLoadout_Code_Tooltip;
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

            class NL_ModuleMarker: Checkbox
            {
                property = "NURMI_NL_ModuleRearm_Marker";
                displayName = $STR_NL_ModuleRearm_Marker;
                tooltip = $STR_NL_ModuleRearm_Marker_Tooltip;
                typeName = "BOOLEAN";
                defaultValue = true;
            };

            class ModuleDescription: ModuleDescription{};
        };

        class ModuleDescription: ModuleDescription
        {
            description = $STR_NL_ModuleRearm_Description;
        };
    };
};

//https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes
class Cfg3DEN
{
    // Configuration of all objects
    class Object
    {
        // Categories collapsible in "Edit Attributes" window
        class AttributeCategories
        {
            // Category class, can be anything
            class NurmiLogistics
            {
                displayName = $STR_NL_Mod_Name; // Category name visible in Edit Attributes window
                collapsed = 1; // When 1, the category is collapsed by default
                class Attributes
                {
                    // Attribute class, can be anything
                    class NurmiAmountOfRearmes
                    {
                        //--- Mandatory properties
                        displayName = $STR_NL_ConfigVariable_AmountOfRearmes; // Name assigned to UI control class Title
                        tooltip = $STR_NL_ConfigVariable_AmountOfRearmest_Tooltip; // Tooltip assigned to UI control class Title
                        property = "NurmiAmountOfRearmes"; // Unique config property name saved in SQM
                        control = "Edit"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes

                        // Expression called when applying the attribute in Eden and at the scenario start
                        // The expression is called twice - first for data validation, and second for actual saving
                        // Entity is passed as _this, value is passed as _value
                        // %s is replaced by attribute config name. It can be used only once in the expression
                        // In MP scenario, the expression is called only on server.
                        expression = "_this setVariable ['%s',_value];";

                        // Expression called when custom property is undefined yet (i.e., when setting the attribute for the first time)
                        // Entity (unit, group, marker, comment etc.) is passed as _this
                        // Returned value is the default value
                        // Used when no value is returned, or when it is of other type than NUMBER, STRING or ARRAY
                        // Custom attributes of logic entities (e.g., modules) are saved always, even when they have default value
                        defaultValue = -1;

                        //--- Optional properties
                        unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
                        validate = "number"; // Validate the value before saving. If the value is not of given type e.g. "number", the default value will be set. Can be "none", "expression", "condition", "number" or "variable"
                        condition = "objectVehicle"; // Condition for attribute to appear (see the table below)
                        typeName = "NUMBER"; // Defines data type of saved value, can be STRING, NUMBER or BOOL. Used only when control is "Combo", "Edit" or their variants
                    };

                    class NurmiSkipObject
                    {
                        //--- Mandatory properties
                        displayName = $STR_NL_ConfigVariable_SkipObject;
                        tooltip = $STR_NL_ConfigVariable_SkipObject_Tooltip;
                        property = "NurmiSkipObject";
                        control = "Checkbox";
                        expression = "_this setVariable ['%s',_value];";
                        defaultValue = "false";

                        //--- Optional properties
                        unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
                        validate = "none"; // Validate the value before saving. If the value is not of given type e.g. "number", the default value will be set. Can be "none", "expression", "condition", "number" or "variable"
                        condition = "objectVehicle"; // Condition for attribute to appear (see the table below)
                        typeName = "BOOL"; // Defines data type of saved value, can be STRING, NUMBER or BOOL. Used only when control is "Combo", "Edit" or their variants
                    };
                };
            };
        };
    };
};