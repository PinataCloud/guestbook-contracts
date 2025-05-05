// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Guestbook} from "../src/Guestbook.sol";

contract GuestbookTest is Test {
    Guestbook public guestbook;

    function setUp() public {
        guestbook = new Guestbook();
    }

    function test_SignGuestbook() public {
        string memory message = "Hello, world!";
        string memory imageUrl = "https://dweb.mypinata.cloud/ipfs/QmVLwvmGehsrNEvhcCnnsw5RQNseohgEkFNN1848zNzdng";

        // Test event emission
        vm.expectEmit(true, false, false, true);
        emit Guestbook.NewEntry(address(this), message, imageUrl, block.timestamp);

        guestbook.signGuestbook(message, imageUrl);

        // Test counter incremented
        assertEq(guestbook.totalEntries(), 1);
    }

    function testFuzz_SignGuestbook(string calldata randomMessage) public {
        uint256 initialCount = guestbook.getEntryCount();

        guestbook.signGuestbook(randomMessage, "");

        assertEq(guestbook.getEntryCount(), initialCount + 1);
    }
}
