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
                "name": "Approvals",
                "type": "link",
                "icon": "check_box",
                "state": "TarApproval",
                "permissions": [Permissions.approvers, Permissions.admin]
            },
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
                ]
            }
        ]
    }
}