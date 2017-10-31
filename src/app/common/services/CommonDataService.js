import ObjectMapper from "../helpers/ObjectMapper";

export default class CommonDataService {
    constructor(countryDataAccessService, currencyDataAccessService, accountCodesDataAccessService) {
        this.countryDataAccessService = countryDataAccessService;
        this.currencyDataAccessService = currencyDataAccessService;
        this.accountCodesDataAccessService = accountCodesDataAccessService;
    }

    loadCountries() {
        return this.countryDataAccessService.getAll().then((data) => {
            return ObjectMapper.toAnonymous(data);
        })
    }

    loadCurrencies() {
        return this.currencyDataAccessService.getAll().then((data) => {
            return ObjectMapper.toAnonymous(data);
        })
    }

    loadAccountCodes(){
        return this.accountCodesDataAccessService.getAll().then((data) =>{
            return ObjectMapper.toAnonymous(data);
        });
    }
}

CommonDataService.$inject = ["countryDataAccessService", "currencyDataAccessService", "accountCodesDataAccessService"];