import * as contact from "../../../../../common/models/EmergencyContactModel";
import BaseModalController from "../../../../common/BaseModalController";
import PageModes from "../../../../../common/enums/pageModes.json";
import PhoneTypes from "../../../../../common/enums/phoneTypes.json";
import ArrayUtils from "../../../../../common/helpers/ArrayUtils";
import MaskOptions from "../../../../../common/enums/maskOptions.json";

export default class EmergencyContactController extends BaseModalController {
    constructor($injector, toastService) {
        super($injector);
        
        this.toastService = toastService;

        this.phoneTypes = PhoneTypes.values;

        this.activate();

        this.setMaskOptions();
    }

    activate() {
        super.model = new contact.EmergencyContactModel();
        super.pageMode = PageModes.add;

        if (this.contact) {
            super.model = this.contact;
            super.pageMode = PageModes.edit;
        }

        if (super.model.phoneNumbers.length == 0) {
            this.addNewPhone();
        }
    }

    storeContact(form) {
        super.IsSubmittedFormValid(form).then(()=> {
            if (super.model.phoneNumbers.length == 0) {
                this.toastService.showToast('PHONELIST_ERROR', 'emergency-contact');
                return;
            }

            super.sendResponse(super.model);
        })
    }

    addNewPhone() {
        ArrayUtils.add(super.model.phoneNumbers, new contact.Phone());
    }

    removePhone(phone) {
        ArrayUtils.remove(super.model.phoneNumbers, phone);
    }

    phoneFormNames(index) {
        const phoneType = `type_${index}`;
        const phoneNumber = `number_${index}`;

        return {
            phoneType,
            phoneNumber
        }
    }

    setMaskOptions(){
        this.maskOptions = MaskOptions;
    }
}

EmergencyContactController.$inject = ["$injector", "toastService"];