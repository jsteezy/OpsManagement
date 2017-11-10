import BaseModalController from "../../../common/BaseModalController";
import peoplePickerOptions from "../../../../common/enums/peoplePickerOptions";
import PageModes from "../../../../common/enums/pageModes.json";

export default class DelegateAccessController extends BaseModalController {
    constructor( $injector,
                 delegateAccessService,
                 toastService ) {
        super($injector);

        this.delegateAccessService = delegateAccessService;
        this.toastService = toastService;

        this.overridePickerOptions();

        this.activate();
    }

    activate() {
        super.isRequestProcessing;

        
        this.delegateAccessService.buildModel()
            .then(
                ( data ) => {
                    super.model = data
                    super.pageMode = PageModes.edit;

                    super.isRequestProcessing = false;
                },
                () => {
                    super.cancel();
                    this.toastService.showToast('DELEGATE_ACCESS_PROFILENOTFOUND', 'app');
                });
    }

    delegateAccess( form ) {
        super.IsSubmittedFormValid(form).then(() => {
            super.isRequestProcessing = true;

            this.delegateAccessService.store(super.pageMode, super.model).then(
                () => {
                    super.cancel();
                },
                (errorData) => {
                    super.serverRequestErrors =  errorData;
                });
        });
    }

    overridePickerOptions() {
        this.pickerOptions = peoplePickerOptions.options;

        this.pickerOptions.profileAccessToOthersOptions.required = true;
    }
}

DelegateAccessController.$inject = [
    "$injector",
    "delegateAccessService",
    "toastService"
];