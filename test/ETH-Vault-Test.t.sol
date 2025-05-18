// License
// SPDX-License-Identifier: MIT

// Compiler version
pragma solidity 0.8.24;

// Libraries
import "../src/ETHVault.sol";
import "forge-std/Test.sol";

// Contract
contract ETHVaultTest is Test {   
   
    // Variables
    ethvault vaultTest;
    uint256 public firstMaxWithdrawPerHour = 50000000000000000000;
    address public admin = vm.addr(1);
    address public randomUser = vm.addr(2);

    // Functions
    function setUp() public{
        vaultTest = new ethvault(firstMaxWithdrawPerHour, admin);
    }

    // Unit testing
    function testFirstMaxWithdrawPerHour() public view{
        uint256 firstMaxWithdrawPerHour_ = vaultTest.maxWithdrawPerHour();
        assert (firstMaxWithdrawPerHour == firstMaxWithdrawPerHour_);
    }

    function testIfNotAdminCallsModifiyWithdrawReverts() public{
        vm.startPrank(randomUser);
        uint256 newMaxWithdrawPerHour_ = 60000000000000000000;
        vm.expectRevert();
        vaultTest.modifyMaxWithdrawPerHour(newMaxWithdrawPerHour_);
        vm.stopPrank();
    }

    function testIfNotAdminCallsPauseReverts() public{
        vm.startPrank(randomUser);
        vm.expectRevert();
        vaultTest.pausetransactions();
        vm.stopPrank();
    }

      function testIfNotAdminCallsUnpauseReverts() public{
        vm.startPrank(randomUser);
        vm.expectRevert();
        vaultTest.unpausetransactions();
        vm.stopPrank();
    }

      function testIfNotAdminCallsAddToBlackListReverts() public{
        vm.startPrank(randomUser);
        vm.expectRevert();
        vaultTest.addToBlackList(randomUser);
        vm.stopPrank();
    }        

    function testIfPausedWhenDepositReverts() public{
        vm.startPrank(admin);
        vaultTest.pausetransactions();
        vm.expectRevert();
        vaultTest.depositETH();
        vm.stopPrank();
    }

    function testIfPausedWhenWhitdrawReverts() public{
        vm.startPrank(admin);
        uint256 amount_ = 10000000000000000000;
        vaultTest.pausetransactions();
        vm.expectRevert();
        vaultTest.withdrawETH(amount_);
        vm.stopPrank();
    }

}