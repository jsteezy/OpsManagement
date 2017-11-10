import template from "./profileSearch.html";
import controller from "./ProfileSearchController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: '<'
    }
};

export default component;