// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./interfaces/IMedical.sol";
import "hardhat/console.sol";

contract Medical is IMedical {
    string private _nameStore;
    string private _bloodTypeStore;
    address private _patientStore;
    address private _medicalProviderStore;

    function register(string memory _name, string memory _bloodType) external {
        _patientStore = msg.sender;
        _nameStore = _name;
        _bloodTypeStore = _bloodType;
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
        console.log(_patientAddress);
        return ("", "", 0);
    }

    function updateName(string memory _name) external {
        console.log(_name);
    }

    function updateBloodType(string memory _bloodType) external {
        console.log(_bloodType);
    }

    function provideViewingAccess(address _medicalProviderAddress) external {
        console.log(_medicalProviderAddress);
    }

    function isViewingAccessGranted(
        address _patientAddress,
        address _medicalProviderAddress
    ) external view returns (bool) {
        console.log(_patientAddress, _medicalProviderAddress);
        return false;
    }

    // More functions
}
