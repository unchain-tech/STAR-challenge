// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./interfaces/IMedical.sol";

contract Medical is IMedical {
    function register(string memory _name, string memory _bloodType) external {
    }

    function updateName(string memory _name) external {
    }

    function updateBloodType(string memory _bloodType) external {
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
    }

    function provideViewingAccess(address _doctorAddress) external {
    }

    function isViewingAccessGranted(
        address _patientAddress,
        address _medicalProviderAddress
    ) external view returns (bool) {
    }
}
