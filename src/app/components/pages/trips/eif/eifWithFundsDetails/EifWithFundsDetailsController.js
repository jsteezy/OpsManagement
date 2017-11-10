import BaseController from "../../../../common/BaseController";
import EventsTypes from "../../../../../common/enums/eventsTypes.json";
import peoplePickerOptions from "../../../../../common/enums/peoplePickerOptions";
import listOptions from "../../../../../common/enums/listOptions";

export default class EifWizardController extends BaseController {
    constructor( $injector,
                 eifDetailsService ) {

        super($injector);

        super.router = this.$router;

        this.eifDetailsService = eifDetailsService;

        this.title = "EIF_DETAILS";

        this.overridePeoplePickerOptions();
        this.overrideListOptions();
    }

    $routerOnActivate( next, current ) {
        super.permissions = [super.appPermissions.everyone];

        let init = () => {
            super.$routerOnActivate(next, current);
            return this.activate(next.params);
        };

        return super.initializePage(init);
    }

    activate( params ) {
        return super.initializePageData(this.loadModel(params.eifId, params.tarId));
    }

    loadModel( eifIdentifier, taridentifier ) {
        return this.eifDetailsService.buildModel(eifIdentifier, taridentifier)
            .then(
                ( data ) => {
                    super.model = data;

                    super.emit(EventsTypes.initCommonEifDetails, super.model);
                    super.emit(EventsTypes.initCommonTarDetails, super.model);
                    super.emit(EventsTypes.approvalDetailsLoaded, super.model);
                },
                ( errorData ) => {
                    super.serverRequestErrors = errorData;
                });
    }

    overridePeoplePickerOptions() {
        this.pickerOptions = peoplePickerOptions.options;

        this.pickerOptions.staffResponsiblePickerOptions.readonly = true;
        this.pickerOptions.travelCoordinatorPickerOptions.readonly = true;
        this.pickerOptions.budgetApproverPickerOptions.readonly = true;
        this.pickerOptions.lineManagerPickerOptions.readonly = true;
    }

    overrideListOptions() {
        this.listOptions = listOptions.options;

        this.listOptions.destinationsListOptions.readOnly = true;
        this.listOptions.travelAdvanceListOptions.readOnly = true;
        this.listOptions.estimatedCostsListOptions.readOnly = true;
        this.listOptions.budgetCodesListOptions.readOnly = true;
    }
}

EifWizardController.$inject = [
    "$injector",
    "eifWithFundsDetailsService"];