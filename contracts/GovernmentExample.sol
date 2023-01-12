// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./interfaces/IGovernment.sol";

contract Government is IGovernment {
    function runForCandidate() external {
    }

    function vote(address _candidateAddress) external {
    }

    function abstain() external {
    }

    function determinePresident() external {
    }

    function getPresident() external view returns (address) {
    }

    function numberOfVotes(address _candidateAddress)
        external
        view
        returns (uint256)
    {
    }
}
