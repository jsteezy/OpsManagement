import template from "./tarHistoryDetails.html";
import controller from "./TarHistoryDetailsController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        tarModel: "=ngModel"
    }
};

export default component;