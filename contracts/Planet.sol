// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import '@openzeppelin/contracts/access/Ownable.sol';

contract Planet is ERC721, Ownable {
  using Strings for uint256;

  uint256 numOfMetada;
  uint256 public totalSupply;
  mapping (uint256 => uint256) tokenmetadataId;//토큰 id와 메타데이터 매핑

  constructor(uint256 numOfMetada_) ERC721("CryptoSpace","PLANET"){
    numOfMetada = numOfMetada_;
  }

  function mintPlanet()external payable {
    require(msg.value >= 0.01 ether);
    uint256 tokenId = totalSupply++;
    //metada 만개중 하나를 랜덤으로 부여
    uint256 metadataId = uint256 (blockhash(block.number -1 )) % numOfMetada;
    tokenmetadataId[tokenId] = metadataId;
    _safeMint(_msgSender(), tokenId);
  }

  function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireMinted(tokenId);

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenmetadataId[tokenId].toString())) : "";
    }
   function _baseURI() internal view virtual override returns (string memory) {
        return "http://space.coinyou.io/metadata/";
    }
      function withdraw () external onlyOwner{
    payable(msg.sender).transfer(address(this).balance);
  }

}
