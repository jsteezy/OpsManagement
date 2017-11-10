import template from "./eifDetails.html";
import controller from "./EifDetailsController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: "<"
    }
};

export default component;
