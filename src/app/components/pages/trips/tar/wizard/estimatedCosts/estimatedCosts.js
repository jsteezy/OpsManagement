import template from "./estimatedCosts.html";
import controller from "./EstimatedCostsController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        estimatedCost: "=ngModel"
    }
};

export default component;
