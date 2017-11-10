import externalUrls from "./externalUrls.json";

export default class Options {
    static get options() {
        return {
            approvedByDirectorOptions: {
                label: "DIRECTOR_APPROVED_QUESTION",
                showWarning: false,
                name: "directorApproved",
                required: true,
                flex: 100
            },
            pdiOptions: {
                label: "PDI_QUESTION",
                showWarning: false,
                name: "pdi",
                flex: 100,
                required: true
            },
            travelProceduresOptions: {
                label: "TRAVEL_PROCEDURES_QUESTION",
                showWarning: true,
                warningMessage: "TRAVEL_PROCEDURE_WARNING",
                warningUrl: externalUrls.travelProcedures,
                name: "travelProcedures",
                flex: 100,
                required: true
            },
            departureProceduresOptions: {
                label: "PREDEPARTURE_QUESTION",
                showWarning: true,
                warningMessage: "PREDEPARTURE_WARNING",
                warningUrl: externalUrls.preDepartureProcedures,
                name: "departureProcedures",
                flex: 100,
                required: true
            },
            photoIdOptions: {
                label: "PHOTOID_QUESTION",
                showWarning: true,
                warningMessage: "PHOTOID_WARNING",
                warningUrl: externalUrls.photoIdWarning,
                name: "photoIdAnswer",
                flex: 100
            },
            securityTrainingOptions: {
                label: "GLOBALSECURITY_QUESTION",
                showWarning: true,
                warningMessage: "SECURITY_WARNING",
                warningUrl: externalUrls.securityWarning,
                name: "gSSTraining",
                flex: 100
            },
            medicalCardOptions: {
                label: "MEDICALCARD_QUESTION",
                showWarning: true,
                warningMessage: "MEDICALECARE_WARNING",
                warningUrl: externalUrls.medicalCardWarning,
                name: "medicalCard",
                flex: 100
            },
            regionalResponse: {
                label: "Regional response",
                showWarning: false,
                name: "regionalResponse",
                flex: 100,
                required: true
            },
            appropriateVaccinationOptions: {
                label: "HEALTH_QUESTION",
                showWarning: false,
                name: "healthAdvice",
                flex: 100,
                required: true
            },
            appropriateEmergencyOptions: {
                label: "APPROPRIATE_EMERGENCY_QUESTION",
                showWarning: false,
                name: "appropriateEmergency",
                flex: 100,
                required: true
            },
            officeLocationOptions: {
                label: "LONDON_OFFICE_QUESTION",
                showWarning: false,
                name: "londonOffice",
                flex: 100,
                required: true
            },
            sciFundsOptions: {
                label: "SCI_FUNDS_QUESTION",
                showWarning: false,
                name: "sciFunds",
                flex: 100,
                required: true
            },
            usaidFundsOptions: {
                label: "USAID_FUNDS_QUESTION",
                showWarning: false,
                name: "usaidFunds",
                flex: 100,
                required: true
            },
            travelPolicyOptions: {
                label: "EIF_TRAVEL_POLICY",
                showWarning: true,
                warningMessage: "WARNING_EIF_TRAVEL_POLICY",
                warningUrl: externalUrls.travelPolicyProcedures,
                name: "travelPolicy",
                flex: 100,
                required: true
            },
            departureShareOptions: {
                label: "EIF_SHARE_PREDEPARTURE",
                showWarning: true,
                warningMessage: "WARNING_EIF_SHARE_PREDEPARTURE",
                warningUrl: externalUrls.departureShareProcedures,
                name: "departureShare",
                flex: 100,
                required: true
            },
            safeGuardingPolicyOptions: {
                label: "EIF_SAFEGUARDING",
                showWarning: true,
                warningMessage: "WARNING_EIF_SAFEGUARDING",
                warningUrl: externalUrls.safeGuardPolicyProcedures,
                name: "safeguardingPolicy",
                flex: 100,
                required: true
            }
        }
    }
}