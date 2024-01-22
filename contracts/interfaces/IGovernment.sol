// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

interface IGovernment {
    // A citizen can run for candidate.
    function runForCandidate() external;

    // Returns whether the address passed in the argument is a candidate or not.
    function isCandidate(address _verifyAddress) external view returns (bool);

    // Returns the number of votes for the candidate passed in the argument.
    function numberOfVotes(
        address _candidateAddress
    ) external view returns (uint256);

    // A citizen can vote to candidate.
    // ATTENTION: Revert transaction if the caller have already voted or abstained.
    function vote(address _candidateAddress) external;

    // A citizen can abstain.
    // ATTENTION: Revert transaction if the caller have already voted or abstained.
    function abstain() external;

    // Anyone can determine the president after the end of the election period.
    function determinePresident() external;

    // Returns the president's addres if the president had been determined.
    function getPresident() external view returns (address);
}
