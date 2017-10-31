export default class GridOptions {
    static get options() {
        return {
            waitingForApproval: {
                enableSorting: true,
                enableFiltering: true,
                enableHorizontalScrollbar: 0,
                enableVerticalScrollbar: 0,
                columnDefs: [
                    {
                        displayName: 'ID_GRID',
                        field: 'id',
                        enableSorting: false,
                        cellTemplate: '<md-button class="md-primary" ng-click="grid.appScope.openTar(row)">{{COL_FIELD}}</md-button>'
                    },
                    { displayName: 'TRAVELLER_GRID', field: 'traveller', enableSorting: true},
                    { displayName: 'REQUESTER_GRID', field: 'requester' },
                    { displayName: 'DESTINATIONS_GRID', field: 'destinations', enableSorting: true},
                    { displayName: 'CD_GRID', field: 'directors'},
                    { displayName: 'DEPARTUREDATE_GRID', field: 'departureDate', enableSorting: true, cellFilter: "dateFormat", enableFiltering: true  },
                    { displayName: 'RETURNDATE_GRID', field: 'returnDate', cellFilter: "dateFormat" },
                    { displayName: 'BUDGETAPPROVER_GRID', field: 'budgetApprover' },
                    { displayName: 'BUDGETAPPROVERSTATUS_GRID', field: 'budgetApprovalStatus' },
                    { displayName: 'BUDGETAPPROVERTIMESTAMP_GRID', field: 'budgetApprovalTimestamp' },
                    { displayName: 'GSSAPPROVERSTATUS_GRID', field: 'gSSApprovalStatus' },
                    { displayName: 'GSSAPPROVERTIMESTAMP_GRID', field: 'gSSApprovalTimestamp' }
                ],
                showExpandButtonAlways: true,
                hasCustomFilters: true
            },

            drafts: {
                enableSorting: true,
                enableFiltering: true,
                enableHorizontalScrollbar: 0,
                enableVerticalScrollbar: 0,
                enableRowSelection: true,
                enableSelectAll: true,
                multiSelect: true,
                enableRowHeaderSelection: true,
                columnDefs: [
                    { field: 'id', visible: false },
                    {
                        displayName: 'ID_GRID',
                        field: 'title',
                        enableSorting: false,
                        cellTemplate: '<md-button class="md-primary" ng-click="grid.appScope.openDraft(row)">{{COL_FIELD}}</md-button>'
                    },
                    { displayName: 'TRAVELLER_GRID', field: 'traveller', enableSorting: false},
                    { displayName: 'REQUESTER_GRID', field: 'requester', enableSorting: false},
                    { displayName: 'DESTINATIONS_GRID', field: 'destinations', enableSorting: true }
                ],
                showDelete: true,
                deleteAction: "deleteDrafts"
            },

            budgetApproval: {
                enableSorting: true,
                enableFiltering: true,
                enableHorizontalScrollbar: 0,
                enableVerticalScrollbar: 0,
                columnDefs: [
                    {
                        displayName: 'ID_GRID',
                        field: 'id',
                        enableSorting: false,
                        cellTemplate: '<md-button class="md-primary" ng-click="grid.appScope.openTar(row)">{{COL_FIELD}}</md-button>'
                    },
                    { displayName: 'TRAVELLER_GRID', field: 'traveller', enableSorting: true },
                    { displayName: 'REQUESTER_GRID', field: 'requester' },
                    { displayName: 'DESTINATIONS_GRID', field: 'destinations', enableSorting: true },
                    { displayName: 'CD_GRID', field: 'directors', enableFiltering: false },
                    { displayName: 'DEPARTUREDATE_GRID', field: 'departureDate', enableSorting: true, cellFilter: "dateFormat" },
                    { displayName: 'RETURNDATE_GRID', field: 'returnDate', cellFilter: "dateFormat" }
                ],
                showExpandButtonAlways: true,
                hasCustomFilters: true
            },

            superBudgetApproval: {
                enableSorting: true,
                enableFiltering: true,
                enableHorizontalScrollbar: 0,
                enableVerticalScrollbar: 0,
                columnDefs: [
                    {
                        displayName: 'ID_GRID',
                        field: 'id',
                        enableSorting: false,
                        cellTemplate: '<md-button class="md-primary" ng-click="grid.appScope.openTar(row)">{{COL_FIELD}}</md-button>'
                    },
                    { displayName: 'TRAVELLER_GRID', field: 'traveller', enableSorting: true },
                    { displayName: 'REQUESTER_GRID', field: 'requester' },
                    { displayName: 'DESTINATIONS_GRID', field: 'destinations', enableSorting: true },
                    { displayName: 'CD_GRID', field: 'directors', enableFiltering: false },
                    { displayName: 'DEPARTUREDATE_GRID', field: 'departureDate', enableSorting: true, cellFilter: "dateFormat" },
                    { displayName: 'RETURNDATE_GRID', field: 'returnDate', cellFilter: "dateFormat" },
                    { displayName: 'Budget Approver', field: 'budgetApprover'}
                ],
                showExpandButtonAlways: true,
                hasCustomFilters: true
            },

            securityApproval: {
                enableSorting: true,
                enableFiltering: true,
                enableHorizontalScrollbar: 0,
                enableVerticalScrollbar: 0,
                columnDefs: [
                    {
                        displayName: 'ID_GRID',
                        field: 'id',
                        enableFiltering: false,
                        enableSorting: false,
                        cellTemplate: '<md-button class="md-primary" ng-click="grid.appScope.openTar(row)">{{COL_FIELD}}</md-button>'
                    },
                    { displayName: 'TRAVELLER_GRID', field: 'traveller', enableSorting: true},
                    { displayName: 'REQUESTER_GRID', field: 'requester' },
                    { displayName: 'DESTINATIONS_GRID', field: 'destinations', enableSorting: true },
                    { displayName: 'CD_GRID', field: 'directors', enableFiltering: false },
                    { displayName: 'DEPARTUREDATE_GRID', field: 'departureDate', enableSorting: true, cellFilter: "dateFormat" },
                    { displayName: 'RETURNDATE_GRID', field: 'returnDate', cellFilter: "dateFormat" },
                    { displayName: 'BUDGETAPPROVER_GRID', field: 'budgetApprover' },
                    { displayName: 'BUDGETAPPROVERSTATUS_GRID', field: 'budgetApprovalStatus' },
                    { displayName: 'BUDGETAPPROVERTIMESTAMP_GRID', field: 'budgetApprovalTimestamp' }
                ],
                showExpandButtonAlways: true,
                hasCustomFilters: true
            },

            eifDrafts: {
                enableSorting: true,
                enableFiltering: true,
                enableHorizontalScrollbar: 0,
                enableVerticalScrollbar: 0,
                enableRowSelection: true,
                enableSelectAll: true,
                multiSelect: true,
                enableRowHeaderSelection: true,
                columnDefs: [
                    { field: 'id', visible: false },
                    {
                        displayName: 'ID_GRID',
                        field: 'title',
                        enableSorting: false,
                        cellTemplate: '<md-button class="md-primary" ng-click="grid.appScope.openDraft(row)">{{COL_FIELD}}</md-button>'
                    },
                    { displayName: 'GUESTTRAVELLER_GRID', field: 'guestTraveller', enableSorting: false },
                    { displayName: 'DESTINATIONS_GRID', field: 'destinations', enableSorting: true },
                    {
                        displayName: 'TARID_GRID',
                        field: 'tarId',
                        enableFiltering: false,
                        enableSorting: false,
                        cellTemplate: '<md-button class="md-primary" ng-if="grid.appScope.hasTarAssociated(row)" ng-click="grid.appScope.openTarDraft(row)">{{COL_FIELD}}</md-button>'
                    }
                ],
                showDelete: true,
                deleteAction: "deleteDrafts"
            },

            eifSubmitted: {
                enableSorting: true,
                enableFiltering: true,
                enableHorizontalScrollbar: 0,
                enableVerticalScrollbar: 0,
                enableRowSelection: true,
                enableSelectAll: true,
                multiSelect: true,
                enableRowHeaderSelection: true,
                columnDefs: [
                    { field: 'id', visible: false },
                    {
                        displayName: 'ID_GRID',
                        field: 'title',
                        enableSorting: false,
                        cellTemplate: '<md-button class="md-primary" ng-click="grid.appScope.openEif(row)">{{COL_FIELD}}</md-button>'
                    },
                    { displayName: 'GUESTTRAVELLER_GRID', field: 'guestTraveller', enableSorting: false },
                    { displayName: 'STAFF_RESPOSIBLE_GRID', field: 'staffResponsible', enableSorting: false },
                    { displayName: 'DESTINATIONS_GRID', field: 'destinations', enableSorting: true },
                    { displayName: 'RESTRICT_COUNTRIES_GRID', field: 'restrictedCountries', enableSorting: true },
                    { displayName: 'DEPARTUREDATE_GRID', field: 'departureDate', enableSorting: true, cellFilter: "dateFormat" },
                    { displayName: 'RETURNDATE_GRID', field: 'returnDate', cellFilter: "dateFormat" },
                    {
                        displayName: 'TARID_GRID',
                        field: 'tarId',
                        enableSorting: false,
                        cellTemplate: '<md-button class="md-primary" ng-if="grid.appScope.hasTarAssociated(row)" ng-click="grid.appScope.openTar(row)">{{COL_FIELD}}</md-button>'
                    }
                ],
                showExpandButtonAlways: true
            },

            // eifSearchAllOptions: {
            //     enableSorting: true,
            //     enableFiltering: true,
            //     enableHorizontalScrollbar: 0,
            //     enableVerticalScrollbar: 0,
            //     enableRowSelection: true,
            //     enableSelectAll: true,
            //     multiSelect: true,
            //     enableRowHeaderSelection: true,
            //     columnDefs: [
            //         { field: 'id', visible: false },
            //         {
            //             displayName: 'ID_GRID',
            //             field: 'title',
            //             enableSorting: false,
            //             cellTemplate: '<md-button class="md-primary" ng-click="grid.appScope.openEif(row)">{{COL_FIELD}}</md-button>'
            //         },
            //         { displayName: 'GUESTTRAVELLER_GRID', field: 'guestTraveller', enableSorting: false },
            //         { displayName: 'STAFF_RESPOSIBLE_GRID', field: 'staffResponsible', enableSorting: false },
            //         { displayName: 'DESTINATIONS_GRID', field: 'destinations', enableSorting: true },
            //         { displayName: 'RESTRICT_COUNTRIES_GRID', field: 'restrictedCountries', enableSorting: true  },
            //         { displayName: 'DEPARTUREDATE_GRID', field: 'departureDate', enableSorting: true, cellFilter: "dateFormat" },
            //         { displayName: 'RETURNDATE_GRID', field: 'returnDate', cellFilter: "dateFormat" },
            //         {
            //             displayName: 'TARID_GRID',
            //             field: 'tarId',
            //             enableSorting: false,
            //             cellTemplate: '<md-button class="md-primary" ng-if="grid.appScope.hasTarAssociated(row)" ng-click="grid.appScope.openTar(row)">{{COL_FIELD}}</md-button>'
            //         }
            //     ],
            //     showExpandButtonAlways: true,
            //     hasCustomFilters: true
            // },

            profileForOthersOptions: {
                enableSorting: true,
                enableFiltering: true,
                enableHorizontalScrollbar: 0,
                enableVerticalScrollbar: 0,
                enableRowSelection: true,
                enableSelectAll: true,
                multiSelect: true,
                enableRowHeaderSelection: true,
                columnDefs: [
                    { field: 'id', visible: false },
                    {
                        displayName: 'PROFILE_NAME_GRID',
                        field: 'title',
                        enableSorting: false,
                        cellTemplate: '<md-button class="md-primary" ng-click="grid.appScope.openProfile(row)">{{COL_FIELD}}</md-button>'
                    }
                    // { displayName: 'JOBTITLE_GRID', field: 'jobTitle', enableSorting: false },
                    // { displayName: 'OFFICE_LOCATION_GRID', field: 'officeLocation', enableSorting: false },
                    // { displayName: 'DEPARTMENT_GRID', field: 'department', enableSorting: false }
                ]
            }

            // tarHistoryOptions: {
            //     enableSorting: true,
            //     enableFiltering: true,
            //     enableHorizontalScrollbar: 0,
            //     enableVerticalScrollbar: 0,
            //     columnDefs: [
            //         { field: 'id', visible: false },
            //         {
            //             displayName: 'ID_GRID',
            //             field: 'title',
            //             enableSorting: false,
            //             cellTemplate: '<md-button class="md-primary" ng-click="grid.appScope.openTar(row)">{{COL_FIELD}}</md-button>'
            //         },
            //         { displayName: 'TRAVELLER_GRID', field: 'traveller', enableSorting: true },
            //         { displayName: 'REQUESTER_GRID', field: 'requester' },
            //         { displayName: 'DESTINATIONS_GRID', field: 'destinations', enableSorting: true },
            //         { displayName: 'CD_GRID', field: 'directors', enableFiltering: false },
            //         { displayName: 'DEPARTUREDATE_GRID', field: 'departureDate', enableSorting: true, cellFilter: "dateFormat" },
            //         { displayName: 'RETURNDATE_GRID', field: 'returnDate', cellFilter: "dateFormat" },
            //         { displayName: 'BUDGETAPPROVER_GRID', field: 'budgetApprover' },
            //         { displayName: 'BUDGETAPPROVERSTATUS_GRID', field: 'budgetApprovalStatus' },
            //         { displayName: 'BUDGETAPPROVERTIMESTAMP_GRID', field: 'budgetApprovalTimestamp' },
            //         { displayName: 'GSSAPPROVERSTATUS_GRID', field: 'gSSApprovalStatus' },
            //         { displayName: 'GSSAPPROVERTIMESTAMP_GRID', field: 'gSSApprovalTimestamp' }
            //     ],
                
            //     showExpandButtonAlways: true,
            //     hasCustomFilters: true
            // }
        }
    }
}