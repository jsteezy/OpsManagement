import template from "./bottomSheetList.html";
import controller from "./BottomSheetListController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        listModel: "=ngModel",
        options: "<"
    }
};

export default component;