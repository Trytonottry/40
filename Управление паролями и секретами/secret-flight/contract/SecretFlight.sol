// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SecretFlight {
  struct Vault {
    address owner;
    string  ipfsCid;
    uint256 graceEnd;
    address[] recipients;
  }

  mapping(address => Vault) public vaults;

  event Armed(address indexed owner, string ipfsCid, uint256 grace);
  event Ping(address indexed owner);
  event Released(address indexed owner, string ipfsCid, address indexed recipient);

  function arm(address[] calldata _recipients, string calldata _cid, uint256 _graceDays) external {
    vaults[msg.sender] = Vault({
      owner: msg.sender,
      ipfsCid: _cid,
      graceEnd: block.timestamp + _graceDays * 1 days,
      recipients: _recipients
    });
    emit Armed(msg.sender, _cid, _graceDays);
  }

  function ping() external {
    Vault storage v = vaults[msg.sender];
    require(v.owner != address(0), "No vault");
    v.graceEnd = block.timestamp + 30 days;
    emit Ping(msg.sender);
  }

  function trigger() external {
    Vault storage v = vaults[msg.sender];
    require(block.timestamp > v.graceEnd, "Still alive");
    for (uint i = 0; i < v.recipients.length; i++) {
      emit Released(msg.sender, v.ipfsCid, v.recipients[i]);
    }
    delete vaults[msg.sender];
  }
}
