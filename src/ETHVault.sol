// License

// SPDX-License-Identifier: LGPL-3.0-only

// Version

pragma solidity 0.8.24;

// Libraries

import "@openzeppelin/contracts/utils/Pausable.sol";

// Contract 

contract ethvault is Pausable{

    // Variables
    
    uint256 private time = 3600;
    uint256 public maxWithdrawPerHour;
    address public admin;
    mapping (address => uint256) public userBalance;
    mapping (address => uint256) private userWithdraw;
    mapping (address => uint256) private lastWithdraw;
    mapping (address => bool) public blocked;
  
    // Events

    event e_depositETH(address user_, uint256 amount_);
    event e_withdrawETH(address user_, uint256 amount_);
    event e_addToBlackList(address user_, bool blocked);
    event e_removeFromBlackList(address user_, bool blocked);


    // Modifiers

    modifier onlyAdmin(){
        require (msg.sender == admin, "Not allowed");
        _;
    }

    modifier notBloked(){
        require (!blocked[msg.sender],"Blocked user");
        _;    
    }

    // Constructor

    constructor(uint256 maxWithdrawPerHour_, address admin_){
        maxWithdrawPerHour = maxWithdrawPerHour_;
        admin = admin_;
    }

    // Functions

    // Deposit ETH

    function depositETH() external payable notBloked whenNotPaused {      
        userBalance[msg.sender] += msg.value;
        emit e_depositETH(msg.sender, msg.value);
    }  

    // Withdraw ETH

    function withdrawETH (uint256 amount_) external notBloked whenNotPaused {
        if (userWithdraw[msg.sender]  + amount_ > maxWithdrawPerHour && block.timestamp - lastWithdraw[msg.sender] < time) {
           revert("Wait 1 hour to withdraw more ETH");
        }
        else if (userWithdraw[msg.sender]  + amount_ > maxWithdrawPerHour && block.timestamp - lastWithdraw[msg.sender] >= time) {
            userWithdraw[msg.sender] = 0;
        }       
        require(amount_ <= userBalance[msg.sender],"Not enough ETH");
        require(userWithdraw[msg.sender] + amount_ <= maxWithdrawPerHour, "Maximum withdrawal per hour reached");
        
        // Update state

        userBalance[msg.sender] -= amount_;
        userWithdraw[msg.sender] += amount_;
        lastWithdraw[msg.sender] = block.timestamp;

        // Transfer ETH

        (bool success,) = msg.sender.call {value: amount_}("") ;
        require(success, "Transfer failed");
        emit e_withdrawETH(msg.sender, amount_);
    }

    // Modify maximum withdraw per hour

    function modifyMaxWithdrawPerHour(uint256 newMaxWithdrawPerHour_) external whenNotPaused onlyAdmin {
        maxWithdrawPerHour = newMaxWithdrawPerHour_;
    }

    // Pause and unpause

    function pausetransactions() public onlyAdmin{
        require (!paused(), "The contract is paused");
        _pause();
    }

    function unpausetransactions() public onlyAdmin(){
        require (paused(), "The contract is unpaused");
        _unpause();
    }

    // Blacklist

    function addToBlackList (address user_) external whenNotPaused onlyAdmin { 
        require(!blocked[user_],"Blacklisted");
        blocked[user_] = true;
        emit e_addToBlackList (user_, blocked[user_]);
    }
        
   function removeFromBlacklist (address user_) external whenNotPaused onlyAdmin { 
        require(blocked[user_],"Off the list");
        blocked[user_] = false;
        emit e_removeFromBlackList(user_, blocked[user_]);
    }

}