import RequestAttachmentsService from "./RequestAttachmentsService";

export default class EifAttachmentsService extends RequestAttachmentsService {
    constructor(attachmentsDataAccessService) {
        super(attachmentsDataAccessService);
    }

    getDraftAttachmentOptions(id, model) {
        return {
            files: model.uploadAttachments,
            storageName: 'EIF Drafts',
            id: id
        }
    }

    getAttachmentsForCopyOptions(id, model) {
        return {
            files: model.uploadedAttachments,
            storageName: 'EIF Requests',
            id: id
        }
    }

    getRequestAttachmentOptions(id, model) {
        return {
            files: model.uploadAttachments,
            storageName: 'EIF Requests',
            id: id
        }
    }
}

EifAttachmentsService.$inject = ["attachmentsDataAccessService"]