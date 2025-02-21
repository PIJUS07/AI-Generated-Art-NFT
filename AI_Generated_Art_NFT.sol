pragma solidity ^0.8.0;

// Contract to create AI-generated NFTs with dynamic metadata
contract AIGeneratedNFT {
    // Structure to store NFT details
    struct NFT {
        uint256 id;
        string metadata;
    }
    
    NFT[] public nfts; // Array to store all NFTs
    uint256 public nextId; // Counter for the next NFT ID
    address public owner; // Address of the contract owner

    // Mapping to store NFT ownership
    mapping(uint256 => address) public nftOwners;
    // Mapping to store NFT metadata
    mapping(uint256 => string) public nftMetadata;

    // Modifier to restrict function access to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not contract owner");
        _;
    }

    // Constructor to set the contract deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    // Function to mint a new NFT
    function mintNFT(string memory _metadata) public onlyOwner {
        nfts.push(NFT(nextId, _metadata)); // Store NFT details
        nftOwners[nextId] = msg.sender; // Assign ownership
        nftMetadata[nextId] = _metadata; // Store metadata
        nextId++; // Increment NFT ID counter
    }

    // Function to update NFT metadata
    function updateMetadata(uint256 _id, string memory _newMetadata) public onlyOwner {
        require(nftOwners[_id] == msg.sender, "Not the owner of this NFT");
        nftMetadata[_id] = _newMetadata; // Update metadata
    }

    // Function to retrieve NFT metadata
    function getNFT(uint256 _id) public view returns (string memory) {
        return nftMetadata[_id];
    }
}
