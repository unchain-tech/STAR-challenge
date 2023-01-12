// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./interfaces/IMedical.sol";

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
        if (_patientStore == _patientAddress) {
            return (_nameStore, _bloodTypeStore, 0);
        }
        return ("", "", 0);
    }

    function updateName(string memory _name) external {
        _nameStore = _name;
    }

    function updateBloodType(string memory _bloodType) external {
        _bloodTypeStore = _bloodType;
    }

    function provideViewingAccess(address _medicalProviderAddress) external {
        _medicalProviderStore = _medicalProviderAddress;
    }

    function isViewingAccessGranted(
        address _patientAddress,
        address _medicalProviderAddress
    ) external view returns (bool) {
        if (
            _patientStore == _patientAddress &&
            _medicalProviderStore == _medicalProviderAddress
        ) {
            return true;
        }
        return false;
    }

    // More functions
}
