import DropZone from  "dropzone/dist/dropzone";
import previewTemplate from "./previewTemplate.html";

export default class FileUploadController {
    constructor($element, attachmentsDataAccessService, cache) {
        this.$element = $element;
        this.attachmentsDataAccessService = attachmentsDataAccessService;
        this.cache = cache.getById('attachmentsCache');

        this.activate();
    }

    activate() {
        this.uniqueId = this.uniqueId || "";

        this.dropZone = new DropZone(this.$element[0].querySelector("div#container"), this.dropZoneOptions);

        this.setDropZoneEvents();
    }

    setDropZoneEvents() {
        this.dropZone.on("addedfile", (file) => {
            angular.element(this.$element[0].querySelector(".errors #duplicateError")).addClass('hide');
            angular.element(this.$element[0].querySelector(".errors #isEmptyError")).addClass('hide');

            if (file.size < 1) {
                angular.element(this.$element[0].querySelector(".errors #isEmptyError")).removeClass('hide');
                this.dropZone.removeFile(file);
                return;
            }

            let attachmentFiles = this.cache.get(this.uniqueId + 'attachments');

            if (!attachmentFiles) {
                attachmentFiles = [];
            }

            let duplicateFile = false;

            attachmentFiles.forEach((serverFile) => {
                if (serverFile.fileName === file.name) {
                    duplicateFile = true;
                }
            });

            if (duplicateFile) {
                angular.element(this.$element[0].querySelector(".errors #duplicateError")).removeClass('hide');
                this.dropZone.removeFile(file);
            }
            else {
                this.model.push(file);
            }
        });

        this.dropZone.on("removedfile", (file) => {
            let indexOf = this.model.findIndex(x => x == file);
            this.model.splice(indexOf, 1);
        })
    }

    get dropZoneOptions() {
        let previews = document.querySelectorAll("#previews");
        let clickables = document.querySelectorAll("#selectFiles");

        return {
            url: "dummy",
            autoDiscover: false,
            maxFilesize: 1.3,
            paramName: "uploadfile",
            maxThumbnailFilesize: 1,
            parallelUploads: 100,
            uploadMultiple: true,
            autoProcessQueue: false,
            previewTemplate: previewTemplate,
            previewsContainer: previews[previews.length - 1],
            clickable: clickables[clickables.length -1]
        };
    }
}

FileUploadController.$inject = ["$element", "attachmentsDataAccessService", "cache"];