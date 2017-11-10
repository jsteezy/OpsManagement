import template from "./budgetCodes.html";
import controller from "./BudgetCodesController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        budgetCode: "=ngModel"
    }
};

export default component;
