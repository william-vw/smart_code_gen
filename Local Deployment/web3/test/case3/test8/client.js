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
    gender: 'none',
    policyHolderOf: [], // Coverage*
    exists: false
};

var dummy_medReq = { // MedicationRequest
    id: "123", hasType: "123",
    reason: dummy_condition,
    subject: dummy_patient,
    medication: [{ // Medication*
        id: "123", hasType: "123",
        concept: 123,
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

var cond_pmOsteo = {
    id: "123", hasType: "123",
    clinicalStatus: 'active',
    code: 102447009, // pmOsteo
    verificationStatus: 'confirmed',
    exists: true
}

var cond_osteoBoneFracture = {
    id: "123", hasType: "123",
    clinicalStatus: 'active',
    code: 443165006, // osteoBoneFracture
    verificationStatus: 'confirmed',
    exists: true
}

var patient = {
    id: "123", hasType: "123",
    subjectOf: [ cond_pmOsteo, cond_osteoBoneFracture ],
    gender: 'female',
    policyHolderOf: [], // Coverage*
    exists: true
}

var practitioner = {
    id: "123", hasType: "123",
    exists: true
}

exports.request = {
    id: "123", hasType: "123",
    patient: patient,
    pmOsteo: dummy_condition,
    osteoBoneFracture: dummy_condition,
    provider: practitioner,
    purpose: "validation",
    item: [{ // MedicationRequest*
        id: "123", hasType: "123",
        reason: cond_pmOsteo,
        subject: dummy_patient,
        medication: [{ // Medication*
            id: "123", hasType: "123",
            concept: 398823001,
            exists: true
        }],
        exists: true
    }],
    osteoDrugItem: dummy_medReq,
    response: dummy_response,
    exists: true
}