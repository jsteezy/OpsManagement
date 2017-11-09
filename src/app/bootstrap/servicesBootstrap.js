import sideNavService from "../common/services/sideNav/SideNavService";

import modalService from "../common/services/materialElements/ModalDialogService";
import toastService from "../common/services/materialElements/ToastService";
import sheetService from "../common/services/materialElements/BottomSheetService";

import cacheService from "../common/services/Cache";
import navigationService from "../common/services/NavigationService";

import userService from "../common/services/user/UserService";
import responseDataAccessService from "../common/services/dataAccess/profile/ResponseDataAccessService";
import currencyDataAccessService from "../common/services/dataAccess/currency/CurrencyDataAccessService";
import countryDataAccessService from "../common/services/dataAccess/country/CountryDataAccessService";
import peoplePickerService from "../common/services/peoplePicker/PeoplePickerService";
import attachmentsDataAccessService from "../common/services/dataAccess/attachments/AttachmentsDataAccessService";
import commonDataService from "../common/services/CommonDataService";
import exportService from "../common/services/export/ExportService";
import appHttpInterceptor from "../common/interceptors/AppHttpInterceptor";
import responseService from "../common/services/response/ResponseService";


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
        app.service("responseDataAccessService", responseDataAccessService);
        app.service("currencyDataAccessService", currencyDataAccessService);
        app.service("countryDataAccessService", countryDataAccessService);
        app.service("attachmentsDataAccessService", attachmentsDataAccessService);
        app.service("peoplePickerService", peoplePickerService);
        app.service("commonDataService", commonDataService);
        app.service("exportService", exportService);
        app.service("appHttpInterceptor", appHttpInterceptor);
        app.service("responseService", responseService);

    }
}