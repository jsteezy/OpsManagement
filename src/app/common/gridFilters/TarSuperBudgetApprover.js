import MaskOptions from "../enums/maskOptions.json";
import filters from "../enums/filters.json";
import QueryBuilder from "../queryUtils/QueryBuilder";

export default class TarSuperBudgetApprover {
    constructor() {
        this.init();

        this.builder = new QueryBuilder();
    }

    reset(){
        this.init();

        this.builder = new QueryBuilder();
    }

    init() {
        this.traveller = {
            value: "",
            mask: MaskOptions.basicName
        }

        this.requester = {
            value: "",
            mask: MaskOptions.basicName
        }

        this.budgetApprover = {
            value: "",
            mask: MaskOptions.basicName
        }

        this.departureDate = null;
        this.returnDate = null;
    }

    get query() {
        return this.builder
            .filter()
            .openBracket()
            .queryValue(filters.getAllForBudgetApprover)

            .transactional()
            .and()
            .contains(this.traveller.value, 'TAR_Traveller/Title')
            .commit()

            .transactional()
            .and()
            .contains(this.requester.value, 'TAR_Requester/Title')
            .commit()

            .transactional()
            .and()
            .contains(this.budgetApprover.value, 'TAR_BudgetApprover/Title')
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