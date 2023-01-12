// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./interfaces/IGovernment.sol";

contract Government is IGovernment {
    address private _candidate;
    address private _voter;
    address private _president;
    uint256 private _numOfVotes;

    function runForCandidate() external {
        _candidate = msg.sender;
    }

    function isCandidate(address _verifyAddress) external view returns (bool) {
        if (_candidate == _verifyAddress) {
            return true;
        }
        return false;
    }

    function numberOfVotes(address _candidateAddress)
        external
        view
        returns (uint256)
    {
        if (_candidate == _candidateAddress) {
            return _numOfVotes;
        }
        return 0;
    }

    function vote(address _candidateAddress) external {
        _voter = _candidateAddress;
    }

    function abstain() external {
        _voter = msg.sender;
    }

    function determinePresident() external {
        _president = _candidate;
    }

    function getPresident() external view returns (address) {
        return _president;
    }

    // More functions
}
