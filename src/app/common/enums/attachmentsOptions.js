export default class AttachmentsOptions {
    static get empty(){
        return {
            listName: "",
            itemId: 0,
            uniqueId: ""
        }
    }

    static tarDraftOptions(itemId) {
        return {
            listName: "TAR Drafts",
            itemId: itemId,
            uniqueId: "tar"
        }
    }

    static tarRequestsOptions(itemId){
        return {
            listName: "TAR Requests",
            itemId: itemId,
            uniqueId: "tar",
            readOnly: true
        }
    }

    static eifDraftOptions(itemId) {
        return {
            listName: "EIF Drafts",
            itemId: itemId,
            uniqueId: "eif"
        }
    }

    static eifRequestOptions(itemId) {
        return {
            listName: "EIF Requests",
            itemId: itemId,
            uniqueId: "eif",
            readOnly: true
        }
    }
}
