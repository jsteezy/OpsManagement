export default class BottomListOptions {
    static get options() {
        return {
            expensesCodesListOptions: {
                displayFields: [
                    {
                        header: "NICKNAME",
                        fieldName: "nickname",
                        flex: 20
                    },
                    {
                        header: "COST_CENTRE",
                        fieldName: "costCentre",
                        flex: 20
                    },
                    {
                        header: "PROJECT_CODE",
                        fieldName: "projectCode",
                        flex: 20
                    },
                    {
                        header: "SOURCE_OF_FUND",
                        fieldName: "sourceOfFund",
                        flex: 20
                    },
                    {
                        header: "DEA_CODE",
                        fieldName: "deaCode",
                        flex: 20
                    }]
            }
        }
    }
}

