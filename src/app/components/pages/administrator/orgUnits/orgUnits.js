import template from "./orgUnits.html";
import controller from "./OrgUnitsController";

let orgUnits = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: "<"
    }
};

export default orgUnits;