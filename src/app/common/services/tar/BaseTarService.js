import LanguageCache from "../LanguageCache";
import DateUtils from "../../helpers/DateUtils";

export default class BaseTarService{
    constructor(cache){
        this.cache = cache;
    }

    calculateTotalPercentage(model) {
        let total = 0;

        model.budgetCodes.forEach((x) => {
            total += x.percentage;
        });

        return total;
    }

    calculateTotalCosts(model) {
        let total = 0;

        model.otherEstimatedCosts.forEach((x) => {
            total += x.totalCosts;
        });

        return total;
    }


    getDestinationsDetails(destinationsArray) {
        if (destinationsArray.length <= 0)
            return {};

        let destinationsResults = [];
        let restrictedCountriesResults = [];
        let directorsResults = [];
        let departureDate = DateUtils.getDateOrEmpty(destinationsArray[0].departureDate, LanguageCache.language);
        let returnDate = DateUtils.getDateOrEmpty(destinationsArray[0].returnDate, LanguageCache.language);

        destinationsArray.forEach((destination) => {
            destinationsResults.push(destination.country.title);
            directorsResults.push(destination.country.director.Title);
            
            if (destination.country.travelRestrictions) {
                restrictedCountriesResults.push(destination.country.title);
            }

            let destDepartureDate = DateUtils.getDateOrEmpty(destination.departureDate, LanguageCache.language);
            let destReturnDate = DateUtils.getDateOrEmpty(destination.returnDate, LanguageCache.language);

            if (destDepartureDate < departureDate)
                departureDate = destDepartureDate;

            if (destReturnDate !== "" && destReturnDate > returnDate)
                returnDate = destReturnDate;
        });

        return {
            destinations: destinationsResults.join(", "),
            restrictedCountries: restrictedCountriesResults.join(", "),
            directors: directorsResults.join(", "),
            departureDate: departureDate,
            returnDate: returnDate
        };
    }

    cacheCurrentTravellerId(id) {
        if (!this.cache) return;

        const cache = this.cache.getById("traveller");
        cache.put("travellerId", id);
    }
}
