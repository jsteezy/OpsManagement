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
            return this.activate(next.params.id);
        };

        return super.initializePage(init);
    }

    activate( eifIdentifier ) {
        return super.initializePageData(this.loadModel(eifIdentifier));
    }

    loadModel( eifIdentifier ) {
        return this.eifDetailsService.buildModel(eifIdentifier)
            .then(
                ( data ) => {
                    super.model = data;

                    super.emit(EventsTypes.initCommonEifDetails, super.model);
                },
                ( errorData ) => {
                    super.serverRequestErrors = errorData;
                });
    }

    overridePeoplePickerOptions() {
        this.pickerOptions = peoplePickerOptions.options;

        this.pickerOptions.staffResponsiblePickerOptions.readonly = true;
    }

    overrideListOptions() {
        this.listOptions = listOptions.options;

        this.listOptions.destinationsListOptions.readOnly = true;
    }
}

EifWizardController.$inject = [
    "$injector",
    "eifDetailsService"];