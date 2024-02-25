let proc = {
    id: "123", hasType: "123",
    status: "completed",
    code: 77465005,
    exists: true
};
let ins = {
    id: "123", hasType: "123",
    insurer: {
        id: "123", hasType: "Medicare",
        exists: true
    },
    class: {
        id: "123", hasType: "PartA",
        exists: true
    },
    exists: true
};
exports.claim = {
    id: "123", hasType: "123",
    procedure: proc,
    insurance: ins,
    exists: true
};


exports.coverage = {
    id: "123", hasType: "123",
    insurer: {
        id: "123", hasType: "Medicare",
        exists: true
    },
    class: {
        id: "123",
        hasType: "PartA",
        exists: true
    },
    status: "active",
    exists: true
};