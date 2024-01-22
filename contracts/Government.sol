// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "hardhat/console.sol";
import "./interfaces/IGovernment.sol";

contract Government is IGovernment {
    // イベント定義
    event NewCandidate(
        address candidate,
        uint256 timestamp,
        uint256 numOfVotes
    );
    event NewVote(address voter, address candidate);

    // 立候補情報の構造体定義
    struct Candidate {
        address candidate; // 立候補者のウォレットアドレス
        uint256 timestamp; // 立候補した瞬間のタイムスタンプ
        uint256 numOfVotes; // 得票数
    }

    Candidate[] private _candidates;

    // 二重立候補の防止
    mapping(address => bool) public isCandidate;

    // 二重投票の防止
    mapping(address => bool) public isVoter;

    constructor() {
        console.log("This is SmartGovernment contract!");
    }

    function runForCandidate() external {
        // 既に立候補済みかどうかを確認
        require(isCandidate[msg.sender] != true, "You already run for!");
        if (startTimeStamp == 0) {
            startTimeStamp = block.timestamp;
            endTimeStamp = startTimeStamp + 2 weeks;
        }
        // 選挙終了時刻以降に立候補の関数を呼び出した場合はエラー処理
        if (startTimeStamp != 0) {
            require(
                endTimeStamp > block.timestamp,
                "You are too late to run for!"
            );
        }
        // 立候補フラグを建てる
        isCandidate[msg.sender] = true;
        // 配列に立候補情報を格納
        _candidates.push(Candidate(msg.sender, block.timestamp, 0));
        // フロントエンド側に新たな立候補情報を通知
        emit NewCandidate(msg.sender, block.timestamp, 0);
    }

    // 立候補の内容をすべて取得する関数
    function getAllCandidates() public view returns (Candidate[] memory) {
        return _candidates;
    }

    // 開始時間の取得
    uint256 public startTimeStamp;

    // 終了時間の取得
    uint256 public endTimeStamp;

    function vote(address _candidateAddress) external {
        uint256 candidateid;
        for (uint256 index = 0; index < _candidates.length; index++) {
            if (_candidateAddress == _candidates[index].candidate) {
                candidateid = index;
            }
        }
        // 立候補者は投票できないよう制限
        require(isCandidate[msg.sender] != true, "Candidates can't vote!");
        // 既に投票もしくは棄権した場合は投票できないよう制限
        require(isVoter[msg.sender] != true, "You already vote or abstain!");
        if (startTimeStamp != 0) {
            require(
                endTimeStamp > block.timestamp,
                "You are too late to vote!"
            );
        }
        // 投票者・棄権者フラグを建てる
        isVoter[msg.sender] = true;
        // 投票された立候補者の得票数を1増やす
        _candidates[candidateid].numOfVotes += 1;
        // フロントエンド側に新たな投票情報を通知
        emit NewVote(msg.sender, _candidates[candidateid].candidate);
    }

    // 棄権する関数
    function abstain() external {
        // 既に投票もしくは棄権した場合は棄権できないよう制限
        require(isVoter[msg.sender] != true, "You already vote or abstain!");
        if (startTimeStamp != 0) {
            require(
                endTimeStamp > block.timestamp,
                "You are too late to vote!"
            );
        }
        isVoter[msg.sender] = true;
    }

    address private _winner;

    // 新会長を選出する関数
    function determinePresident() external {
        require(endTimeStamp <= block.timestamp, "not yet timestamp!");
        uint256 chairmanIndex;
        // 全立候補者のうち、最も得票数の多い立候補者のNoを探索
        require(_candidates.length > 0, "There are no _candidates yet");
        for (uint256 i; i < _candidates.length - 1; i++) {
            (_candidates[chairmanIndex].numOfVotes >
                _candidates[i + 1].numOfVotes
                ? chairmanIndex = i
                : chairmanIndex = i + 1);
        }
        _winner = _candidates[chairmanIndex].candidate;
    }

    function getPresident() external view returns (address) {
        return _winner;
    }

    function numberOfVotes(
        address _candidateAddress
    ) external view returns (uint256) {
        for (uint256 i = 0; i < _candidates.length; i++) {
            if (_candidates[i].candidate == _candidateAddress) {
                return _candidates[i].numOfVotes;
            }
        }
        return 0;
    }
}
