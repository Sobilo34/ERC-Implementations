// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

interface IERC721 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function tokenURI(uint256 _tokenId) external view returns (string memory);
    function balanceOf(address _owner) external view returns (uint256);
    function ownerOf(uint256 _tokenId) external view returns (address);
    // function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable;
    // function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
    function approve(address _approved, uint256 _tokenId) external payable;
    function setApprovalForAll(address _operator, bool _approved) external;
    function getApproved(uint256 _tokenId) external view returns (address);
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
    function mint(address _to) external returns (uint256);

}

contract ERC721 is IERC721 {
    // create token ids for our nfts
    // track the owners of the nfts
    // track the nfts
    // approve a third party to have authority over an individual nft belonging to an address
    // approve a third party to have authority over all nfts belonging to an address
    // transfer
    // mint
g
    string public name;
    string public symbol;

    uint256 token_count; //1,2,3,4,5,6
    mapping(uint256 => address) public owners; //1 => 0x1, 2 => 0x1, 3 => 0x1, 4 => 0x2

    mapping(address => uint256) public balances; // 7,3,8,9,2 (0x1 => 5)
    mapping(uint256 => address) public approved;

    mapping(address => mapping(address => bool)) is_approved_for_all;

    string public constant baseURL = "https://azure-electric-parakeet-827.mypinata.cloud/ipfs/bafybeidft2wvw2rsdtgwwsmkqijs5lrvwgypgdkkvij6vdqwyr5bynddmy/";


    constructor (string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function balanceOf(address _owner) external view returns (uint256) {
        return balances[_owner];
    }

    function ownerOf(uint256 _tokenId) external view returns (address) {
        return owners[_tokenId];
    }

    function approve(address _approved, uint256 _tokenId) external payable {
        require(owners[_tokenId] == msg.sender, "UNAUTHORIZED");
        approved[_tokenId] = _approved;
    }

    function getApproved(uint256 _tokenId) external view returns (address) {
        return approved[_tokenId];
    }

    function setApprovalForAll(address _operator, bool _approved) external {
        is_approved_for_all[msg.sender][_operator] = _approved;
    }

    function isApprovedForAll(address _owner, address _operator) external view returns (bool) {
        return is_approved_for_all[_owner][_operator];
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
        // owner of token and third party can call this function -----
        // if its the owner, we should check that the from == msg.sender...allow
        // but if from address is not equal to the msg.sender, check if this third has either approval or approvedforaLL
        // reset approved

        require(_to != address(0), "ADDRESS ZERO NOT ALLOWED");
        require(_from != address(0), "ADDRESS ZERO NOT ALLOWED");


        if (msg.sender == _from && msg.sender == owners[_tokenId]) {
            owners[_tokenId] = _to;
            balances[msg.sender] -= 1;
            balances[_to] += 1;
        } else if (approved[_tokenId] == msg.sender || is_approved_for_all[_from][msg.sender] == true) {

            require(owners[_tokenId] == _from, "Invalid Owner");

            owners[_tokenId] = _to;
            balances[_from] -= 1;
            balances[_to] += 1;
            approved[_tokenId] = address(0);
        }

    }

    function tokenURI(uint256 _tokenId) external pure returns (string memory) {
        // returns the url or uri to a token's metadata... baseurl + tokenID + .json
        // baseUrl = https://ghjk/
        // tokenID = 1

        // result https://ghjk/1.json

        return string(abi.encodePacked(baseURL, _tokenId, ".json"));
    }

    function mint(address _to) public returns (uint256) {
        require(_to != address(0), "Invalid Address");

        uint256 _tokenId = token_count + 1; // 0 -> 1, 1 -> 2, 2 -> 3
        owners[_tokenId] = _to;
        balances[_to] += 1;

        token_count ++; // 1, 2
    }
}