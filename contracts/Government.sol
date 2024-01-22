// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./interfaces/IGovernment.sol";
import "hardhat/console.sol";

contract Government is IGovernment {
    address private _candidate;
    address private _voter;
    address private _president;

    function runForCandidate() external {
        _candidate = msg.sender;
        // finish the function
    }

    function isCandidate(address _someAddress) external view returns (bool) {
        // finish the function
        return false;
    }

    function numberOfVotes(address _candidateAddress)
        external
        view
        returns (uint256)
    {
        console.log(_candidateAddress);
        // finish the function
        return 0;
    }

    function vote(address _candidateAddress) external {
        console.log(_candidateAddress);
        // finish function
    }

    function abstain() external {
        // finish function
    }

    function determinePresident() external {
        // finish function
    }

    function getPresident() external view returns (address) {
        return _president;
    }

    // More functions
}
