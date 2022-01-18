pragma solidity >=0.4.16 <0.9.0 ; 

contract SimpleContract {
    address government ; 
    mapping (address => Doctor) public doctors ; 
    mapping(address => Patient) public patients;

    constructor() {
            government = 0xfdDb13c3B9366989d3a9ea8E9F841bffC01142eF;
    }
    event addPrescriptionEvent(address doctor_address , address patient_address , string drug_id) ; 
    struct Doctor {
        address doctor_address;
        string name  ; 
        string hospital_name ; 
        string cin; 
        bool isValid ; 
    }

    struct Patient {
        address  patient_address ; 
        string name ; 
        string cin ; 
        string malade_name ; 
    }
    // struct Prescription {
    //     uint prescription_id ; 
    //     address doctor_address ; 
    //     address patient_address ; 
    //     address drug_address;
    // }
 
    function addDoctor(address doctor_address , string memory name, string memory hospital_name ,string memory cin ) public {
            	if(msg.sender == government){
                   doctors[doctor_address] = Doctor(doctor_address , name,  hospital_name , cin , true);
                }
        }

    function addPatient(address patient_address , string memory name ,string memory cin,string memory malade_name ) public {
        patients[patient_address] = Patient(patient_address , name , cin ,  malade_name);
    
    }

    function addPrescription(address patient_address,string memory drug_id) public {
        if(doctors[msg.sender].isValid)
        emit addPrescriptionEvent(msg.sender , patient_address , drug_id);
    }
    

    function getDoctor(address doctor_address) public view returns (Doctor memory ) {
        return doctors[doctor_address];
    }
       function getPatient(address patient_address) public view returns (Patient memory ) {
        return patients[patient_address];
    }
     

}