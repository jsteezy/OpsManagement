import template from "./tarDetailsCommon.html";
import controller from "./TarDetailsCommonController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        model: "=ngModel"
    }
};

export default component;