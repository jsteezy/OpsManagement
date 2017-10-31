import template from "./peoplePicker.html";
import controller from "./PeoplePickerController";

let peoplePicker = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        model: "=ngModel",
        modelIds: "=?",
        options: "<"
    },
    require: {
        form: "?^form"
    }
};

export default peoplePicker;