// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

import { Streamer } from './Streamer.sol';

import { ISuperfluid } from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";  

contract Controller {

    address owner;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    constructor (address _owner) {
        owner = _owner;
    }

    Streamer[] streamers;

    event newStream(address indexed owner, address streamAddress, address token, address receiver);

    function createNewStream(ISuperfluid host, address _receiver, address _token, int96 _flowRate, string calldata _name) public onlyOwner {
        
        Streamer streamer = new Streamer(host, _receiver, _token, owner, _flowRate, _name);
        
        streamers.push(streamer);

        emit newStream(msg.sender, address(streamer), _token, _receiver);

    }

    function getAllStreamers() external view returns(Streamer[] memory _streamers) {
        return streamers;
    }

}