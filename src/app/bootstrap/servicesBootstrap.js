import sideNavService from "../common/services/sideNav/SideNavService";

import modalService from "../common/services/materialElements/ModalDialogService";
import toastService from "../common/services/materialElements/ToastService";
import sheetService from "../common/services/materialElements/BottomSheetService";

import cacheService from "../common/services/Cache";
import navigationService from "../common/services/NavigationService";

import userService from "../common/services/user/UserService";
import profileDataAccessService from "../common/services/dataAccess/profile/ProfileDataAccessService";
//keep
import countryDataAccessService from "../common/services/dataAccess/country/CountryDataAccessService";
import regionDataAccessService from "../common/services/dataAccess/region/RegionDataAccessService";

import peoplePickerService from "../common/services/peoplePicker/PeoplePickerService";
import attachmentsDataAccessService from "../common/services/dataAccess/attachments/AttachmentsDataAccessService";
import tarDataAccessService from "../common/services/dataAccess/tar/TarDataAccessService";
import accountCodesDataAccessService from "../common/services/dataAccess/accountCodes/AccountCodesDataAccessService";
import tarApprovalDataAccessService from "../common/services/dataAccess/approval/TarApprovalDataAccessService";

import commonDataService from "../common/services/CommonDataService";
import tarAttachmentsService from "../common/services/attachments/TarAttachmentsService";

import tarSearchService from "../common/services/tar/TarSearchService";
import tarWizardService from "../common/services/tar/TarWizardService";
import tarDetailsService from "../common/services/tar/TarDetailsService";
import profileService from "../common/services/profile/ProfileService";
import profileSearchService from "../common/services/profile/ProfileSearchService";

import tarApprovalService from "../common/services/tar/TarApprovalService";
import tarApprovalWizardService from "../common/services/tar/TarApprovalWizardService";

import tarHistoryDataAccessService from "../common/services/dataAccess/history/TarHistoryDataAccessService";
import tarHistoryService from "../common/services/tar/TarHistoryService";

//keep
import responseService from "../common/services/response/ResponseService";
import responseCodeDataAccessService from "../common/services/dataAccess/responseCode/ResponseCodeDataAccessService";
import reportsService from "../common/services/reports/ReportsService";


import appHttpInterceptor from "../common/interceptors/AppHttpInterceptor";

import angular from "angular";

export default class Bootstrap {
    static register() {
        const app = angular.module("omt");

        app.service("sideNavService", sideNavService);

        app.service("modalService", modalService);
        app.service("toastService", toastService);
        app.service("bottomSheetService", sheetService);

        app.service("cache", cacheService);
        app.service("navigationService", navigationService);

        app.service("userService", userService);
        app.service("profileDataAccessService", profileDataAccessService);
        //keep
        app.service("countryDataAccessService", countryDataAccessService);
        app.service("regionDataAccessService", regionDataAccessService);

        app.service("attachmentsDataAccessService", attachmentsDataAccessService);
        app.service("peoplePickerService", peoplePickerService);
        app.service("tarDataAccessService", tarDataAccessService);
        app.service("accountCodesDataAccessService", accountCodesDataAccessService);
        app.service("tarApprovalDataAccessService", tarApprovalDataAccessService);

        app.service("tarHistoryDataAccessService", tarHistoryDataAccessService);

        app.service("commonDataService", commonDataService);
        app.service("tarAttachmentsService", tarAttachmentsService);

        app.service("tarSearchService", tarSearchService);
        app.service("tarWizardService", tarWizardService);
        app.service("tarDetailsService", tarDetailsService);
        app.service("profileService", profileService);
        app.service("profileSearchService", profileSearchService);

        //keep
        app.service("responseService", responseService);
        app.service("responseCodeDataAccessService", responseCodeDataAccessService);
        app.service("reportsService", reportsService);        
        

        app.service("tarApprovalService", tarApprovalService);
        app.service("tarApprovalWizardService", tarApprovalWizardService);

        app.service("tarHistoryService", tarHistoryService);


        app.service("appHttpInterceptor", appHttpInterceptor);
    }
}