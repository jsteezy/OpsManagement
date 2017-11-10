import template from "./eifSearch.html";
import controller from "./EifSearchController";

let eifSearch = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: "<"
    }
};

export default eifSearch;