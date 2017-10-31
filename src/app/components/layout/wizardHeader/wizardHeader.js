import template from "./wizardHeader.html";
import controller from "./WizardHeaderController";

let component = {
	template,
	controller,
	controllerAs: "ctrl",
	bindings: {
		main: "="
	},
    require:{
        form: "^form"
    }
};

export default component;
