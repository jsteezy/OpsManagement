export default class RequestAttachmentsService {
    constructor(attachmentsDataAccessService) {
        this.attachmentsDataAccessService = attachmentsDataAccessService;
    }

    storeRequestAttachments(id, model) {
        return this.attachmentsDataAccessService.copyTo(this.getAttachmentsForCopyOptions(id, model))
            .then((newId) => {
                    return this.attachmentsDataAccessService.upload(this.getRequestAttachmentOptions(newId, model));
                },
                (errorData) => {
                    return Promise.reject(errorData);
                })
    }

    storeDraftAttachments(id, model) {
        return this.attachmentsDataAccessService.upload(this.getDraftAttachmentOptions(id, model));
    }

    getDraftAttachmentOptions(id, model) {
        return {};
    }

    getAttachmentsForCopyOptions(id, model) {
        return {};
    }

    getRequestAttachmentOptions(id, model) {
        return {};
    }
}