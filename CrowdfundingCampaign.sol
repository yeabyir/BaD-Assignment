// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CrowdfundingCampaign {
    // State variables
    string private campaignName;
    string private campaignDescription;
    uint256 private fundingGoal;
    address private campaignCreator;
    uint256 private totalFundsRaised;

    uint256 private campaignDeadline; // timestamp
    uint256 private minimumContribution;
    bool private isActive;

    // Constructor
    constructor(
        string memory _name,
        string memory _description,
        uint256 _goal,
        uint256 _durationInDays,
        uint256 _minimumContribution
    ) {
        campaignName = _name;
        campaignDescription = _description;
        fundingGoal = _goal;
        campaignCreator = msg.sender;
        campaignDeadline = block.timestamp + (_durationInDays * 1 days);
        minimumContribution = _minimumContribution;
        isActive = true;
    }

    // Receive funds
    receive() external payable {
        require(isCampaignActive(), "Campaign not active");
        require(msg.value >= minimumContribution, "Contribution too small");

        totalFundsRaised += msg.value;

        if (totalFundsRaised >= fundingGoal) {
            isActive = false;
        }
    }

    // Individual getters
    function getName() public view returns (string memory) {
        return campaignName;
    }

    function getDescription() public view returns (string memory) {
        return campaignDescription;
    }

    function getFundingGoal() public view returns (uint256) {
        return fundingGoal;
    }

    function getCreator() public view returns (address) {
        return campaignCreator;
    }

    function getTotalFundsRaised() public view returns (uint256) {
        return totalFundsRaised;
    }

    function getDeadline() public view returns (uint256) {
        return campaignDeadline;
    }

    function getMinimumContribution() public view returns (uint256) {
        return minimumContribution;
    }

    function getIsActive() public view returns (bool) {
        return isActive;
    }

    // Helper functions
    function remainingFundingNeeded() public view returns (uint256) {
        if (totalFundsRaised >= fundingGoal) {
            return 0;
        }
        return fundingGoal - totalFundsRaised;
    }

    function daysUntilDeadline() public view returns (uint256) {
        if (block.timestamp >= campaignDeadline) {
            return 0;
        }
        return (campaignDeadline - block.timestamp) / 1 days;
    }

    function isCampaignActive() public view returns (bool) {
        return isActive && block.timestamp < campaignDeadline;
    }
}
