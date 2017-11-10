import template from "./destination.html";
import controller from "./DestinationController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        destination: "=ngModel"
    }
};

export default component;
