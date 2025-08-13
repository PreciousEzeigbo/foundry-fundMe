// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";
import {FundMe} from "../../src/FundMe.sol";
import {Test, console} from "forge-std/Test.sol";

contract InteractionsTest is Test {
    FundMe public fundMe;
    DeployFundMe deployFundMe;

    uint256 public constant SEND_VALUE = 0.1 ether;
    uint256 public constant STARTING_USER_BALANCE = 10 ether;

    address alice = makeAddr("alice");

    function setUp() external {
        deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(alice, STARTING_USER_BALANCE);
    }

    function testUserCanFundInteractions() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

        assert(address(fundMe).balance == 0);
    }
}
