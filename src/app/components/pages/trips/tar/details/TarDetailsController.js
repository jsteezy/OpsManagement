import BaseController from "../../../../common/BaseController";
import peoplePickerOptions from "../../../../../common/enums/peoplePickerOptions";
import listOptions from "../../../../../common/enums/listOptions";
import EventsTypes from "../../../../../common/enums/eventsTypes.json";

export default class TarDetailsController extends BaseController {
    constructor(tarDetailsService, $injector) {
        super($injector);

        super.router = this.$router;

        this.title = "TAR_DETAILS";

        this.tarDetailsService = tarDetailsService;

        this.overridePeoplePickerOptions();
        this.overrideListOptions();
    }

    $routerOnActivate(next, current) {
        super.permissions = [super.appPermissions.everyone];

        let init = () => {
            super.$routerOnActivate(next, current);

            if (super.isPageModeApproval) {
                this.title = "";
            }

            return this.activate(next.params.id);
        };

        return super.initializePage(init);
    }

    activate(id) {
        return super.initializePageData(this.loadModel(id));
    }

    loadModel(id) {
        return this.tarDetailsService.buildModel(id)
            .then(
            (data) => {
                super.model = data;

                super.emit(EventsTypes.initCommonTarDetails, super.model);
                super.emit(EventsTypes.approvalDetailsLoaded, super.model);
            },
            (errorData) => {
                super.serverRequestErrors = errorData;
            });
    }

    overridePeoplePickerOptions() {
        this.pickerOptions = peoplePickerOptions.options;

        this.pickerOptions.emergencyPickerOptions.query = {
            methodName: "queryEmergencyContactsForTraveller"
        }
        this.pickerOptions.emergencyPickerOptions.readonly = true;
        this.pickerOptions.travellerPickerOptions.readonly = true;
        this.pickerOptions.lineManagerPickerOptions.readonly = true;
        this.pickerOptions.additionalStaffMemberOptions.readonly = true;
    }

    overrideListOptions() {
        this.listOptions = listOptions.options;
    }
}

TarDetailsController.$inject = ["tarDetailsService", "$injector"];