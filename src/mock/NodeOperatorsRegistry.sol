// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface NodeOperatorsRegistry {
    function getNodeOperatorIds(uint256 _offset, uint256 _limit) external view returns (uint256[] memory);
    function getNodeOperator(uint256 _nodeOperatorId, bool _fullInfo) external view returns (bool, string memory, address, uint64, uint64, uint64, uint64);
    function getSigningKeys(uint256 _nodeOperatorId, uint256 _offset, uint256 _limit) external view returns (bytes memory, bytes memory, bool[] memory);
    function getTotalSigningKeyCount(uint256 _nodeOperatorId) external view returns (uint256);
}

