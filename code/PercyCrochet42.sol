pragma solidity ^0.8.0;

contract StorageContract {
    struct PatternSale {
        string pattern;
        string seller;
        string client;
    }

    struct ConfidenceVotePattern {
        string pattern;
        string seller;
        string client;
        bool result;
    }

    mapping(address => PatternSale) public patternSales;
    mapping(address => ConfidenceVotePattern) public confidenceVotes;
    mapping(address => string) public confidenceRevoked;

    event PatternSold(address indexed seller, string pattern, string client);
    event ConfidenceVoted(
        address indexed voter,
        string pattern,
        string client,
        bool result
    );
    event ConfidenceRevoked(address indexed reporter, string reported);

    function sellPattern(
        string memory pattern,
        string memory seller,
        string memory client
    ) external {
        patternSales[msg.sender] = PatternSale({
            pattern: pattern,
            seller: seller,
            client: client
        });
        emit PatternSold(msg.sender, pattern, client);
    }

    function getPatternSale(
        address seller
    ) external view returns (PatternSale memory) {
        return patternSales[seller];
    }

    function voteConfidence(
        string memory pattern,
        string memory seller,
        string memory client,
        bool result
    ) external {
        confidenceVotes[msg.sender] = ConfidenceVotePattern({
            pattern: pattern,
            seller: seller,
            client: client,
            result: result
        });
        emit ConfidenceVoted(msg.sender, pattern, client, result);
    }

    function getConfidenceVotePattern(
        address voter
    ) external view returns (ConfidenceVotePattern memory) {
        return confidenceVotes[voter];
    }

    function revokeConfidence(string memory guilty) external {
        confidenceRevoked[msg.sender] = string(
            abi.encodePacked(guilty, " is a scammer")
        );
        emit ConfidenceRevoked(msg.sender, guilty);
    }

    function getConfidenceRevoked(
        address reporter
    ) external view returns (string memory) {
        return confidenceRevoked[reporter];
    }
}
