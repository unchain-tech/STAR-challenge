// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./interfaces/IGovernment.sol";

contract Government is IGovernment {
    address private _candidate;
    address private _voter;
    address private _president;

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
            return 1;
        }
        return 0;
    }

    function vote(address _candidateAddress) external {
        // Revert transaction if the caller have already voted or abstained.
        delete _candidateAddress;
        _voter = msg.sender;
    }

    function abstain() external {
        // Revert transaction if the caller have already voted or abstained.
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
