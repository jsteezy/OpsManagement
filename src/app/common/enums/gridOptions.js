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

            eifSearchAllOptions: {
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
                    { displayName: 'RESTRICT_COUNTRIES_GRID', field: 'restrictedCountries', enableSorting: true  },
                    { displayName: 'DEPARTUREDATE_GRID', field: 'departureDate', enableSorting: true, cellFilter: "dateFormat" },
                    { displayName: 'RETURNDATE_GRID', field: 'returnDate', cellFilter: "dateFormat" },
                    {
                        displayName: 'TARID_GRID',
                        field: 'tarId',
                        enableSorting: false,
                        cellTemplate: '<md-button class="md-primary" ng-if="grid.appScope.hasTarAssociated(row)" ng-click="grid.appScope.openTar(row)">{{COL_FIELD}}</md-button>'
                    }
                ],
                showExpandButtonAlways: true,
                hasCustomFilters: true
            },

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
            },

            tarHistoryOptions: {
                enableSorting: true,
                enableFiltering: true,
                enableHorizontalScrollbar: 0,
                enableVerticalScrollbar: 0,
                columnDefs: [
                    { field: 'id', visible: false },
                    {
                        displayName: 'ID_GRID',
                        field: 'title',
                        enableSorting: false,
                        cellTemplate: '<md-button class="md-primary" ng-click="grid.appScope.openTar(row)">{{COL_FIELD}}</md-button>'
                    },
                    { displayName: 'TRAVELLER_GRID', field: 'traveller', enableSorting: true },
                    { displayName: 'REQUESTER_GRID', field: 'requester' },
                    { displayName: 'DESTINATIONS_GRID', field: 'destinations', enableSorting: true },
                    { displayName: 'CD_GRID', field: 'directors', enableFiltering: false },
                    { displayName: 'DEPARTUREDATE_GRID', field: 'departureDate', enableSorting: true, cellFilter: "dateFormat" },
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

            responseCodeOptions: {
                enableSorting: true,
                enableFiltering: true,
                enableHorizontalScrollbar: 0,
                enableVerticalScrollbar: 0,
                columnDefs: [
                    { field: 'id', visible: false },
                    { displayName: 'Response Code', field: 'Code',
                    cellTemplate: '<md-button class="md-primary" ng-click="grid.appScope.openResponse(row.entity.Id)">{{COL_FIELD}}</md-button>'
                },
                { displayName: 'Response Status', field: 'ResponseStatus', enableFiltering: true, enableSorting: true },                                 
                    { displayName: 'Description', field: 'Description', enableSorting: false, enableFiltering: false },
                    { displayName: 'Start Date', field: 'StartDate', enableSorting: true, enableFiltering: false,  cellFilter: "dateFormat" },
                    { displayName: 'Country', field: 'Country', enableSorting: true },
                    { displayName: 'Region', field: 'Region', enableFiltering: true, enableSorting: true }                 
                ],                
                showExpandButtonAlways: false,
                hasCustomFilters: true
            },

            reportOptions: {
                enableSorting: true,
                enableFiltering: true,
                enableHorizontalScrollbar: 0,
                enableVerticalScrollbar: 0,
                columnDefs: [
                    { field: 'id', visible: false },
                    { displayName: 'Status', field: 'Status',
                   cellTemplate: '<md-button class="md-primary" ng-click="grid.appScope.openReport(row.entity.ResponseId, row.entity.Id)">{{COL_FIELD}}</md-button>'},                    
                    //cellTemplate: '<md-button class="md-primary" ng-if="row.entity.Status == Draft>(ng-click="grid.appScope.openReport(row.entity.ResponseId, row.entity.Id))"">Draft</md-button>                    <md-button class="md-primary" ng-if="row.entity.Status == "Submitted"(ng-click="grid.appScope.openReport(row.entity.ResponseId, row.entity.Id))"">Submitted</md-button>                    <md-button class="md-primary" ng-if="row.entity.Status == "Approved"(ng-click="grid.appScope.openReport(row.entity.ResponseId, row.entity.Id))"">Approved</md-button>' },

                    { displayName: 'Sitrep Date', field: 'SitrepDate', enableSorting: true, cellFilter: "dateFormat" },
                    { displayName: 'Next Sitrep Date', field: 'NextSitrepDate', cellFilter: "dateFormat" },
                    { displayName: 'Last modified by', field: 'Editor', enableFiltering: true, enableSorting: true }
                    
                    // { displayName: 'General Context', field: 'GeneralContext' },
                    // { displayName: 'Recent Context Development', field: 'RecentContextDevelopment' },
                    // { displayName: 'Response Update', field: 'ResponseUpdate' },
                    // { displayName: 'opsBackstop', field: 'OpsBackstop', enableSorting: true },
                    // { displayName: 'nonSciResponses', field: 'NonSciResponses'},
                    // { displayName: 'Affected Population', field: 'AffectedPopulation' },
                    // { displayName: 'Strategy Target', field: 'StrategyTarget' },
                    // { displayName: 'Total Reach Since Start', field: 'TotalReachSinceStart' },
                    // { displayName: 'Total Reach Since Last Sitrep', field: 'TotalReachSinceLastSitrep' },
                    // { displayName: 'Children Reached Since Start', field: 'ChildrenReachedSinceStart' },
                    // { displayName: 'Children Reached Since Last Sitrep', field: 'ChildrenReachedSinceLastSitrep' },
                    // { displayName: 'Response Strategy Target', field: 'ResponseStrategyTarget' },
                    // { displayName: 'Seed Funds Target', field: 'SeedFundsTarget' },
                    // { displayName: 'Seed Funds Target Date', field: 'SeedFundsTargetDate' },
                    // { displayName: 'Assessment', field: 'Assessment' },
                    // { displayName: 'Outline', field: 'Outline' },
                    // { displayName: 'Strategy', field: 'Strategy' },
                    // { displayName: 'Plan', field: 'Plan' },
                    // { displayName: 'Operations Control Review', field: 'OperationsControlReview' },
                    // { displayName: 'Real Time Review', field: 'RealTimeReview' },
                    // { displayName: 'Representation on HCT', field: 'RepresentationOnHCT' },
                    // { displayName: 'Education Cluster', field: 'EducationCluster' },
                    // { displayName: 'Staffing Education Cluster', field: 'StaffingEducationCluster' },
                    // { displayName: 'Child Protection Backstop', field: 'ChildProtectionBackstop' },
                    // { displayName: 'Child Protection Summary', field: 'ChildProtectionSummary' },
                    // { displayName: 'Education Backstop', field: 'EducationBackstop' },
                    // { displayName: 'Education Summary', field: 'EducationSummary' },
                    // { displayName: 'FSL Backstop', field: 'FSL Backstop' },
                    // { displayName: 'FSL Summary', field: 'FSLSummary' },
                    // { displayName: 'WASH Backstop', field: 'WASHBackstop' },
                    // { displayName: 'WASH Summary', field: 'WASHSummary' },
                    // { displayName: 'Shelter Backstop', field: 'shelterBackstop' },
                    // { displayName: 'Shelter Summary', field: 'shelterSummary' },
                    // { displayName: 'Health Backstop', field: 'HealthBackstop' },
                    // { displayName: 'Health Summary', field: 'HealthSummary' },
                    // { displayName: 'EHU Updates', field: 'EHUUpdates' },
                    // { displayName: 'EHU Present', field: 'EHUPresent' },
                    // { displayName: 'National Staff Number', field: 'NationalStaffNumber' },
                    // { displayName: 'International Staff Number', field: 'InternationalStaffNumber' },
                    // { displayName: 'Incident Summary', field: 'IncidentSummary' },
                    // { displayName: 'Security Events', field: 'SecurityEvents' },
                    // { displayName: 'Security Context', field: 'SecurityContext' },
                    // { displayName: 'Security Challenges', field: 'SecurityChallenges' },
                    // { displayName: 'Security Management', field: 'SecurityManagement' },
                    // { displayName: 'Staff Child Safegaurding', field: 'StaffChildSafegaurding' },
                    // { displayName: 'Safegaurding Focal Point', field: 'SafegaurdingFocalPoint' },
                    // { displayName: 'Safegaurding Risks', field: 'SafegaurdingRisks' },
                    // { displayName: 'Comms Pack', field: 'CommsPack' },
                    // { displayName: 'Media Coverage', field: 'MediaCoverage' },
                    // { displayName: 'Spokespeople', field: 'Spokespeople' },
                    // { displayName: 'Prepositioned Stock', field: 'PrepositionedStock' },
                    // { displayName: 'For This Response', field: 'ForThisResponse' },
                    // { displayName: 'Planned Procurement', field: 'PlannedProcurement' },
                    // { displayName: 'Procurement Spend', field: 'ProcurementSpend' }                                                               
                ],                
                showExpandButtonAlways: false,
                hasCustomFilters: true
            }
        }
    }
}