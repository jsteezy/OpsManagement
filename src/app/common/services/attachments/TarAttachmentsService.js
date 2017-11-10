import RequestAttachmentsService from "./RequestAttachmentsService";

export default class TarAttachmentsService extends RequestAttachmentsService {
    constructor(attachmentsDataAccessService) {
        super(attachmentsDataAccessService);
    }

    getDraftAttachmentOptions(id, model) {
        return {
            files: model.uploadAttachments,
            storageName: 'TAR Drafts',
            id: id
        }
    }

    getAttachmentsForCopyOptions(id, model) {
        return {
            files: model.uploadedAttachments,
            storageName: 'TAR Requests',
            id: id
        }
    }

    getRequestAttachmentOptions(id, model) {
        return {
            files: model.uploadAttachments,
            storageName: 'TAR Requests',
            id: id
        }
    }
}

TarAttachmentsService.$inject = ["attachmentsDataAccessService"]