import template from "./expensesCodes.html";
import controller from "./ExpensesCodesController";

let expensesCodes = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        expensesCode: "=ngModel"
    }
};

export default expensesCodes;