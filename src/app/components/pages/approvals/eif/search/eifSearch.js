import template from "./eifSearch.html";
import controller from "./EifSearchController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: "<"
    }
};

export default component;