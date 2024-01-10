**Fundamentals of Solidity**
**Address**
**Address vs Address Payable**
In Solidity, there are two address types: address and address payable. The address type is used for both user addresses and contract addresses, while the **address payable type is specifically used for addresses that can receive Ether**.

pragma solidity ^0.8.0; 

contract helloGeeks { 
	address public userAddress; 
	address payable public recipientAddress; 

	function setAddress(address _userAddress, address payable _recipientAddress) public { 
		userAddress = _userAddress; 
		recipientAddress = _recipientAddress; 
	} 
}

Solidity – Mappings

Mapping in Solidity acts like a hash table or dictionary in any other language. These are used to store the data in the form of key-value pairs, a key can be any of the built-in data types but reference types are not allowed while the value can be of any type. Mappings are mostly used to associate the unique Ethereum address with the associated value type.

Syntax:

mapping(key => value) <access specifier> <name>;
// Solidity program to 
// demonstrate mapping
pragma solidity ^0.4.18; 

// Defining contract 
contract mapping_example {
	
	//Defining structure
	struct student 
	{
		// Declaring different 
		// structure elements
		string name;
		string subject;
		uint8 marks;
	}
	
	// Creating a mapping
	mapping (
	address => student) result;
	address[] public student_result; 
}

Solidity – Functions
The return value of a function is optional but in solidity, the return type of the function is defined at the time of declaration.

function function_name(parameter_list) scope returns(return_type) {
       // block of code
}
Function Visibility Specifier in Solidity
It is like access specifiers in other OOP languages such as C++. The function visibility specifiers define the visibility of the function within the entire smart contract. There are four function visibility specifiers in Solidity: public, internal, external, and private.

1. Public
If the function visibility specifier is public then, the function can be used by all contracts on the blockchain.


pragma solidity ^0.5.0; 

contract A { 
function funpublic () public view returns (uint p) 
{ 
	// This function cna be used by any contract 
	uint p = 10; 
	return p; 
} 
}

2. Private
If the function visibility specifier is private then, the function can be only used by the contract in which the function resides. The external contracts cannot call the private function. These functions can be called by higher specifier functions.

Syntax:

function function_name (parameter list) private modifier returns (return_type)
// Solidity program to implement the 
// private function visibility modifier 

// SPDX-License-Identifier: MIT 
pragma solidity ^0.5.0; 

contract A { 
uint p; 
function funprivate () private
{ 
	//This function can only be used by contract A 
	p = 10; 
} 
function f() public returns (uint) 
{ 
	funprivate(); 
	return p; 
} 
} 

contract B{ 
uint q; 
A a = new A(); 
function fun() public returns(uint) 
{ 
	q = a.f(); 
	return q; 
} 
}

3. Internal
If the function visibility specifier is internal then, the function can be used by the contract in which the function is present or by its inherited contracts. These functions can be called by the inherited contracts only. The other contracts cannot call the internal functions.

Syntax:

function function_name (parameter list) internal modifier returns (return_type)

pragma solidity ^0.5.0; 

contract A { 
public uint p = 10; 
function Functionint ()internal pure returns (uint p) 
{ 
	// This function is internal and can be used 
	// by same contract ir child contract. 
	return p; 
} 
} 

contract B is A{ 
function funint() public returns (uint) 
{ 
	// Internal function of parent 
	return Functionint(); 
} 
} 
contract P{ 
B b = new B(); 
uint a; 
function f() public returns (uint) 
{ 
	a = b.funint(); 
	return a; 
}	 
}

4. External
If the function visibility specifier is external then, the function can be used by the external contracts only. These functions are declared with external keywords which restricts the current contract to call the external function. The external contract does not contain the function it can call the external function in another contract.

Syntax:

function function_name (parameter list) external modifier returns (return_type) 

// Solidity program to implement the 
// external function visibility modifier 

// SPDX-License-Identifier: MIT 
pragma solidity ^0.5.0; 

contract ABC { 
function externalfunction() external pure returns(uint) 
{ 
	// This external function can be used 
	// by any external contract 
	return 10; 
} 
} 

// External contract 
contract P{							 
ABC a = new ABC(); 
function f() public view returns(uint){ 
a.externalfunction(); 
} 
}

Solidity – View and Pure Functions
The view functions are read-only function, which ensures that state variables cannot be modified after calling them. In the below example, the contract Test defines a view function to calculate the product and sum of two unsigned integers.

pragma solidity ^0.5.0;
/// @title A contract for demonstrating view functions
/// @author Jitendra Gangwar
/// @notice For now, this contract defining view function to calculate product and sum of two numbers 
contract Test {
	// Declaring state variables							 
	uint num1 = 2; 
	uint num2 = 4;

function getResult(
) public view returns(
	uint product, uint sum){
	product = num1 * num2;
	sum = num1 + num2; 
}
}



Solidity – Constructors

A constructor is a special method in any object-oriented programming language which gets called whenever an object of a class is initialized. It is totally different in case of Solidity, Solidity provides a constructor declaration inside the smart contract and it invokes only once when the contract is deployed and is used to initialize the contract state. A default constructor is created by the compiler if there is no explicitly defined constructor.

A Constructor is defined using a constructor keyword without any function name followed by an access modifier. It’s an optional function which initializes state variables of the contract. A constructor can be either internal or public, an internal constructor marks contract as abstract. 

Syntax:

constructor() <Access Modifier> {          
} 

// Solidity program to demonstrate 
// creating a constructor
pragma solidity ^0.5.0;	 
		
// Creating a contract
contract constructorExample {	 
		
	// Declaring state variable
	string str;	 
			
	// Creating a constructor 
	// to set value of 'str'
	constructor() public {				 
		str = "GeeksForGeeks";	 
	}	 
	
	// Defining function to 
	// return the value of 'str' 
	function getValue(
	) public view returns (
	string memory) {	 
		return str;	 
	}	 
}

What is Self Destruct?
Self destruct is a built-in function in Solidity that allows you to effectively remove a contract from the blockchain and send its remaining ether to a designated recipient. Therefore, when a contract is destroyed, storage space is freed up in the blockchain as its code and data are removed.

The self destruct function is called using the address of the ether recipient as an argument, like this:

selfdestruct(recipientAddress);
The recipient address will receive all funds held by the contract at the moment of destruction. However, keep in mind that the caller will still have to pay for the gas used to invoke the contract’s self destruct call.

Reference-https://www.infuy.com/blog/using-self-destruct-in-solidity-contracts/#:~:text=Self%20destruct%20is%20a%20built,code%20and%20data%20are%20removed.







