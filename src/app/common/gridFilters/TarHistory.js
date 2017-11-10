import MaskOptions from "../enums/maskOptions.json";
import filters from "../enums/filters.json";
import ApprovalStatuses from "../enums/approvalStatuses.json";
import QueryBuilder from "../queryUtils/QueryBuilder";
import LanguageCache from "../services/LanguageCache";
import DateUtils from "../helpers/DateUtils";

export default class TarHistory {
    constructor() {
        this.init();

        this.builder = new QueryBuilder();
    }

    reset(){
        this.init();

        this.builder = new QueryBuilder();
    }

    init() {
        this.months  = DateUtils.getAllMonths(LanguageCache.language);
        this.aprrovalStatuses = ApprovalStatuses.all;
        

        this.budgetApprovalStatus = "";
        this.gssApprovalStatus = "";
        this.selectedMonth = DateUtils.getCurrentMonthName(LanguageCache.language);
        this.year = {
            value: DateUtils.getCurrentYear().toString(),
            mask: MaskOptions.year
        }
    }

    get queryArchive() {
        let dates = this.dates;

        return this.builder
            .filter()
            .openBracket()
            .queryValue(filters.getHistoryTars)

            .transactional()
            .and()
            .field("TAR_CreatedDate")
            .datetime(dates.start, filters.ge)
            .commit()

            .transactional()
            .and()
            .field("TAR_CreatedDate")
            .datetime(dates.end, filters.le)
            .commit()

            .transactional()
            .and()
            .field("TAR_BudgetApprovalStatus")
            .eq()
            .value(this.budgetApprovalStatus)
            .commit()

            .transactional()
            .and()
            .field("TAR_GSSApprovalStatus")
            .eq()
            .value(this.gssApprovalStatus)
            .commit()

            .closeBracket()

            .build();
    }


    get queryRequests() {
        let dates = this.dates;

        return this.builder
            .filter()
            .openBracket()
            .queryValue(filters.getHistoryTars)

            .transactional()
            .and()
            .field("Created")
            .datetime(dates.start, filters.ge)
            .commit()

            .transactional()
            .and()
            .field("Created")
            .datetime(dates.end, filters.le)
            .commit()

            .transactional()
            .and()
            .field("TAR_BudgetApprovalStatus")
            .eq()
            .value(this.budgetApprovalStatus)
            .commit()

            .transactional()
            .and()
            .field("TAR_GSSApprovalStatus")
            .eq()
            .value(this.gssApprovalStatus)
            .commit()

            .closeBracket()

            .build();
    }

    get dates() {
        let monthIndex = this.months.indexOf(this.selectedMonth);

        return {
            start: DateUtils.getMonthStartDate(this.yearValue, monthIndex),
            end: DateUtils.getMonthEndDate(this.yearValue, monthIndex)
        }
    }

    get yearValue() {
        return this.year && this.year !== "" ? this.year.value : DateUtils.getCurrentYear() - 1;

    }
}