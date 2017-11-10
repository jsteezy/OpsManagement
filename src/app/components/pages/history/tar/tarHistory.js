import template from "./tarHistory.html";
import controller from "./TarHistoryController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: '<'
    }
};

export default component;