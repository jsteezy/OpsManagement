import template from "./tarDetails.html";
import controller from "./TarDetailsController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: "<"
    }
};

export default component;