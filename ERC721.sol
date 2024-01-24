// SPDX-License-Identifier: MIT
 
pragma solidity ^0.8.0;
 
contract ERC721 {
    // TODO: 1. Declare private string Token name to store name of the token
    //---------------------------------------------------------------------------------------------------------------------//
       string private tokenName;
    // TODO: 2. Declare private string Token symbol to store symbol of the token
    //-------------------------------------------------------------------------------------------------------------------//
        string private tokenSymbol;
    // TODO: 3. Create a mapping from token ID to owner address
    //-------------------------------------------------------------------------------------------------------------------//
        mapping (uint256 => address) owners;
    // TODO: 4. Create a mapping owner address to token count
    //-------------------------------------------------------------------------------------------------------------------//
        mapping (address => uint256) balances;
    // TODO: 5. Create a mapping from token ID to approved address
    //-------------------------------------------------------------------------------------------------------------------//
        mapping (uint256 => address) tokenApprovals;
    // TODO: 6. Create a nested mapping from owner to operator approvals
    // Map owner address with map having operator address and boolean for approval
    //-------------------------------------------------------------------------------------------------------------------//
        mapping  (address =>mapping(address => bool)) operatorApprovals;
    // TODO: 7. Create event Approval with owner address, operator address, tokendId indexed as parameters.
    //-------------------------------------------------------------------------------------------------------------------//
    event Approval(address indexed owner, address indexed operator, uint256 indexed tokenId);
    // TODO: 8. Create event ApprovalForAll with owner address and operator address indexed and boolean approved as parameters
    //-------------------------------------------------------------------------------------------------------------------//
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    // TODO: 9. Create event Transfer with from address, to address and tokenId indexed as parameters.
    //-------------------------------------------------------------------------------------------------------------------//
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    // TODO: 10. Create a constructor which takes a name and symbol as parameters
    //and initialize it.
    //-------------------------------------------------------------------------------------------------------------------//
    constructor(string memory _name, string memory _symbol){
        tokenName = _name;
        tokenSymbol = _symbol;
    }
    // TODO: 11. Write a function named balanceOf which takes address as a parameter
    // and returns the balance of that address
    //king:
    //      1. Check owner address is not zero address.
    //------------------------------------------------------------------------------------------------------------------------//
    function balanceOf(address owner) external view returns(uint256){
        require(owner != address(0), "Invalid address");
        return balances[owner];
    }
    // TODO: 12. Write a function named ownerOf which takes the tokenId as parameter and returns the owner of that token
    // Check the return address is not zero address revert with error invalid tokenId if address if zero address.
    //-------------------------------------------------------------------------------------------------------------------//
    function ownerOf(uint256 tokenId) public  view returns(address){
        require(owners[tokenId] != address(0));
        return owners[tokenId];
    }
    // TODO: 13. Write a function name() which returns the name of the token
    //-------------------------------------------------------------------------------------------------------------------//
    function name() external view returns(string memory){
        return tokenName;
    }
    // TODO: 14. Write a function symbol() which returns the symbol of the token
    //-------------------------------------------------------------------------------------------------------------------//
    function symbol() external view returns(string memory){
        return tokenSymbol;
    }
    // TODO: 15. Write a function approve with the parameters spender address and tokenId
    // Check:
    // 1. spender address and owner address are not same.
    //      2. caller is owner or approved as spender for that token(isApprovedForAll)
    // Add the spender to the tokendApprovals mapping for tokenId passed as parameter.
    // Emit the approval event using required parameters
    //------------------------------------------------------------------------------------------------------------------------//
    function approve(address spender, uint256 tokenId) external{
         address owner = owners[tokenId];
    require(spender != owner, "Approval to self is not allowed");
    require(isApprovedOrOwner(msg.sender, tokenId), "Not authorized to approve");
    tokenApprovals[tokenId] = spender;
    emit Approval(owner, spender, tokenId);
 
    }
    // TODO: 16. Write a function named isApprovedForAll which takes owner address and operator address and returns
    // the operator have approval
    //-------------------------------------------------------------------------------------------------------------------//
    function isApprovedForAll(address owner, address operator) public view returns (bool) {
    return operatorApprovals[owner][operator];
}
    // TODO: 17. Write a function getApproved which takes tokenId as parameter and
    // returns the approved address using tokenApprovals mapping
    //-------------------------------------------------------------------------------------------------------------------//
    function getApproved(uint256 tokenId) external view returns (address) {
    return tokenApprovals[tokenId];
}
    // TODO: 18. Write a function setApprovalForAll which takes owner address, operator address and boolean
    // to indicate the spender is approved.
    //approval using opertorApprovals mapping
    // emit the ApprovalForAll event using required parameters.
    // Checks:
    //      1. Owner address and spender address are not equal.
    //------------------------------------------------------------------------------------------------------------------------//
    function setApprovalForAll(address operator, bool approved) external {
    require(msg.sender != operator, "Approval to self is not allowed");
 
    operatorApprovals[msg.sender][operator] = approved;
    emit ApprovalForAll(msg.sender, operator, approved);
}
    // TODO: 19. Write a function isApprovedOrOwner which takes the spender address and tokenId and
    // returns the boolean is the spender is owner or approved as spender.
    //isApprovedForAll and getApproved functions appropriately
    //------------------------------------------------------------------------------------------------------------------------//
    function isApprovedOrOwner(address spender, uint256 tokenId)public view returns(bool){
         address owner = owners[tokenId];
    return (spender == owner || isApprovedForAll(owner, spender) || tokenApprovals[tokenId] == spender);
 
    }
    // TODO: 20. Write a transfer function which takes to and from address and tokenId
    // Checks:
    // 1. Is the spender is owner or approved as spender using isApprovedOrOwner function
    //      2. Check the from address and token owner address are equal using ownerOf function
    //      3. Check to address is not zero address.
    // Clear the approvals from previous owners using delete keyword and token approvals mapping
    // Reduce the balance of the previous owner and increase the balance of new owner
    // Change the ownership in owners mapping to new owner.
    // Emit the Transfer event with required parameters.
    //------------------------------------------------------------------------------------------------------------------------//
   
 
   function transfer(address from, address to, uint256 tokenId) external {
    require(isApprovedOrOwner(msg.sender, tokenId), "Not authorized to transfer");
    require(ownerOf(tokenId) == from, "Token not owned by sender");
    require(to != address(0), "Invalid recipient address");
 
    delete tokenApprovals[tokenId];
    balances[from]--;
    balances[to]++;
    owners[tokenId] = to;
 
    emit Transfer(from, to, tokenId);
}
 
    // TODO: 21. Write a function exists which takes tokenId and returns the boolean indicating
    // owner for that token exists or not using ownerOf function.
    //-------------------------------------------------------------------------------------------------------------------//
    function exists(uint256 tokenId) public  view returns (bool) {
    return ownerOf(tokenId) != address(0);
}
    // TODO: 22. Write a function named mint to mint a new Token. Take address for which token is to be minted and id of the token.
    // Checks
    // 1. to address is not zero address
    //      2. Check tokenId already exists or not using exists function.
    // Increment the balance of the to address
    // Bind tokenId with new owner in owners mapping
    // emit Transfer event with required parameters.
    //------------------------------------------------------------------------------------------------------------------------//
    function mint(address owner, uint256 tokenId) external {
    require(owner != address(0), "Invalid recipient address");
    require(!exists(tokenId), "Token already exists");
 
    balances[owner]++;
    owners[tokenId] = owner;
 
    emit Transfer(address(0), owner, tokenId);
}
 
    // TODO: 23. Write a function burn which will take tokenId as a parameter
    // Clear all the approvals for that token using delete keyword with tokenApprovals mapping
    //ce the balance of the owner
    // Clear token with owner mapping entry for that token using delete keyword.
    // Emit the Transfer event with required parameters.
    function burn(uint256 tokenId) external {
    address owner = ownerOf(tokenId);
 
    delete tokenApprovals[tokenId];
    balances[owner]--;
    delete owners[tokenId];
 
    emit Transfer(owner, address(0), tokenId);
}
 
}