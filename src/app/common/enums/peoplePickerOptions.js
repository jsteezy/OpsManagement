export default class PeoplePickerOptions {
    static get options() {
        return {
            emergencyPickerOptions: {
                title: 'Title',
                maxSize: 10,
                readonly: false,
                placeholder: 'EMERGENCY_PICKER',
                fieldMatch: 'contactName',
                searchField: 'contactName',
                query: {
                    methodName: "queryEmergencyContacs"
                },
                name: "emergencyPicker",
                required: true
            },

            travellerPickerOptions: {
                title: 'Title',
                maxSize: 1,
                readonly: false,
                placeholder: 'TRAVELLER_LABEL',
                fieldMatch: 'email',
                searchField: 'email',
                query: {
                    methodName: "queryUsersIncludingOwn"
                },
                name: "travellerPicker",
                required: true
            },
            travelCoordinatorPickerOptions: {
                title: 'Title',
                maxSize: 1,
                readonly: false,
                placeholder: 'TRAVEL_COORDINATOR_LABEL',
                fieldMatch: 'email',
                searchField: 'email',
                query: {
                    methodName: "queryUsers"
                },
                name: "travelCoordinatorPicker"
            },
            budgetApproverPickerOptions: {
                title: 'Title',
                maxSize: 1,
                readonly: false,
                placeholder: 'BUDGET_APPROVER_LABEL',
                fieldMatch: 'email',
                searchField: 'email',
                query: {
                    methodName: "queryUsersInGroup",
                    groupName: "Budget Approvers"
                },
                name: "budgetApproverPicker",
                required: true
            },
            lineManagerPickerOptions: {
                title: 'Title',
                maxSize: 1,
                readonly: false,
                placeholder: 'LINE_MANAGER_LABEL',
                fieldMatch: 'email',
                searchField: 'email',
                query: {
                    methodName: "queryUsers"
                },
                name: "lineManagerPicker"
            },
            staffResponsiblePickerOptions: {
                title: 'Title',
                maxSize: 1,
                readonly: false,
                placeholder: 'EIF_STAFF_RESPONSIBLE',
                fieldMatch: 'email',
                searchField: 'email',
                query: {
                    methodName: "queryUsers"
                },
                name: "staffResponsiblePicker",
                required: true
            },
            additionalStaffMemberOptions: {
                title: 'Title',
                maxSize: 1,
                readonly: false,
                placeholder: 'ADDITIONAL_STAFF_MEMBER_LABEL',
                fieldMatch: 'email',
                searchField: 'email',
                query: {
                    methodName: "queryUsers"
                },
                name: "additionalStaffMemberPicker",
                hint: "ADDITIONAL_STAFF_MEMBER_HINT"
            },
            profileAccessToOthersOptions: {
                title: 'Title',
                maxSize: 1,
                readonly: false,
                placeholder: 'PROFILE_OTHERS_ACCESS',
                fieldMatch: 'email',
                searchField: 'email',
                query: {
                    methodName: "queryUsers"
                },
                name: "othersAccessPicker"
            }
        }
    }
}
