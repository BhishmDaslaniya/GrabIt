/**
 *Submitted for verification at Etherscan.io on 2019-08-22
*/

pragma solidity ^0.5.9;
//pragma experimental ABIEncoderV2;

contract SafeMath {
    function safeAdd(uint a, uint b) public pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function safeSub(uint a, uint b) public pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }
    function safeMul(uint a, uint b) public pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function safeDiv(uint a, uint b) public pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}

contract votingcontract2 is SafeMath {
    
   //Varible Declaration is done Here!    
    bytes32 public symbol;
    bytes32 public  name;
    address public owner;
    uint8 public decimals;
    uint public totalSupply;
    string[] public candidateList;
  
  //Constructor To generate token and to give total supply to the owner  
    constructor() public {
        symbol = "TKFVoteNew"; //Please Change the Name As Per Requirment
        name = "NEW TOKEN FOR VOTING"; //Please Change the Name As Per Requirment
        decimals = 0;
        totalSupply = 10;
        balance[msg.sender] = totalSupply;
        owner = msg.sender;
    }
  
  //Maping of Vote and balance with Address and Bytes32 is done here!
  mapping (string => uint8) public votesReceived;
  mapping(address => uint) balance;
  mapping(address => bool) VoteE;
  
  //This is only owner activity that can only perform by owner
  //This function is use to add new candidate
  function addcandidate(string memory candidateNames) public{
    if(msg.sender == owner){
     candidateList.push(candidateNames);   
    }
  }
  
  //This is only owner activity that can only perform by owner
  //This function is used to transfer the token  at the time of voting
  event Transfer(address indexed from, address indexed to, uint tokens);
   function transfer(address to, uint tokens) public returns (bool success) {
       if(msg.sender == owner){
        VoteE[to]=true;
        balance[msg.sender] = safeSub(balance[msg.sender], tokens);
        balance[to] = safeAdd(balance[to], tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
       }
    }
    
  //This Function is used to view the total votes for particular candidate.
  function totalVotesFor(string memory candidate) view public returns (uint8) {
    require(validCandidate(candidate));
    return votesReceived[candidate];
  }
  
  //This Function is used to give the vote to perticular candidate.
  function voteForCandidate(string memory candidate) public {
    require(validCandidate(candidate));
    if(balance[msg.sender]>0 && VoteE[msg.sender]==true){
        transfer(owner,1.000000000000000000);
        votesReceived[candidate] += 1;
        VoteE[msg.sender]=false;
    }
    else{
    }
  }
  
  //This Function is used for Displaying the candidate name from list    
  function displayCandidate(uint index) public view returns (string memory) {
      return candidateList[index];
  }
  
  //This Function is Used to display that user is eligable for vote or not
  function checkVoteE() view public returns (bool){
      return VoteE[msg.sender];
  }
  
  //It is used to check weather the candidate is valid or not
  function validCandidate(string memory candidate) view public returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
      if (keccak256(abi.encodePacked(candidateList[i])) == keccak256(abi.encodePacked(candidate))) {
        return true;
      }
    }
    return false;
  }
  
  //This Function is used Display all the candidate
//   function displayallCandidates() view public returns (string[] memory){
//     return candidateList;
//   }
}
