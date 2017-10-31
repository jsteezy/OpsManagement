import angular from "angular";

export default class ModalDialogService {
    constructor($mdDialog, $mdMedia, $translate) {
        this.$mdDialog = $mdDialog;
        this.$mdMedia = $mdMedia;
        this.$translate = $translate;
    }

    showWizardModal(component, targetEvent, model) {
        return this.$mdDialog.show({
            template: component,
            parent: angular.element(document.body),
            targetEvent: targetEvent,
            clickOutsideToClose: true,
            openFrom: "left",
            controller: angular.noop,
            controllerAs: 'ctrl',
            bindToController:true,
            locals:{
                entityModel: angular.copy(model)
            }
        });
    }

    showConfirmDialog(title, text = "EMPTY_TEXT", ev) {
        return Promise.all([
                this.$translate(title),
                this.$translate(text),
                this.$translate('YES'),
                this.$translate('NO')
            
            ]
        ).then(
            (data) => {
                let options = {
                    title: data[0],
                    text: data[1],
                    event: ev,
                    yes: data[2],
                    no: data[3]
                };

                return this.$mdDialog.show(this.getConfirm(options))
            },
            () => {
                let options = {
                    title,
                    text,
                    event: ev,
                    yes: "Yes",
                    no: "No"
                };

                return this.$mdDialog.show(this.getConfirm(options))
            }
        )
    }

    getConfirm(options) {
        return this.$mdDialog.confirm()
            .title(options.title)
            .textContent(options.text)
            .ariaLabel("confirm")
            .targetEvent(options.ev)
            .theme('pageTheme')
            .ok(options.yes)
            .cancel(options.no);
    }
}

ModalDialogService.$inject = ['$mdDialog', '$mdMedia', "$translate"];