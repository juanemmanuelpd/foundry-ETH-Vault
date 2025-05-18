# Foundry ETH Vault
## Overview 🪙
The same repository ETH Vault in this profile but now tested with Foundry.
## Features 📃
* Testing - Verify the security and efficiency of this smart contract with different testing functions in foundry
* Fuzzing - The "foundry.toml" file is modified so that the fuzzing functions run with 1,000 different inputs.
* Deposit -> Deposit the amount of ETH you want, without limits.
* Withdraw -> Withdraw ETH easily.
* Admin -> Have the power to perform functions only permitted for the user who deploys this smart contract.
* Limit -> To prevent theft or questionable behavior, a certain limit of ETH is allowed to be withdrawn per hour.
* Black list -> Add users to a blacklist and prevent them from depositing or withdrawing within this bank.
* Pause -> In case of emergency, you can pause all transactions within the bank to prevent unwanted losses to your users' assets.
* Adjustable -> Set the amount of ETH you want as the withdrawal limit per hour.
## Technical details ⚙️
* Framework CLI -> Foundry.
* Forge version -> 1.1.0-stable.
* Solidity compiler version -> 0.8.24.
## Deploying the contract 🛠️
1. Clone the GitHub repository.
2. Open Visual Studio Code (you should already have Foundry installed).
3. Select "File" > "Open Folder", select the cloned repository folder.
4. In the project navigation bar, open the "ETHVault.sol" file located in the "src" folder.
5. In the toolbar above, select "Terminal" > "New Terminal".
6. Select the "Git bash" terminal (previously installed).
7. Run the `forge build` command to compile the script.
8. In the project navigation bar, open the "ETH-Vault-Test.t.sol" file located in the "test" folder.
9. Run the `forge build` command to compile the script.
10. Run the command `forge test --match-test` followed by the name of a test function to test it and verify the smart contract functions are working correctly. For example, run `forge test --match-test testIfNotAdminCallsModifiyWithdrawReverts` to test the `testIfNotAdminCallsModifiyWithdrawReverts` function.
11. Run `forge coverage` to generate a code coverage report, which allows you to verify which parts of the "calculator.sol" script code (in the "src" folder) are executed by the tests. This helps identify areas outside the coverage that could be exposed to errors/vulnerabilities.
## Functions 💻
* depositETH() -> Deposit ETH from your address to the bank.
* withdrawETH() -> Withdraw ETH from the bank to your address.
* modifyMaxWithdrawPerHour() ->  Sets the limit of ETH (in WEI) that can be withdrawn per hour. Only admin.
* pauseTransactions() -> Pause all bank transactions. Only admin.
* unpauseTransactions() -> Resume all bank transactions. Only admin.
* addToBlackList() ->  Add a user to the blacklist to prevent them from making deposits and withdrawals within the bank. Only admin.
* removeFromBlackList() -> Remove a user from the blacklist. Only admin.
## Testing functions (Unit testing) ⌨️
* testFirstMaxWithdrawPerHour() -> Verify that the value of maxWithdrawPerHour returned by the code is the same as the value declared in the variable.
* testIfNotAdminCallsModifiyWithdrawReverts() -> Verify that the smart contract reverts if the modifyMaxWithdrawPerHour function is not called by the admin.
* testIfNotAdminCallsPauseReverts() -> Verify that the smart contract reverts if the function to pause the contract is not called by the admin.
* testIfNotAdminCallsUnpauseReverts() -> Verify that the smart contract reverts if the admin does not call the function to unpause the contract.
* testIfNotAdminCallsAddToBlackListReverts() -> Verify that the smart contract reverts if the admin does not call the function to add users to the blacklist.
* testIfPausedWhenDepositReverts() -> Verifies that the smart contract reverts if a deposit is attempted while the contract is paused.
* testIfPausedWhenWhitdrawReverts() -> Verifies that the smart contract reverts if a withdrawal is attempted while the contract is paused.
## Testing functions (Fuzzzing testing) 🎲
* testFuzzingModifyMaxWithdrawPerHour() -> Verify that only the admin can correctly modify the maxWithdrawPerHour using several random values ​​for the testing function.

CODE IS LAW!
