// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./IERC20.sol";

contract BlockchainToken is IERC20 {

    string public name;
    string public symbol;
    uint public totalTokenSupply;
    address owner;

    mapping(address userAddress => uint tokenBalance) userBalances;

    event NewTokensMinted(uint);

    modifier OnlyOwner {
        require(msg.sender == owner, "Not Owner");
        _;
    }
    constructor(string memory _name, string memory _symbol, uint _totalSupply){
        name = _name;
        symbol = _symbol;
         owner = msg.sender;
        mint(_totalSupply);
    }

    function totalSupply() external view virtual override returns (uint256){
        return totalTokenSupply;
    }  

    function mint(uint _noOfTokens) public OnlyOwner{
         totalTokenSupply += _noOfTokens;
         userBalances[owner] += _noOfTokens;
         emit NewTokensMinted(_noOfTokens);
         emit Transfer(address(0), msg.sender, _noOfTokens);
    }

    function transfer(address to, uint256 amount) external virtual override returns (bool){
        require(to != address(0), "Zero address not allowed");
        require(userBalances[msg.sender] >= amount ,"Low Balance");
        userBalances[msg.sender] -= amount;
        userBalances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function balanceOf(address account) external override view returns (uint256){
        return userBalances[account];
    }
}