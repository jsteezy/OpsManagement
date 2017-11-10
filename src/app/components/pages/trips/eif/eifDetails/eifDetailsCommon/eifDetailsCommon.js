import template from "./eifDetailsCommon.html";
import controller from "./EifDetailsCommonController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        model: "=ngModel"
    }
};

export default component;
