import Web3 from 'web3';
import fs from 'fs';
import path from 'path';
import dotenv from 'dotenv';
dotenv.config();

const web3 = new Web3(`https://mainnet.infura.io/v3/${process.env.INFURA_PROJECT_ID}`);
const account = web3.eth.accounts.privateKeyToAccount(process.env.PRIVATE_KEY);
web3.eth.accounts.wallet.add(account);

const bytecode = fs.readFileSync(path.resolve('contract/bytecode.txt'), 'utf8');
const abi = JSON.parse(fs.readFileSync(path.resolve('contract/abi.json')));

async function deploy() {
  const contract = new web3.eth.Contract(abi);
  const tx = contract.deploy({ data: bytecode });
  const gas = await tx.estimateGas();
  const receipt = await tx.send({ from: account.address, gas });
  console.log('Contract deployed at', receipt.contractAddress);
}
deploy();
