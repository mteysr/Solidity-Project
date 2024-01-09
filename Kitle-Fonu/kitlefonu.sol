pragma solidity ^0.5.0;

// Kitle fonu sözleşmesi
contract Crowdfund {
    // Fon toplamı
    uint public totalFunding;

    // Katılımcıların listesi
    mapping(address => uint) public backers;

    // Fon toplamını ve katılımcıların listesini sıfırlar
    constructor() public {
        totalFunding = 0;
    }

    // Fon toplama işlemi
    function contribute() public payable {
        // Fon toplamını artırır
        totalFunding += msg.value;

        // Katılımcının adresini ve aldığı desteği listeye ekler
        backers[msg.sender] += msg.value;
    }

    // Fonların dağıtılması
    function distributeFunds() public {
        // Fonların dağıtılması için minimum miktarı kontrol eder
        require(totalFunding >= 1000000, "Yeterli fon yok.");

        // Fonları dağıtır ve sözleşmeyi sonlandırır
        msg.sender.transfer(totalFunding);
        selfdestruct(msg.sender);
    }
}
