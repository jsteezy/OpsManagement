import ArrayUtils from "../../../common/helpers/ArrayUtils";
import EventsTypes from "../../../common/enums/eventsTypes.json";
import FormUtils from "../../../common/helpers/FormUtils";
import angular from "angular";

import BaseComponentController from "../BaseComponentController"

export default class PeoplePickerController extends BaseComponentController {
    constructor($scope, peoplePickerService) {
        super();

        this.$scope = $scope;
        this.peoplePickerService = peoplePickerService;

        this.currentIds = [];

        this.errors = new PeoplePickerErrors();

        this.activate();
    }

    activate() {
        this.searchText = null;

        const defaultTitle = "Title";
        const defaultIdField = "Id";
        this.defaultSize = 1;

        this.pickerOptions = {
            title: this.options.title || defaultTitle,
            placeholder: this.options.placeholder || "Please select a person",
            maxSize: this.options.maxSize || this.defaultSize,
            readonly: this.options.readonly || false,
            fieldMatch: this.options.fieldMatch || defaultTitle,
            autocompleteRequireMatch: true,
            searchField: this.options.searchField || defaultTitle,
            idField: this.options.idField || defaultIdField,
            query: this.options.query,
            name: this.options.name || undefined
        };

        this.setResolveModelWatcher();
        this.setResolveModelIdsWatcher()
        this.setValidateWatcher();

    }

    setResolveModelWatcher() {
        const self = this;

        let unRegister = this.$scope.$watchCollection("ctrl.model", (newValue) => {
            if (newValue && newValue.length > 0) {
                self.resolveModel();

                unRegister();
            }
        });
    }

    setResolveModelIdsWatcher() {
        const self = this;

        let unRegister = this.$scope.$watchCollection("ctrl.modelIds", ( newValue ) => {
            if (newValue) {
                self.currentIds = self.getCurrentIds(newValue);

                unRegister();
            }
        });
    }

    setValidateWatcher() {
        const self = this;

        this.$scope.$watchCollection("ctrl.model", () => {
            self.validate();
        });

    }

    transformChip(chip) {
        if (!angular.isObject(chip)) return null;

        this.hasInvalidPersons = false;

        if (this.pickerOptions.name) {
            super.emit(EventsTypes.peoplePickerChange, this.pickerOptions.name, chip);
        }

        return chip;
    }

    addChip(chip) {
        this.addModelId(chip);
        FormUtils.setPropertyAsTouched(this.form, this.options.name);
    }

    removeChip(chip) {
        this.removeModelIds(chip);
        FormUtils.setPropertyAsTouched(this.form, this.options.name);
    }

    addModelId( chip ) {
        if (this.modelIds === undefined) return;

        let chipValue = chip[this.pickerOptions.idField];

        ArrayUtils.add(this.currentIds, chipValue);

        this.modelIds = this.pickerOptions.maxSize === this.defaultSize ?
            this.lastId :
            this.currentIds;
    }

    removeModelIds( chip ) {
        if (this.modelIds === undefined) return;

        let chipValue = chip[this.pickerOptions.idField];

        ArrayUtils.remove(this.currentIds, chipValue);

        this.modelIds = this.pickerOptions.maxSize === this.defaultSize ?
            this.lastId :
            this.currentIds;
    }

    querySearch() {
        const methodName = this.pickerOptions.query.methodName;
        const groupName = this.pickerOptions.query.groupName;

        return this.peoplePickerService[methodName](this.searchText, groupName);
    }

    resolveModel() {
        let ensurePersonPromises = [];
        let updatedModel = [];

        angular.forEach(this.model, (person) => {
            let ensurePromise = this.querySearch(person[this.pickerOptions.searchField]);

            ensurePersonPromises.push(ensurePromise);
        });

        Promise.all(ensurePersonPromises).then((results) => {
            angular.forEach(results, (ensuredPerson) => {
                let isArray = angular.isArray(ensuredPerson);

                if (isArray && ensuredPerson.length > 0) {
                    updatedModel.push(ensuredPerson[0]);
                }
                else if (!isArray) {
                    updatedModel.push(ensuredPerson);
                }
            });

            this.hasInvalidPersons = this.model.length !== updatedModel.length;

            this.model = updatedModel;
        });
    }

    getDisplayTitle(item) {
        return item[this.pickerOptions.title];
    }

    getItemTextExpression() {
        return this.pickerOptions.title;
    }

    validate() {
        this.validateRequired();
        this.validateMaxSize();
    }

    validateRequired() {
        if (!this.options.required) return;

        this.errors.minSize = !this.model || this.model.length == 0;

        if (this.errors.minSize) {
            FormUtils.invalidateProperty(this.form, this.options.name, "minsize");
        }
        else {
            FormUtils.validateProperty(this.form, this.options.name, "minsize");
        }
    }

    validateMaxSize() {
        this.errors.maxSize = !this.model || this.model.length > this.pickerOptions.maxSize;

        if (this.errors.maxSize) {
            FormUtils.invalidateProperty(this.form, this.options.name, "maxsize");
        }
        else {
            FormUtils.validateProperty(this.form, this.options.name, "maxsize");
        }
    }

    set hasInvalidPersons(value) {
        this.errors.invalidPersons = value;

        FormUtils.setPropertyAsTouched(this.form, this.options.name);

        if (value) {
            FormUtils.invalidateProperty(this.form, this.options.name, "invalidpersons");
        }
        else {
            FormUtils.validateProperty(this.form, this.options.name, "invalidpersons");
        }
    }

    getCurrentIds( val ) {
        return this.pickerOptions.maxSize === this.defaultSize ? [val] : val.results;
    }

    get lastId() {
        return this.currentIds.length > 0 ? this.currentIds[this.currentIds.length - 1] : 0;
    }
}

class PeoplePickerErrors {
    constructor() {
        this.minSize = false;
        this.maxSize = false;
        this.invalidPersons = false;
    }
}

PeoplePickerController.$inject = ["$scope", "peoplePickerService"];