import Web3 from 'web3';
import fs from 'fs';
import path from 'path';

const web3 = new Web3(`https://mainnet.infura.io/v3/${process.env.INFURA_PROJECT_ID}`);
const account = web3.eth.accounts.privateKeyToAccount(process.env.PRIVATE_KEY);
web3.eth.accounts.wallet.add(account);

const abi = JSON.parse(fs.readFileSync(path.resolve('contract/abi.json')));
const contract = new web3.eth.Contract(abi, process.env.CONTRACT_ADDRESS);

export async function armSwitch(recipients, ipfsCid, graceDays) {
  const tx = contract.methods.arm(recipients, ipfsCid, graceDays);
  return tx.send({ from: account.address, gas: 300000 });
}

export async function pingAlive() {
  const tx = contract.methods.ping();
  return tx.send({ from: account.address, gas: 50000 });
}

export async function triggerIfDead() {
  const tx = contract.methods.trigger();
  return tx.send({ from: account.address, gas: 200000 });
}
