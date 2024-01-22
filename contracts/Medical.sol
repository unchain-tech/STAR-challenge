// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;
import "hardhat/console.sol";
import "./interfaces/IMedical.sol";

contract Medical is IMedical {
    //受診者データの構造体を作成
    struct Patient {
        address ownerAddress; //構造体の作成者(本人であることを判定する)
        string name; //名前
        string bloodType; //血液型
        uint256 lastUpdate; //最終更新日
        address doctorAddress; //担当医師のアドレス
        uint256 id; //ID
    }

    //医師データの構造体を作成
    struct Doctor {
        address ownerAddress; //構造体の作成者(本人であることを判定する)
        string name; //名前
        uint256 id; //ID
    }

    uint256 private _patientId = 1; //受診者のID
    uint256 private _doctorId = 1; //医師のID

    Patient[] public patients;
    Doctor[] public doctors;

    mapping(address => uint256) private _patientAddressToId; //受診者のオーナーアドレスからIDをマッピング
    mapping(uint256 => address) private _idToDoctorAddress; //IDから医師のアドレスをマッピング
    mapping(address => uint256) private _doctorAddressToId; //医師のオーナーアドレスからIDをマッピング
    mapping(address => string) private _doctorAddressToName; //医師のオーナーアドレスから名前をマッピング

    function register(string memory _name, string memory _bloodType) external {
        require(_patientAddressToId[msg.sender] == 0, "already exist."); //未作成時のみ実行可能
        address _initialAddress; //医師の初期値アドレス
        Patient memory _newPatient = Patient(
            msg.sender,
            _name,
            _bloodType,
            block.timestamp,
            _initialAddress,
            _patientId
        );
        patients.push(_newPatient);
        _patientAddressToId[msg.sender] = _patientId;
        _patientId++;
    }

    function updateName(string memory _name) external {
        require(_patientAddressToId[msg.sender] > 0, "not registered yet");
        uint256 _ownerId = _patientAddressToId[msg.sender] - 1;
        patients[_ownerId].name = _name;
        patients[_ownerId].lastUpdate = block.timestamp;
    }

    function updateBloodType(string memory _bloodType) external {
        require(_patientAddressToId[msg.sender] > 0, "not registered yet");
        uint256 _ownerId = _patientAddressToId[msg.sender] - 1;
        patients[_ownerId].bloodType = _bloodType;
        patients[_ownerId].lastUpdate = block.timestamp;
    }

    // 医師の登録も実装されている
    function updateDoctorInfo(address _doctorAddress, string memory _name)
        external
    {
        require(_doctorAddressToId[_doctorAddress] == 0, "already exist."); //未作成時のみ実行可能
        Doctor memory _newDoctor = Doctor(_doctorAddress, _name, _doctorId);
        doctors.push(_newDoctor);
        _doctorAddressToId[_doctorAddress] = _doctorId;
        _doctorId++;
        _doctorAddressToName[_doctorAddress] = _name; //医師の名前をマッピングで登録
    }

    function getMedicalData(address _patientAddress)
        external
        view
        returns (
            string memory name,
            string memory bloodType,
            uint256 lastUpdatedtime
        )
    {
        require(_patientAddressToId[_patientAddress] > 0, "not registered yet");
        uint256 _ownerId = _patientAddressToId[_patientAddress] - 1;
        require(
            patients[_ownerId].doctorAddress == msg.sender ||
                patients[_ownerId].ownerAddress == msg.sender,
            "not owner or doctor"
        );
        return (
            patients[_ownerId].name,
            patients[_ownerId].bloodType,
            patients[_ownerId].lastUpdate
        );
    }

    function provideViewingAccess(address _doctorAddress) external {
        require(_patientAddressToId[msg.sender] > 0, "not registered yet");
        uint256 _ownerId = _patientAddressToId[msg.sender] - 1;
        patients[_ownerId].doctorAddress = _doctorAddress;
        _idToDoctorAddress[_ownerId] = _doctorAddress;
    }

    function isViewingAccessGranted(
        address _patientAddress,
        address _medicalProviderAddress
    ) external view returns (bool) {
        uint256 _ownerId = _patientAddressToId[_patientAddress] - 1;
        return patients[_ownerId].doctorAddress == _medicalProviderAddress;
    }

    //受診者が自分の情報を確認するための関数。
    function viewPatientProfile()
        external
        view
        returns (
            string memory,
            string memory,
            uint256,
            address,
            string memory
        )
    {
        require(_patientAddressToId[msg.sender] > 0, "not registered yet");
        uint256 _ownerId = _patientAddressToId[msg.sender] - 1;
        address _doctorAddress = patients[_ownerId].doctorAddress;
        string memory _doctorName = _doctorAddressToName[_doctorAddress]; //医師の名前をマッピングから取得
        return (
            patients[_ownerId].name,
            patients[_ownerId].bloodType,
            patients[_ownerId].lastUpdate,
            patients[_ownerId].ownerAddress,
            _doctorName
        );
    }

    //医師が自分の情報を確認するための関数。
    function viewDoctorProfile()
        external
        view
        returns (
            string memory,
            uint256,
            address
        )
    {
        require(_doctorAddressToId[msg.sender] > 0, " not registered yet");
        uint256 _ownerId = _doctorAddressToId[msg.sender] - 1;
        return (
            doctors[_ownerId].name,
            _ownerId,
            doctors[_ownerId].ownerAddress
        );
    }

    //受診者が医師を削除するための関数。
    function deleteDoctor() external {
        require(_patientAddressToId[msg.sender] > 0, "Y not registered yet");
        uint256 _ownerId = _patientAddressToId[msg.sender] - 1;
        address _initialAddress; //医師の初期値アドレス
        patients[_ownerId].doctorAddress = _initialAddress;
        _idToDoctorAddress[_ownerId] = _initialAddress;
    }

    //医師に紐づく受診者を取得
    function viewClientsList() external view returns (Patient[] memory) {
        uint256 count = 0;
        for (uint256 i = 0; i < patients.length; i++) {
            if (_idToDoctorAddress[i] == msg.sender) {
                count++;
            }
        }
        Patient[] memory result = new Patient[](count);
        for (uint256 i = 0; i < patients.length; i++) {
            if (_idToDoctorAddress[i] == msg.sender) {
                result[i] = patients[i];
            }
        }
        return result;
    }

    //医師全員を取得
    function viewAllDoctors() external view returns (Doctor[] memory) {
        return doctors;
    }
}
