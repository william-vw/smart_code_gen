var dummy_condition = {
    id: "123", hasType: "123",
    clinicalStatus: 'active',
    code: 123,
    verificationStatus: 'confirmed',
    exists: false
}

var dummy_coverage = {
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

var dummy_patient = {
    id: "0", hasType: "123",
    subjectOf: [], // Condition*
    policyHolderOf: [], // Coverage*
    exists: false
};

var dummy_practitioner = {
    id: "123", hasType: "123",
    exists: true
}

var dummy_medReq = { // MedicationRequest
    id: "123", hasType: "123",
    reason: dummy_condition,
    subject: dummy_patient,
    medication: [{ // Medication*
        id: "123", hasType: "123",
        concept: 123,
        exists: false
    }],
    dosageInstruction: [{ // Dosage*
        id: "123", hasType: "123",
        route: 123,
        requester: [ dummy_practitioner ],
        performer: [ dummy_patient ],
        method: 123,
        exists: false
    }],
    exists: false
};

var dummy_response = {
    id: "123", hasType: "123",
    outcome: "",
    request: dummy_medReq,
    covered: dummy_coverage,
    patient: dummy_patient,
    exists: false
};

var cond_immuneDeficiencyDisease = {
    id: "123", hasType: "123",
    clinicalStatus: 'active',
    code: 58606002, // immuneDeficiencyDisease
    verificationStatus: 'confirmed',
    exists: true
}

var patient = {
    id: "123", hasType: "123",
    subjectOf: [ cond_immuneDeficiencyDisease ],
    policyHolderOf: [], // Coverage*
    exists: true
}

var practitioner = {
    id: "123", hasType: "123",
    exists: true
}

exports.request = {
    id: "123", hasType: "123",
    status: "active",
    patient: patient,
    purpose: "validation",
    immuneDeficiencyDisease: dummy_condition,
    provider: practitioner,
    item: [{ // MedicationRequest*
        id: "123", hasType: "123",
        reason: cond_immuneDeficiencyDisease,
        subject: patient,
        medication: [{ // Medication*
            id: "123", hasType: "123",
            concept: 243196004,
            exists: true
        }],
        dosageInstruction: [{ // Dosage*
            id: "123", hasType: "123",
            route: 255560000,
            requester: [ practitioner ],
            performer: [ patient ],
            method: 385985008,
            exists: true
        }],
        exists: true
    }],
    ivigDrugItem: dummy_medReq,
    response: dummy_response,
    exists: true
}