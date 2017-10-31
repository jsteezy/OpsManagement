import MaskOptions from "../enums/maskOptions.json";
import QueryBuilder from "../queryUtils/QueryBuilder";

export default class EifSearchAll {
    constructor() {
        this.init();

        this.builder = new QueryBuilder();
    }

    reset(){
        this.init();

        this.builder = new QueryBuilder();
    }

    init() {
        this.guestTravellerFirstName = {
            value: "",
            mask: MaskOptions.basicName
        }

        this.guestTravellerLastName= {
            value: "",
            mask: MaskOptions.basicName
        }

        this.staffResponsible = {
            value: "",
            mask: MaskOptions.basicName
        }

        this.departureDate = null;
        this.returnDate = null;
    }

    get query() {
        return this.builder
            .transactional()
            .filter()
            .openBracket()

            .transactional()
            .contains(this.guestTravellerFirstName.value, 'TAR_FirstName')
            .commit()

            .transactional()
            .and()
            .contains(this.guestTravellerLastName.value, 'TAR_LastName')
            .commit()

            .transactional()
            .and()
            .contains(this.staffResponsible.value, 'TAR_StaffResponsibleForGuest/Title')
            .commit()

            .transactional()
            .and()
            .openBracket()
            .field("TAR_DepartureDate")
            .datetime(this.departureDateValue, this.departureDateOperator)
            .closeBracket()
            .commit()

            .transactional()
            .and()
            .openBracket()
            .field("TAR_ReturnDate")
            .datetime(this.returnDateValue, this.returnDateOperator)
            .closeBracket()
            .commit()

            .closeBracket()
            .commit()

            .build();
    }

    get departureDateOperator() {
        return this.departureDate ? this.departureDate.operator : "";

    }

    get returnDateOperator() {
        return this.returnDate ? this.returnDate.operator : "";

    }

    get departureDateValue() {
        return this.departureDate ? this.departureDate.value : null;

    }

    get returnDateValue() {
        return this.returnDate ? this.returnDate.value : null;

    }
}