import template from "./orgUnitTypes.html";
import controller from "./OrgUnitTypesController";

let orgUnitTypes = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: "<"
    }
};

export default orgUnitTypes;