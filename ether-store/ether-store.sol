pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/utils/SafeERC20.sol";

// Ether-store'u import edin
import "https://github.com/ethereum/ether-store/contracts/store.sol";

// Ödemeleri yönetmek için ERC20 token kullanacağız
contract ProductSale is Store, SafeERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint public totalSupply;
    uint public price;
    uint public availableQuantity;
    address public owner;

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint _totalSupply,
        uint _price,
        uint _availableQuantity
    ) public {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        price = _price;
        availableQuantity = _availableQuantity;
        owner = msg.sender;
    }

    function buy() public payable {
        // Ödeme yapılmış miktarı kontrol edin
        require(msg.value == price, "Ödeme yapılmış miktar doğru değil");

        // Stok miktarını kontrol edin
        require(availableQuantity > 0, "Stokta ürün kalmamış");

        // ERC20 token transferi yapın
        _transfer(msg.sender, 1);

        // Stok miktarını azaltın
        availableQuantity--;

        // Ödemeyi ether-store'a yaptırın
        store.execute(owner, msg.value);
    }
}
