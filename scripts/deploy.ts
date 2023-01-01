import { ethers } from "hardhat";

async function main() {
    //LectureNFT 컨트렉트 빌더 가져오기
    const Planet = await ethers.getContractFactory("Planet");
    const contract = await Planet.deploy(10000);
    await contract.deployed();
  
    console.log("nft contract address:",contract.address);
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
