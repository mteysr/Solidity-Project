pragma solidity ^0.6.0;

// Banka sözleşmesi
contract Banka {
    // Kullanıcıların bakiyelerini tutan mapping
    mapping (address => uint) public bakiyeler;

    // Kullanıcı bilgilerini tutan struct
    struct Kullanici {
        string isim;
        uint yas;
    }

    // Kullanıcıların bilgilerini tutan mapping
    mapping (address => Kullanici) public kullanicilar;

    // Para yatırma işlevi
    function paraYatir(uint miktar) public {
        // Kullanıcının bakiyesine para ekle
        bakiyeler[msg.sender] += miktar;
    }

    // Para çekme işlevi
    function paraCek(uint miktar) public {
        // Kullanıcının bakiyesi yeterli mi?
        require(bakiyeler[msg.sender] >= miktar, "Yeterli bakiye yok.");

        // Kullanıcının bakiyesinden para çek
        bakiyeler[msg.sender] -= miktar;
    }
}
