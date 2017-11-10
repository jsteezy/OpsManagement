import ExpenseCodesModel from "./ExpensesCodesModel";

export default class BudgetCodesModel extends ExpenseCodesModel{
    constructor() {
        super();

        this.percentage = "";
        this.selectedAccountCode ="";
    }
}