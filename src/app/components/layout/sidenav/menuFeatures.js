import Permissions from "../../../common/enums/permissions.json";

export default class MenuFeatures {
    static get menuItems() {
        return [{
                "name": "HOME_SIDE_NAV",
                "type": "link",
                "icon": "home",
                "state": "Home",
                "permissions": [Permissions.everyone]
            },
            // {
            //     "name": "TRIPS_SIDE_NAV",
            //     "type": "toggle",
            //     "icon": "airplanemode_active",
            //     "permissions": [Permissions.everyone],
            //     "pages": [
            //         {
            //             "name": "TAR_SIDE_NAV",
            //             "state": "TarSearch",
            //             "type": "link",
            //             "permissions": [Permissions.everyone]
            //         },
            //         {
            //             "name": "EIF_SIDE_NAV",
            //             "state": "EifSearch",
            //             "type": "link",
            //             "permissions": [Permissions.everyone]
            //         }
            //     ]
            // },
            {
                "name": "Approvals",
                "type": "link",
                "icon": "check_box",
                "state": "TarApproval",
                "permissions": [Permissions.approvers, Permissions.admin]
            },
            // {
            //     "name": "Approvals",
            //     "type": "toggle",
            //     "icon": "check_box",
            //     "permissions": [Permissions.budgetApprovers, Permissions.superBudgetApprovers, Permissions.gssApprovers],
            //     "pages": [{
            //         "name": "TAR",
            //         "state": "TarApproval",
            //         "type": "link",
            //         "permissions": [Permissions.budgetApprovers, Permissions.superBudgetApprovers, Permissions.gssApprovers]
            //     }]
            // },
            {
                "name": "HISTORY",
                "type": "link",
                "icon": "history",
                "state": "TarHistory",
                "permissions": [Permissions.everyone]
            },
            {
                "name": "Admin",
                "state": "Dashboard",
                "type": "toggle",
                "icon": "supervisor_account",
                "permissions": [Permissions.admin],
                "pages": [{
                        "name": "Create",
                        "state": "Profile",
                        "type": "link",
                        "permissions": [Permissions.admin]
                    },
                    {
                        "name": "USERS_SIDE_NAV",
                        "state": "Users",
                        "type": "link",
                        "permissions": [Permissions.admin]
                    },
                    {
                        "name": "REGIONS_SIDE_NAV",
                        "state": "Regions",
                        "type": "link",
                        "permissions": [Permissions.admin]
                    },
                    {
                        "name": "COUNTRIES_SIDE_NAV",
                        "state": "Countries",
                        "type": "link",
                        "permissions": [Permissions.admin]
                    }
                    // {
                    //     "name": "ORG_UNIT_TYPES_SIDE_NAV",
                    //     "state": "OrgUnitTypes",
                    //     "type": "link",
                    //     "permissions": [Permissions.admin]
                    // },
                    // {
                    //     "name": "ORG_UNITS_SIDE_NAV",
                    //     "state": "OrgUnits",
                    //     "type": "link",
                    //     "permissions": [Permissions.admin]
                    // },
                    // {
                    //     "name": "EXPORT_SIDE_NAV",
                    //     "state": "Export",
                    //     "type": "link",
                    //     "permissions": [Permissions.admin]
                    // },
                    // {
                    //     "name": "ARCHIVE_SIDE_NAV",
                    //     "state": "Archive",
                    //     "type": "link",
                    //     "permissions": [Permissions.admin]
                    // }
                ]
            }
        ]
    }
}