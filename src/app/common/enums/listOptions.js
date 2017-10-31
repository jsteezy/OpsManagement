export default class ListOptions {
    static get options() {
        return {
            emergencyContactsListOptions: {
                orderBy: "contactName",
                displayFields: [
                    {
                        fieldName: "contactName"
                    }
                ],
                isDeleteEnabled: true,
                modalForm: `<emergency-contact ng-model="ctrl.entityModel"></emergency-contact>`,
                addIconClass: "add_circle_outline",
                showHeader: false
            },
            tarEmergencyContactsListOptions: {
                orderBy: "contactName",
                displayFields: [
                    {
                        header: "EMERGENCY_CONTACT_NAME",
                        fieldName: "contactName"
                    },
                    {
                        header: "EMERGENCY_CONTACT_RELATIONSHIP",
                        fieldName: "relationship"
                    }
                ],
                isDeleteEnabled: false,
                readOnly: true,
                modalViewForm: `<emergency-contact-view ng-model="ctrl.entityModel"></emergency-contact-view>`,
                addIconClass: "",
                showHeader: true
            },
            expensesCodesListOptions: {
                orderBy: "costCentre",
                displayFields: [
                    {
                        header: "NICKNAME",
                        fieldName: "nickname"
                    },
                    {
                        header: "COST_CENTRE",
                        fieldName: "costCentre"
                    },
                    {
                        header: "PROJECT_CODE",
                        fieldName: "projectCode"
                    },
                    {
                        header: "SOURCE_OF_FUND",
                        fieldName: "sourceOfFund"
                    },
                    {
                        header: "DEA_CODE",
                        fieldName: "deaCode",
                        showOn: "gt-sm"
                    }
                ],
                isDeleteEnabled: true,
                modalForm: `<expenses-codes ng-model="ctrl.entityModel"></expenses-codes>`,
                addIconClass: "add_shopping_cart",
                showHeader: true,
                hideShowAllOn: "gt-sm"
            },
            destinationsListOptions: {
                orderBy: "country.title",
                displayFields: [
                    {
                        header: "DESTINATIONS_LABEL",
                        fieldName: "country.title"
                    },
                    {
                        header: "DEPARTUREDATE_LABEL",
                        fieldName: "departureDate",
                        filter: "dateFormat"
                    },
                    {
                        header: "RETURNDATE_LABEL",
                        fieldName: "returnDate",
                        filter: "dateFormat"
                    }
                ],
                isDeleteEnabled: true,
                modalForm: `<destination ng-model="ctrl.entityModel"></destination>`,
                showHeader: true,
                addIconText: "DESTINATIONS_ICON_TEXT",
                addIconClass: "card_travel"
            },
            travelAdvanceListOptions: {
                displayFields: [
                    {
                        header: "TRAVEL_ADVANCE_AMOUNT",
                        fieldName: "amount"
                    },
                    {
                        header: "CURRENCY_LABEL",
                        fieldName: "currencyType.title"
                    }],
                isDeleteEnabled: true,
                modalForm: `<travel-advance ng-model="ctrl.entityModel"></travel-advance>`,
                showHeader: false,
                addIconClass: "add_circle_outline"
            },
            estimatedCostsListOptions: {
                orderBy: "location",
                displayFields: [
                    {
                        header: "LOCATION_LABEL",
                        fieldName: "location"
                    },
                    {
                        header: "NO_OF_DAYS",
                        fieldName: "noOfDays"
                    },
                    {
                        header: "ESTIMATED_BOARD_LABEL",
                        fieldName: "estimatedBoard"
                    },
                    {
                        header: "ESTIMATED_OTHER_LABEL",
                        fieldName: "otherCosts"
                    },
                    {
                        header: "TOTAL_ESTIMATED_COSTS",
                        fieldName: "totalCosts"
                    }],
                isDeleteEnabled: true,
                modalForm: `<estimated-costs ng-model="ctrl.entityModel"></estimated-costs>`,
                showHeader: true,
                addIconClass: "add_circle_outline",
                hideShowAllOn: "gt-sm"
            },
            budgetCodesListOptions: {
                orderBy: "costCentre",
                displayFields: [
                    {
                        header: "PERCENTAGE_LABEL",
                        fieldName: "percentage"
                    },
                    {
                        header: "ACCOUNT_CODE_LABEL",
                        fieldName: "selectedAccountCode.title"
                    },
                    {
                        header: "COST_CENTRE",
                        fieldName: "costCentre"
                    },
                    {
                        header: "PROJECT_CODE",
                        fieldName: "projectCode"
                    },
                    {
                        header: "SOURCE_OF_FUND",
                        fieldName: "sourceOfFund"
                    },
                    {
                        header: "DEA_CODE",
                        fieldName: "deaCode",
                        showOn: "gt-sm"
                    }],
                isDeleteEnabled: true,
                modalForm: `<budget-codes ng-model="ctrl.entityModel"></budget-codes>`,
                addIconClass: "add_shopping_cart",
                showHeader: true,
                hideShowAllOn: "gt-sm"
            }
        }
    }
}
