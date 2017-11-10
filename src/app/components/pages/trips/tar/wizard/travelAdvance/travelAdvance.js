import template from "./travelAdvance.html";
import controller from "./TravelAdvanceController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        travelAdvance: "=ngModel"
    }
};

export default component;
