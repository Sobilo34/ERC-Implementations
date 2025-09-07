// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract ERC_721_Standard {
    string public name;
    string public symbol;
    mapping(uint => address) public tokenIdToOwner;
    mapping(address => uint) public ownerToBalance;
    mapping(uint => address) public approvedAddresses;
    mapping (address => mapping(address => bool)) public operatorApprovals;

    event Transfer(address indexed from, address indexed to, uint indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    error INVALID_ADDRESS();
    error INVALID_TOKEN_ID();

    constructor(string memory _name, string memory _symbol) {
        name =  _name;
        symbol = _symbol;
    }

    function balanceOf(address owner) public view return(uint) {
        if (owner == address(0)) {
            revert INVALID_ADDRESS();
        }
        return ownerToBalance[owner];
    }

    function ownerOf(uint tokenId) public view return (address) {
        if (tokenIdToOwner[tokenId] == address(0) [
            revert INVALID_TOKEN_ID();
        ])
        return tokenIdToOwner[tokenId]
    }

    function trasferFrom(address _from, address _to, uint _tokeId) public {
        
    }
}