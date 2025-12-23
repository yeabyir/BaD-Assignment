// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataTypeExperiment {
    // State variables (stored on blockchain)
    uint256 public storedNumber = 10;
    int256 public signedNumber = -5;
    bool public isReady = true;
    address public owner;
    string public message = "Hello Solidity";

    constructor() {
        owner = msg.sender;
    }

    // Operates on uint
    function incrementStoredNumber(uint256 _value) public {
        storedNumber += _value;
    }

    // Operates on int
    function flipSignedNumber() public {
        signedNumber = -signedNumber;
    }

    // Operates on bool
    function toggleReady() public {
        isReady = !isReady;
    }

    // Demonstrates local variable
    function localCalculation(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 result = a + b; // local variable
        return result;
    }

    // Operates on string
    function updateMessage(string memory _newMessage) public {
        message = _newMessage;
    }
}
