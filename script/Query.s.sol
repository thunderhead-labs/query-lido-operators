// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/mock/NodeOperatorsRegistry.sol";
import "forge-std/console.sol";
import "forge-std/Test.sol";

contract Query is Test {
    uint256 public number;
        

    function run() public {
        NodeOperatorsRegistry registry = NodeOperatorsRegistry(0x9D4AF1Ee19Dad8857db3a45B0374c81c8A1C6320);
        
        uint256[] memory ids = registry.getNodeOperatorIds(0,1000000);

        string memory name;

        bytes memory pks;
        bytes memory signature;
        bool[] memory used;
        uint256 offset = 100000000;
        bytes32 pk;
        bytes memory firstpk;
        uint256 keycount;
        // for (uint i = 0; i < ids.length; i++) {
        for (uint i = 0; i < ids.length; i++) {

            (,name,,,,,) = registry.getNodeOperator(ids[i],true);


            keycount = registry.getTotalSigningKeyCount(ids[i]);
            if (keycount == 0) {
                continue;
            }
            
            string memory filename = name;
            filename = string(abi.encodePacked("data/",filename));
            filename = string(abi.encodePacked(filename," "));
            filename = string(abi.encodePacked(filename, vm.toString(ids[i])));
            console.log("filename: ", filename);

            (pks,signature,used) = registry.getSigningKeys(ids[i],0,keycount);
            vm.writeFile(filename, string(abi.encodePacked( vm.toString(keycount), " validator public keys\n")));

            uint256 numChunks = pks.length / 48; // Calculate the number of chunks
            console.log("number of byte chunks, number of keys. should equal", numChunks,keycount);

            for (uint256 j = 0; j < numChunks; j++) {
                bytes memory chunk = bytes(abi.encodePacked(bytes1(pks[j*48]),bytes1(pks[j*48+1])));
                for (uint256 k = 2; k < 48; k++) {
                    chunk = abi.encodePacked(chunk, pks[j*48+k]);
                }
                vm.writeLine(filename, vm.toString(chunk));
                // vm.writeFile(string(abi.encodePacked("data/",vm.toString(chunk))),"");
            }
        
        }
    }

}
