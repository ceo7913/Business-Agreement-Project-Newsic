// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./Pracsol.sol";
// ["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","324","1000","good"]

contract Market {
    using SafeMath for uint256;
    
    address private admin; 

    uint256 public marketplaceFee = 5;

    // mapping (uint => address) public recipient;
    mapping (uint => uint) public fee;
    // uint256 public recipientCount;

    mapping (uint => SellList) public sales;
    uint256 public salesId = 0;

    // mapping (uint => mapping (uint => OfferData)) public offerInfo;
    // mapping (uint => uint) public offerCount;

    // mapping (address => uint) public escrowAmount;

    // mapping (uint => AuctionData) public auction;
    // uint256 public auctionId;

    /// @notice This is the Sell struct, the basic structures contain the owner of the selling tokens.
    struct SellList {
        address seller;
        uint256 tokenId;
        uint256 amountOfToken;
        uint256 deadline;
        uint256 price;
        bool isSold;
    }

    struct OfferData {
        address offerAddress;
        uint256 offerPrice;
        bool isAccepted;
    }

    struct AuctionData {
        address creator;
        address highestBidder;
        uint256 tokenId;
        uint256 amountOfToken;
        uint256 highestBid;
        uint256 startPrice;
        uint256 minIncrement;
        uint256 startDate;
        uint256 duration;
        Action action;
    }

    enum Action {
        RESERVED, STARTED
    }
     /// @notice This is the emitted event, when a offer for a certain amount of tokens.
    event SellEvent (
        uint256 indexed _sellId,
        address indexed _seller,
        uint256 _offerId,
        uint256 _tokenId,
        uint256 _amount
    );

    /// @notice This is the emitted event, when a sell is canceled.
    event CanceledSell (
        address _seller,
        uint256 _tokenId,
        uint256 _amountOfToken
    );

    /// @notice This is the emitted event, when a buy is made.
    event BuyEvent (
        uint256 indexed _sellId,
        address _buyer,
        uint256 _tokenId,
        uint256 _amountOfToken,
        uint256 _price
    );
    // ???????????? ??????
    NewSickFund public Token;

    address NewSickCa;

    address marketAdmin;
    // ????????? ??????
    constructor(address _tokenAddress,address _admin) {
        Token = NewSickFund(_tokenAddress);
        NewSickCa = _tokenAddress;
        marketAdmin = _admin;
    }
    mapping (address => mapping(uint256 => uint256)) howmuch;

    function _patchMarketFee(uint256 _fee)public onlyAdmin{
        marketplaceFee = _fee;
    }

    function _createList(
        uint256 _tokenId,
        uint256 _amountOfToken,
        uint256 _deadline,
        uint256 _price
        ) public {
        // require(Token.balanceOf(msg.sender,_tokenId) >= _amountOfToken ,"less amount");
        require(Token.balanceOf(msg.sender,_tokenId) >= howmuch[msg.sender][_tokenId]+_amountOfToken,"exceed");
        if(!Token.isApprovedForAll(msg.sender,address(this))){
            Token.setApprovalForAll(msg.sender,address(this),true);
        }
        sales[salesId] = SellList (
            msg.sender,
            _tokenId,
            _amountOfToken,
            block.timestamp + _deadline,
            _price,
            false
        );
        emit SellEvent(
            salesId,
            msg.sender,
            salesId,
            _tokenId,
            _amountOfToken
        );
        salesId++;
        howmuch[msg.sender][_tokenId] += _amountOfToken;
    }
    function _buyListToken(
        uint256 _sellId,
        uint256 _amount
        ) public payable returns(bool) {
        require(msg.sender != address(0), "buyToken: Needs to be a address.");
        require(sales[_sellId].isSold != true, "buyToken: The tokends were bought.");
        require(msg.value >= sales[_sellId].price*_amount, "buyToken: Needs to be greater or equal to the price.");
        require(sales[_sellId].amountOfToken - _amount >= 0,"not enough");

        uint256 salePrice = sales[_sellId].price*_amount;
        uint256 feePrice = salePrice * marketplaceFee / 100;
        payable(sales[_sellId].seller).transfer(salePrice - feePrice);
        payable(marketAdmin).transfer(feePrice);
        Token.safeTransferFrom(
            sales[_sellId].seller,
            msg.sender,
            sales[_sellId].tokenId,
            _amount,
            "0x0"
        );
        sales[_sellId].amountOfToken -= _amount;
        emit BuyEvent(_sellId, msg.sender, sales[_sellId].tokenId, _amount, sales[_sellId].price*_amount);
        if(sales[_sellId].amountOfToken == 0) {
            // sales[_sellId].isSold == true;
            delete sales[_sellId];
        }
        return true;
    }

    function cancelList(
        uint256 _sellId
    ) public returns(bool) {
        require(sales[_sellId].seller == msg.sender,"who are you?");
        require(sales[_sellId].isSold != true, "already sold out");

        delete sales[_sellId];

        emit CanceledSell(
            sales[_sellId].seller,
            sales[_sellId].tokenId,
            sales[_sellId].amountOfToken
        );
    }

    // function makeOffer(uint256 _sellId,uint256 _price) public payable{
    //     require(msg.value == );
    // }
    // ?????? ????????? ?????????
    // event salelist(uint256 indexed num, address indexed owner,uint256 tokenId, uint256 amount,uint256 tokenPrice);

    // ?????? ?????? ????????? ?????? ????????????
    // struct registNft{
    //     address owner;
    //     uint256 tokenPrice;
    //     uint256 amount;
    //     uint256 finishdate;
    //     // string metauri;
    // }
    // ?????? ?????? ?????????????????? ??? ?????? ?????????

    // ????????? ????????? ?????? ????????? ???????????? ???????????? ??????
    // mapping (uint256 => mapping(address => registNft)) public tokenList;

    // function setlist(uint256 _tokenId,address _owner, uint256 _price, uint256 _amount, uint256 _finish) public {
    //     salelili[_tokenId] =  registNft(_owner,_price,_amount,_finish);
    // }

    // function nftRegister(uint256 _tokenId, registNft memory _registnft)public {
    //     // ??????????????? ????????? ????????? ?????? ??????
    //     require(msg.sender == _registnft.owner,"who are you?");
    //     // ??????????????? ????????? ?????????????????? ????????????
    //     require(Token.balanceOf(_registnft.owner,_tokenId) >= _registnft.amount ,"less amount");
    //     // ????????? ?????? ????????? nft ?????? + ?????? ?????? ????????? ??? ???????????? ?????? ?????????
    //     require(Token.balanceOf(_registnft.owner,_tokenId) >= howmuch[_registnft.owner][_tokenId],"not yet" );
    //     // ?????? ????????? ?????? ????????? ?????? 0??? ????????????
    //     require(_tokenId > 0 && _registnft.amount > 0 && _registnft.tokenPrice > 0,"not 0");
    //     // ?????? ?????? ??? ?????? ????????? ?????? ?????? ????????? ??????
    //     if(!Token.isApprovedForAll(_registnft.owner,NewSickCa)){
    //     Token.setApprovalForAll(NewSickCa,true);
    //     }
    //     // ??????????????? ??????
    //     _registnft.metauri = Token.uri(_tokenId);
    //     // ???????????? struct ??????
    //     // tokenList[_tokenId][_registnft.owner][sellnum] = _registnft;
    //     // ????????? ??????
    //     emit salelist(sellnum, _registnft.owner, _tokenId, _registnft.amount, _registnft.tokenPrice);
    //     // ???????????? ?????? + ??????
    //     sellnum++;
    // }

    // function getlist(address tokenad) public view returns(registNft[] memory){
    //     return tokenList[1][tokenad];
    // }
    modifier onlyAdmin{
        require(admin == msg.sender, "OA");
        _;
    }
}