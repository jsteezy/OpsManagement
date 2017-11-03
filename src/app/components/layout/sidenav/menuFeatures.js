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
            {
                "name": "ADMIN_SIDE_NAV",
                "state": "Dashboard",
                "type": "toggle",
                "icon": "supervisor_account",
                "permissions": [Permissions.admin],
                "pages": [{
                        "name": "Create",
                        "state": "Create",
                        "icon": "add",
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
                        "name": "COUNTRIES_SIDE_NAV",
                        "state": "Countries",
                        "type": "link",
                        "permissions": [Permissions.admin]
                    }
                    // {
                    //     "name": "MEMBERS_SIDE_NAV",
                    //     "state": "Members",
                    //     "type": "link",
                    //     "permissions": [Permissions.admin]
                    // },
                    // {
                    //     "name": "REGIONS_SIDE_NAV",
                    //     "state": "Regions",
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