let dummy_coverage = {
    id: "123", hasType: "123",
    insurer: {
        id: "123", hasType: "Medicare",
        exists: false
    },
    class: {
        id: "123", hasType: "PartB",
        exists: false
    },
    status: "",
    exists: false
};

let dummy_procedure = {
    id: "123", hasType: "123",
    status: "",
    code: 0,
    exists: false
};

let dummy_medReq = {
    id: "123", hasType: "123",
    medication: [{ // Medication*
        id: "123", hasType: "123",
        concept: "",
        exists: false
    }],
    eligibleTransplant: { // Procedure
        id: "123", hasType: "123",
        status: "",
        code: 0,
        exists: false
    },
    exists: false
};

let dummy_patient = {
    id: "0", hasType: "123",
    subjectOf: [], // Claim*
    policyHolderOf: [], // Coverage*
    exists: false
}

let dummy_response = {
    id: "123", hasType: "123",
    outcome: "",
    request: dummy_medReq,
    covered: dummy_coverage,
    patient: dummy_patient,
    exists: false
};

exports.request = {
    id: "123", hasType: "123",
    purpose: "validation",
    item: [{ // MedicationRequest*
        id: "123", hasType: "123",
        medication: [{ // Medication*
            id: "123", hasType: "123",
            concept: "DBCAT005064",
            exists: true
        }],
        eligibleTransplant: dummy_procedure,
        exists: true
    }],
    patient: {  // Patient
        id: "123", hasType: "123",
        subjectOf: [], // Claim*
        policyHolderOf: [], // Coverage*
        exists: true
    },

    immunoTherapyItem: dummy_medReq,
    response: dummy_response,
    
    exists: true
};