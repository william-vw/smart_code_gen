// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;pragma abicoder v2;



contract case1 {

	constructor() {}
	
	
	event ContractResponse(CoverageEligibilityResponse evt);
	event OracleRequest(RequestData request);
	
	
	struct CoverageEligibilityRequest {
		string purpose;
		string id;
		string hasType;
		MedicationRequest[] item;
		MedicationRequest immunoTherapyItem;
		Patient patient;
		CoverageEligibilityResponse response;
		bool exists;
	}
	
	struct MedicationRequest {
		string id;
		string hasType;
		Medication[] medication;
		Procedure eligibleTransplant;
		bool exists;
	}
	
	struct Medication {
		string id;
		string hasType;
		string concept;
		bool exists;
	}
	
	struct Procedure {
		string id;
		string hasType;
		string status;
		int code;
		bool exists;
	}
	
	struct Patient {
		string id;
		string hasType;
		Claim[] subjectOf;
		Coverage[] policyHolderOf;
		bool exists;
	}
	
	struct Claim {
		string id;
		string hasType;
		Procedure procedure;
		Insurance insurance;
		bool exists;
	}
	
	struct Insurance {
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
	
	struct Coverage {
		string id;
		string hasType;
		Insurer insurer;
		Class class;
		string status;
		bool exists;
	}
	
	struct CoverageEligibilityResponse {
		string id;
		string hasType;
		string outcome;
		MedicationRequest request;
		Coverage covered;
		Patient patient;
		bool exists;
	}
	
	struct RequestData {
		CoverageEligibilityRequest req;
		string resource;
		string[2] parameters;
		string callback;
	}
	
	
	function check0(CoverageEligibilityRequest memory req, Medication[] memory medications) private pure returns (bool) {
		for (uint i = 0; i < medications.length; i++) {
			Medication memory v1 = medications[i];
			if (keccak256(abi.encodePacked(v1.concept)) == keccak256("DBCAT005063")) {
			
				return true;
			}
		}
		return false;
	}
	
	function process(CoverageEligibilityRequest memory req) public {
		if (req.item.length > 0
			&& keccak256(abi.encodePacked(req.purpose)) == keccak256("validation")) {
		
			for (uint i = 0; i < req.item.length; i++) {
				MedicationRequest memory v0 = req.item[i];
				if (v0.medication.length > 0
					&& check0(req, v0.medication)) {
				
					req.immunoTherapyItem = v0;
				}
			}
		}
		
		if (req.patient.exists
			&& req.immunoTherapyItem.exists) {
		
			emit OracleRequest(RequestData({ req: req, resource: "Claim", parameters: [ "subject", req.patient.id ], callback: "callback1" }));
		}
	}
	
	function callback1(CoverageEligibilityRequest memory req, Claim[] memory results) public {
		for (uint i = 0; i < results.length; i++) {
			Claim memory v2 = results[i];
			if (v2.insurance.exists
				&& keccak256(abi.encodePacked(v2.insurance.class.hasType)) == keccak256("PartA")
				&& keccak256(abi.encodePacked(v2.insurance.insurer.hasType)) == keccak256("Medicare")
				&& v2.procedure.exists
				&& v2.procedure.code == 77465005
				&& keccak256(abi.encodePacked(v2.procedure.status)) == keccak256("completed")) {
			
				req.immunoTherapyItem.eligibleTransplant = v2.procedure;
			}
		}
		
		
		if (req.patient.exists
			&& req.immunoTherapyItem.exists
			&& req.immunoTherapyItem.eligibleTransplant.exists) {
		
			emit OracleRequest(RequestData({ req: req, resource: "Coverage", parameters: [ "policyHolder", req.patient.id ], callback: "callback2" }));
		}
	}
	
	function callback2(CoverageEligibilityRequest memory req, Coverage[] memory results) public {
		for (uint i = 0; i < results.length; i++) {
			Coverage memory v3 = results[i];
			if (v3.class.exists
				&& (keccak256(abi.encodePacked(v3.class.hasType)) == keccak256("PartB")
				|| keccak256(abi.encodePacked(v3.class.hasType)) == keccak256("PartD"))
				&& keccak256(abi.encodePacked(v3.insurer.hasType)) == keccak256("Medicare")) {
			
				CoverageEligibilityResponse memory v4 = CoverageEligibilityResponse({ id: "123", hasType: "123", outcome: "complete", request: req.immunoTherapyItem, covered: v3, patient: req.patient, exists: true });
				req.response = v4;
				emit ContractResponse(v4);
			}
		}
	}
	
	
}