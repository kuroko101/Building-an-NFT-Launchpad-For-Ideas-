pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTLaunchpad is ERC721, Ownable {
    uint public constant NFT_PRICE = 1 ether; // Price of each NFT
    
    struct NFT {
        uint id;
        string name;
        string description;
        string imageUrl;
        address payable owner;
        bool forSale;
    }

    NFT[] public nfts;

    event NewNFT(uint nftId, string name, string description, string imageUrl, address payable owner, bool forSale);

    constructor() ERC721("NFTLaunchpad", "NFTP") {}

    // Create a new NFT
    function createNFT(string memory _name, string memory _description, string memory _imageUrl) public payable {
        require(msg.value == NFT_PRICE, "Invalid payment amount");
        uint id = nfts.length;
        nfts.push(NFT(id, _name, _description, _imageUrl, payable(msg.sender), true));
        emit NewNFT(id, _name, _description, _imageUrl, payable(msg.sender), true);
    }

    // Buy an NFT
    function buyNFT(uint _id) public payable {
        NFT storage nft = nfts[_id];
        require(nft.forSale, "NFT is not for sale");
        require(msg.value == NFT_PRICE, "Invalid payment amount");
        address payable previousOwner = nft.owner;
        nft.owner = payable(msg.sender);
        nft.forSale = false;
        previousOwner.transfer(msg.value);
        emit Transfer(previousOwner, nft.owner, _id);
    }

    // Transfer ownership of an NFT
    function transferNFT(address _to, uint _id) public {
        require(ownerOf(_id) == msg.sender, "You are not the owner of this NFT");
        safeTransferFrom(msg.sender, _to, _id, "");
        NFT storage nft = nfts[_id];
        nft.owner = payable(_to);
    }
}