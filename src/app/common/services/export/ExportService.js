// import PapaParse from "babyparse/babyparse";

export default class ExportService {
    constructor( attachmentsDataAccessService ) {
        this.attachmentsDataAccessService = attachmentsDataAccessService;
    }

    exportData( options ) {
    }
}

ExportService.$inject = ["attachmentsDataAccessService"];