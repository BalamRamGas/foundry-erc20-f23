//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {OurToken} from "../src/OurToken.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";

contract OurTokenTest is Test {
    OurToken public ourToken;
    DeployOurToken public deployOurToken;

    address public balam = makeAddr("balam");
    address public ernesto = makeAddr("ernesto");

    uint256 public constant INITIAL_SUPPLY = 1000 ether;
    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() external {
        deployOurToken = new DeployOurToken();
        ourToken = deployOurToken.run();

        vm.prank(msg.sender);
        console.log(msg.sender);
        console.log(address(deployOurToken));
        console.log(address(this));
        console.log(address(ourToken));
        ourToken.transfer(balam, STARTING_BALANCE);
    }

    function testBalamBalance() public {
        assertEq(STARTING_BALANCE, ourToken.balanceOf(balam));
    }

    function testAllowanceWorks() public {
        uint256 initialAllowance = 1000;

        // Balam approves Ernesto to spend tokens on his behalf
        vm.prank(balam);
        ourToken.approve(ernesto, initialAllowance);

        uint256 transferAmount = 500;

        vm.prank(ernesto);
        ourToken.transferFrom(balam, ernesto, transferAmount);

        assertEq(ourToken.balanceOf(ernesto), transferAmount);
        assertEq(ourToken.balanceOf(balam), STARTING_BALANCE - transferAmount);
    }

    function testInitialSupply() public {
        assertEq(
            INITIAL_SUPPLY,
            ourToken.balanceOf(msg.sender) + STARTING_BALANCE
        );
    }

    function testTransfer() public {
        uint256 transferAmount = 50 ether;

        vm.prank(msg.sender);
        ourToken.transfer(ernesto, transferAmount);

        assertEq(ourToken.balanceOf(ernesto), transferAmount);
        assertEq(
            ourToken.balanceOf(msg.sender),
            (INITIAL_SUPPLY - STARTING_BALANCE - transferAmount)
        );
    }

    function testBalancesAfterTransfer() public {
        uint256 transferAmount = 30 ether;

        vm.prank(msg.sender);
        ourToken.transfer(balam, transferAmount);

        assertEq(ourToken.balanceOf(balam), STARTING_BALANCE + transferAmount);
        assertEq(ourToken.balanceOf(ernesto), 0);
        assertEq(
            ourToken.balanceOf(msg.sender),
            (INITIAL_SUPPLY - STARTING_BALANCE - transferAmount)
        );
    }

    function testAllowanceAndTransferFrom() public {
        uint256 initialAllowance = 100 ether;
        uint256 transferAmount = 50 ether;

        vm.prank(balam);
        ourToken.approve(ernesto, initialAllowance);

        vm.prank(ernesto);
        ourToken.transferFrom(balam, ernesto, transferAmount);

        assertEq(ourToken.balanceOf(balam), STARTING_BALANCE - transferAmount);
        assertEq(ourToken.balanceOf(ernesto), 50 ether);
        assertEq(
            ourToken.balanceOf(msg.sender),
            INITIAL_SUPPLY - STARTING_BALANCE
        );
    }
}
