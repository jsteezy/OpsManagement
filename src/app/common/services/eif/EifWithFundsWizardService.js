import EifWithFundsWizardModel from "../../models/EifWithFundsModel";

export default class EifWithFundsWizardService {
    constructor(commonDataService, eifWizardService, tarWizardService) {
        this.commonDataService = commonDataService;
        this.eifWizardService = eifWizardService;
        this.tarWizardService = tarWizardService;
    }

    buildModel(eifData, tarData) {
        if (!eifData) {
            eifData = this.eifWizardService.buildModel(eifData);
        }
        
        if (!tarData) {
            tarData = this.tarWizardService.buildBasicModel(tarData);
        }
        
        let model = new EifWithFundsWizardModel(
                            eifData,
                            tarData);

        return model;
    }

    loadDraft(eifIdentifier, tarIdentifier) {
        return Promise.all([
            this.eifWizardService.loadDraft(eifIdentifier),
            this.tarWizardService.loadBasicDraft(tarIdentifier)
        ])
            .then(
                (data) => {
                    return this.buildModel(data[0], data[1])
                },
                (errorData) => {
                    return Promise.reject(errorData)
                });
    }

    loadPageData() {
        return Promise.all([this.commonDataService.loadCountries(), this.commonDataService.loadCurrencies()]);
    }


    storeRequest(model) {
        model.eif.destinations = model.tar.destinations;
        
        return this.tarWizardService.storeRequest(model.tar).then((data) => {
            model.eif.tarId = data[0];
            
            return this.eifWizardService.storeRequest(model.eif);
        }, 
        (errorData) => {
            return Promise.reject(errorData);
        })
    }

    storeDraft(pageMode, model) {
        model.eif.destinations = model.tar.destinations;
        
        return this.tarWizardService.storeDraft(pageMode, model.tar)
            .then(
                (data) => {
                    model.eif.tarId = data[0];

                    return this.eifWizardService.storeDraft(pageMode, model.eif);
                },
                (errorData) => {
                    return Promise.reject(errorData);
                });
    }

    deleteDraft(model) {
        return Promise.all([
            this.eifWizardService.deleteDraft(model.eif),
            this.tarWizardService.deleteDraft(model.tar)
        ]);
    }
}

EifWithFundsWizardService.$inject = ["commonDataService", "eifWizardService", "tarWizardService"]