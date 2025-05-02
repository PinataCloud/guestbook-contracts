// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Guestbook
 * @dev A simple onchain guestbook where users can sign with their wallet and leave a message
 */
contract Guestbook {
    // Event emitted when a new guestbook entry is created
    event NewEntry(address indexed signer, string message, uint256 timestamp);

    // Optional: track total number of entries
    uint256 public totalEntries;

    /**
     * @dev Sign the guestbook with a message
     * @param uri The message to leave in the guestbook
     */
    function signGuestbook(string calldata uri) external {
        // Emit the event with signer address, message, and timestamp
        emit NewEntry(msg.sender, uri, block.timestamp);

        // Increment total entries
        totalEntries += 1;
    }

    /**
     * @dev Get the total number of entries in the guestbook
     * @return The total number of entries
     */
    function getEntryCount() external view returns (uint256) {
        return totalEntries;
    }
}
