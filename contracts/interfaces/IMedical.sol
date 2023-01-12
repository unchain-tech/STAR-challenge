// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

interface IMedical {
    // Register medical data as a patient.
    // This medical data must be accessible by the patient's address from the getter function that follows below.
    function register(string memory _name, string memory _bloodType) external;

    // Returns the patient's medical data.
    function getMedicalData(address _patientAddress)
        external
        view
        returns (
            string memory name,
            string memory bloodType,
            uint256 lastUpdatedtime
        );

    // Patients can change their name.
    function updateName(string memory _name) external;

    // Patients can change their blood type.
    function updateBloodType(string memory _bloodType) external;

    // Patients can provide viewing access to their medical data to their medical providers.
    function provideViewingAccess(address _medicalProviderAddress) external;

    // Returns if the medical provider has viewing access or not.
    function isViewingAccessGranted(
        address _patientAddress,
        address _medicalProviderAddress
    ) external view returns (bool);
}
