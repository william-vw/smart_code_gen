// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;pragma abicoder v2;



contract case3 {

	constructor() {}
	
	
	event ContractResponse(CoverageEligibilityResponse evt);
	event OracleRequest(RequestData request);
	
	
	struct CoverageEligibilityRequest {
		string id;
		string hasType;
		Patient patient;
		Condition pmOsteo;
		Condition osteoBoneFracture;
		Practitioner provider;
		string purpose;
		MedicationRequest[] item;
		MedicationRequest osteoDrugItem;
		CoverageEligibilityResponse response;
		bool exists;
	}
	
	struct Patient {
		string id;
		string hasType;
		Condition[] subjectOf;
		string gender;
		Coverage[] policyHolderOf;
		bool exists;
	}
	
	struct Condition {
		string id;
		string clinicalStatus;
		string hasType;
		int code;
		string verificationStatus;
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
		bool exists;
	}
	
	struct Medication {
		string id;
		string hasType;
		int concept;
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
	
	
	function check0(CoverageEligibilityRequest memory req, Medication[] memory medications) private pure returns (bool) {
		for (uint i = 0; i < medications.length; i++) {
			Medication memory v3 = medications[i];
			if (v3.concept == 398823001) {
			
				return true;
			}
		}
		return false;
	}
	
	function process(CoverageEligibilityRequest memory req) public {
		if (req.patient.exists
			&& req.patient.subjectOf.length > 0) {
		
			for (uint i = 0; i < req.patient.subjectOf.length; i++) {
				Condition memory v0 = req.patient.subjectOf[i];
				if (v0.code == 102447009
					&& keccak256(abi.encodePacked(v0.clinicalStatus)) == keccak256("active")) {
				
					req.pmOsteo = v0;
				}
			}
		}
		
		if (req.patient.exists
			&& req.patient.subjectOf.length > 0) {
		
			for (uint i = 0; i < req.patient.subjectOf.length; i++) {
				Condition memory v1 = req.patient.subjectOf[i];
				if (v1.code == 443165006
					&& keccak256(abi.encodePacked(v1.verificationStatus)) == keccak256("confirmed")
					&& keccak256(abi.encodePacked(v1.clinicalStatus)) == keccak256("active")) {
				
					req.osteoBoneFracture = v1;
				}
			}
		}
		
		if (req.item.length > 0
			&& req.osteoBoneFracture.exists
			&& req.pmOsteo.exists
			&& keccak256(abi.encodePacked(req.purpose)) == keccak256("validation")
			&& req.provider.exists
			&& req.patient.exists) {
		
			for (uint i = 0; i < req.item.length; i++) {
				MedicationRequest memory v2 = req.item[i];
				if (v2.medication.length > 0
					&& check0(req, v2.medication)
					&& v2.subject.exists
					&& keccak256(abi.encodePacked(v2.subject.gender)) == keccak256("female")
					&& v2.reason.exists
					&& keccak256(abi.encodePacked(req.pmOsteo.id)) == keccak256(abi.encodePacked(v2.reason.id))
					&& keccak256(abi.encodePacked(req.patient.id)) == keccak256(abi.encodePacked(v2.subject.id))) {
				
					req.osteoDrugItem = v2;
				}
			}
		}
		
		if (req.patient.exists
			&& req.osteoDrugItem.exists) {
		
			emit OracleRequest(RequestData({ req: req, resource: "Coverage", parameters: [ "policyHolder", req.patient.id ], callback: "callback1" }));
		}
	}
	
	function callback1(CoverageEligibilityRequest memory req, Coverage[] memory results) public {
		for (uint i = 0; i < results.length; i++) {
			Coverage memory v4 = results[i];
			if (v4.class.exists
				&& (keccak256(abi.encodePacked(v4.class.hasType)) == keccak256("PartB")
				|| keccak256(abi.encodePacked(v4.class.hasType)) == keccak256("HomeHealthBenefit"))
				&& keccak256(abi.encodePacked(v4.insurer.hasType)) == keccak256("Medicare")) {
			
				CoverageEligibilityResponse memory v5 = CoverageEligibilityResponse({ id: "123", hasType: "123", outcome: "complete", request: req.osteoDrugItem, patient: req.patient, covered: v4, exists: true });
				req.response = v5;
				emit ContractResponse(v5);
			}
		}
	}
	
	
}