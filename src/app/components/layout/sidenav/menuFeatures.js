import Permissions from "../../../common/enums/permissions.json";

export default class MenuFeatures {
    static get menuItems() {
        return [
            {
                "name": "HOME_SIDE_NAV",
                "type": "link",
                "icon": "home",
                "state": "Home",
                "permissions": [Permissions.everyone]
            },
            {
                "name": "TRIPS_SIDE_NAV",
                "type": "toggle",
                "icon": "airplanemode_active",
                "permissions": [Permissions.everyone],
                "pages": [
                    {
                        "name": "TAR_SIDE_NAV",
                        "state": "TarSearch",
                        "type": "link",
                        "permissions": [Permissions.everyone]
                    },
                    {
                        "name": "EIF_SIDE_NAV",
                        "state": "EifSearch",
                        "type": "link",
                        "permissions": [Permissions.everyone]
                    }
                ]
            },
            {
                "name": "APPROVALS_SIDE_NAV",
                "type": "toggle",
                "icon": "check_box",
                "permissions": [Permissions.budgetApprovers, Permissions.superBudgetApprovers, Permissions.gssApprovers],
                "pages": [
                    {
                        "name": "TAR_SIDE_NAV",
                        "state": "TarApproval",
                        "type": "link",
                        "permissions": [Permissions.budgetApprovers, Permissions.superBudgetApprovers, Permissions.gssApprovers]
                    },
                    {
                        "name": "EIF_SIDE_NAV",
                        "state": "EifSearchAll",
                        "type": "link",
                        "permissions": [Permissions.gssApprovers]
                    }
                ]
            },
            {
                "name": "HISTORY_SIDE_NAV",
                "type": "toggle",
                "icon": "history",
                "permissions": [Permissions.everyone],
                "pages": [
                    {
                        "name": "TAR_SIDE_NAV",
                        "state": "TarHistory",
                        "type": "link",
                        "permissions": [Permissions.everyone]
                    }
                ]
            },
            {
                "name": "ADMIN_SIDE_NAV",
                "state": "Dashboard",
                "type": "toggle",
                "icon": "supervisor_account",
                "permissions": [Permissions.admin],
                "pages": [
                    {
                        "name": "USERS_SIDE_NAV",
                        "state": "Users",
                        "type": "link",
                        "permissions": [Permissions.admin]
                    },
                    {
                        "name": "MEMBERS_SIDE_NAV",
                        "state": "Members",
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
                    },
                    {
                        "name": "ORG_UNIT_TYPES_SIDE_NAV",
                        "state": "OrgUnitTypes",
                        "type": "link",
                        "permissions": [Permissions.admin]
                    },
                    {
                        "name": "ORG_UNITS_SIDE_NAV",
                        "state": "OrgUnits",
                        "type": "link",
                        "permissions": [Permissions.admin]
                    },
                    {
                        "name": "EXPORT_SIDE_NAV",
                        "state": "Export",
                        "type": "link",
                        "permissions": [Permissions.admin]
                    },
                    {
                        "name": "ARCHIVE_SIDE_NAV",
                        "state": "Archive",
                        "type": "link",
                        "permissions": [Permissions.admin]
                    }
                ]
            }
        ]
    }
}
