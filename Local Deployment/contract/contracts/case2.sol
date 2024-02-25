// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;pragma abicoder v2;



contract case2 {

	constructor() {}
	
	
	event ContractResponse(CoverageEligibilityResponse evt);
	event OracleRequest(RequestData request);
	
	
	struct CoverageEligibilityRequest {
		string id;
		string status;
		string hasType;
		Patient patient;
		string purpose;
		Condition immuneDeficiencyDisease;
		Practitioner provider;
		MedicationRequest[] item;
		MedicationRequest ivigDrugItem;
		CoverageEligibilityResponse response;
		bool exists;
	}
	
	struct Patient {
		string id;
		string hasType;
		Condition[] subjectOf;
		Coverage[] policyHolderOf;
		bool exists;
	}
	
	struct Condition {
		string id;
		string hasType;
		string clinicalStatus;
		int code;
		bool exists;
	}
	
	struct Practitioner {
		string id;
		string hasType;
		bool exists;
	}
	
	struct MedicationRequest {
		string id;
		string hasType;
		Condition reason;
		Patient subject;
		Medication[] medication;
		Dosage[] dosageInstruction;
		bool exists;
	}
	
	struct Medication {
		string id;
		string hasType;
		int concept;
		bool exists;
	}
	
	struct Dosage {
		string id;
		string hasType;
		int route;
		Practitioner[] requester;
		Patient[] performer;
		int method;
		bool exists;
	}
	
	struct Coverage {
		string id;
		string hasType;
		Insurer insurer;
		Class class;
		bool exists;
	}
	
	struct Insurer {
		string id;
		string hasType;
		bool exists;
	}
	
	struct Class {
		string id;
		string hasType;
		bool exists;
	}
	
	struct CoverageEligibilityResponse {
		string id;
		string hasType;
		string outcome;
		MedicationRequest request;
		Patient patient;
		Coverage covered;
		bool exists;
	}
	
	struct RequestData {
		CoverageEligibilityRequest req;
		string resource;
		string[2] parameters;
		string callback;
	}
	
	
	function check0(CoverageEligibilityRequest memory req, Dosage[] memory dosageInstructions) private pure returns (bool) {
		for (uint i = 0; i < dosageInstructions.length; i++) {
			Dosage memory v2 = dosageInstructions[i];
			if (v2.method == 385985008
					&& v2.performer.length > 0
					&& v2.requester.length > 0
					&& v2.route == 255560000) {
			
				return true;
			}
		}
		return false;
	}
	
	function check1(CoverageEligibilityRequest memory req, Medication[] memory medications) private pure returns (bool) {
		for (uint i = 0; i < medications.length; i++) {
			Medication memory v5 = medications[i];
			if (v5.concept == 243196004) {
			
				return true;
			}
		}
		return false;
	}
	
	function check2(CoverageEligibilityRequest memory req, MedicationRequest[] memory items) private pure returns (bool) {
		for (uint i = 0; i < items.length; i++) {
			MedicationRequest memory v6 = items[i];
			if (keccak256(abi.encodePacked(v6.id)) == keccak256(abi.encodePacked(req.ivigDrugItem.id))) {
			
				return true;
			}
		}
		return false;
	}
	
	function process(CoverageEligibilityRequest memory req) public {
		if (keccak256(abi.encodePacked(req.purpose)) == keccak256("validation")
			&& req.patient.exists
			&& req.patient.subjectOf.length > 0
			&& keccak256(abi.encodePacked(req.status)) == keccak256("active")) {
		
			for (uint i = 0; i < req.patient.subjectOf.length; i++) {
				Condition memory v0 = req.patient.subjectOf[i];
				if (v0.code == 58606001
					&& keccak256(abi.encodePacked(v0.clinicalStatus)) == keccak256("active")) {
				
					req.immuneDeficiencyDisease = v0;
				}
			}
		}
		
		if (req.immuneDeficiencyDisease.exists
			&& req.item.length > 0
			&& req.provider.exists
			&& req.patient.exists) {
		
			for (uint i = 0; i < req.item.length; i++) {
				MedicationRequest memory v1 = req.item[i];
				if (v1.dosageInstruction.length > 0
					&& check0(req, v1.dosageInstruction)
					&& v1.medication.length > 0
					&& check1(req, v1.medication)
					&& v1.subject.exists
					&& v1.reason.exists
					&& keccak256(abi.encodePacked(v1.reason.id)) == keccak256(abi.encodePacked(req.immuneDeficiencyDisease.id))) {
				
					req.ivigDrugItem = v1;
				}
			}
		}
		
		if (req.ivigDrugItem.exists
			&& req.item.length > 0
			&& check2(req, req.item)
			&& req.patient.exists) {
		
			emit OracleRequest(RequestData({ req: req, resource: "Coverage", parameters: [ "policyHolder", req.patient.id ], callback: "callback3" }));
		}
	}
	
	function callback3(CoverageEligibilityRequest memory req, Coverage[] memory results) public {
		for (uint i = 0; i < results.length; i++) {
			Coverage memory v7 = results[i];
			if (keccak256(abi.encodePacked(v7.class.hasType)) == keccak256("PartB")
				&& keccak256(abi.encodePacked(v7.insurer.hasType)) == keccak256("Medicare")) {
			
				CoverageEligibilityResponse memory v8 = CoverageEligibilityResponse({ id: "123", hasType: "123", outcome: "complete", request: req.ivigDrugItem, patient: req.patient, covered: v7, exists: true });
				req.response = v8;
				emit ContractResponse(v8);
			}
		}
	}
	
	
}