import EifWithFundsModel from "../../models/EifWithFundsModel";

export default class EifWithFundsDetailsService {
    constructor( eifDetailsService, tarDetailsService ) {
        this.eifDetailsService = eifDetailsService;
        this.tarDetailsService = tarDetailsService;
    }

    buildModel( eifidentifier, tarIdentifier ) {
        let model = new EifWithFundsModel();

        return Promise.all([
            this.eifDetailsService.buildModel(eifidentifier),
            this.tarDetailsService.buildModel(tarIdentifier)
        ]).then(
            ( data ) => {
                if (data) {
                    model = new EifWithFundsModel(data[0], data[1]);
                }

                return model;
            },
            ( errorData ) => {
                return Promise.reject(errorData)
            });
    }
}

EifWithFundsDetailsService.$inject = ["eifDetailsService", "tarDetailsService"]