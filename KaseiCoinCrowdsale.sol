pragma solidity ^0.5.0;

// Import the following contracts from the OpenZeppelin library: Crowdsale and MintedCrowdsale as well as KaseiCoin contract.
import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";


// Create KaseiCoinCrowdsale contract with the prior openzeppelin imports inherited
contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale {
    
    // Provide parameters for all of the features of the crowdsale
    constructor(
        uint rate,
        address payable wallet,
        KaseiCoin token
    )
    Crowdsale(
        rate, 
        wallet, 
        token
    ) public {
        // Constructor left blank intentionally
    }
}

// Create KaseiCoinCrowdsaleDeployer contract to deploy KaseiCoinCrowdsale & KaseiCoin
contract KaseiCoinCrowdsaleDeployer {
    // Create addresses for other contracts
    address public kasei_token_address;
    address public kasei_crowdsale_address;

    // Add the constructor.
    constructor(
        string memory name,
        string memory symbol,
        address payable wallet
    ) public {
        // Create a new instance of the KaseiCoin contract and assign it's address to kasei_token_address
        KaseiCoin token = new KaseiCoin(name, symbol, 0);
        kasei_token_address = address(token);

        // Create a new instance of the KaseiCoinCrowdsale contract and assign it's address to kasei_crowdsale_address
        KaseiCoinCrowdsale token_crowdsale = new KaseiCoinCrowdsale(1, wallet, token);
        kasei_crowdsale_address = address(token_crowdsale);

        // Set the KaseiCoinCrowdsale contract as a minter and have KaseiCoinCrowdsaleDeployer renounce it's minter role
        token.addMinter(kasei_crowdsale_address);
        token.renounceMinter();
    }
}