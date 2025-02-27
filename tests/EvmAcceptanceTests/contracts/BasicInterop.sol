// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

pragma abicoder v2;

// There are two precompiles allowing to:
// 1) Call scilla transition - precompile 5a494c51
// 2) Read scilla variable - precompile 5a494c52

// Arguments to these precompiles are constructed with abi.encode(). 
// There have to be at least two arguments - scilla_contract and transition/variable name. 
// User is expected to provide big enough output buffer for returned value (otherwise a call may revert)
// Returned value is encoded via abi so you should call abi.decode() with proper type to obtain underlying value

contract BasicInterop {

    function callSimpleMap(address contract_address, string memory tran_name, address recipient, uint128 amount) public {
        bytes memory encodedArgs = abi.encode(contract_address, tran_name, recipient, amount);
        uint256 argsLength = encodedArgs.length;
        bool success;
        assembly {
            success := call(21000, 0x5a494c51, 0, add(encodedArgs, 0x20), argsLength, 0x20, 0)
        }
        require(success);
    }

    function readSimpleMap(address scilla_contract, string memory field_name, address idx1) public view returns (uint128 funds) {
        bytes memory encodedArgs = abi.encode(scilla_contract, field_name, idx1);
        uint256 argsLength = encodedArgs.length;
        bool success;
        bytes memory output = new bytes(36);
        assembly {
            success := staticcall(21000, 0x5a494c92, add(encodedArgs, 0x20), argsLength, add(output, 0x20), 32)
        }
        require(success);
        (funds) = abi.decode(output, (uint128));
        return funds;

    }

    function callNestedMap(address contract_address, string memory tran_name, address idx1, address idx2, uint128 amount) public {
        bytes memory encodedArgs = abi.encode(contract_address, tran_name, idx1, idx2, amount);

        uint256 argsLength = encodedArgs.length;
        bool success;
        assembly {
            success := call(21000, 0x5a494c51, 0, add(encodedArgs, 0x20), argsLength, 0x20, 0)
        }
        require(success);
    }

    function readNestedMap(address scilla_contract, string memory field_name, address idx1, address idx2) public view returns (uint128 funds) {
        bytes memory encodedArgs = abi.encode(scilla_contract, field_name, idx1, idx2);
        uint256 argsLength = encodedArgs.length;
        bool success;
        bytes memory output = new bytes(36);
        assembly {
            success := staticcall(21000, 0x5a494c92, add(encodedArgs, 0x20), argsLength, add(output, 0x20), 32)
        }
        require(success);
        (funds) = abi.decode(output, (uint128));
        return funds;

    }

    function callUint(address contract_address, string memory tran_name, uint128 amount) public {
        bytes memory encodedArgs = abi.encode(contract_address, tran_name, amount);

        uint256 argsLength = encodedArgs.length;
        bool success;
        assembly {
            success := call(21000, 0x5a494c51, 0, add(encodedArgs, 0x20), argsLength, 0x20, 0)
        }
        require(success);
    }

    function readUint(address scilla_contract, string memory field_name) public view returns (uint128) {
        bytes memory encodedArgs = abi.encode(scilla_contract, field_name);
        uint256 argsLength = encodedArgs.length;
        bool success;
        bytes memory output = new bytes(36);
        assembly {
            success := staticcall(21000, 0x5a494c92, add(encodedArgs, 0x20), argsLength, add(output, 0x20), 32)
        }
        require(success);
        uint128 funds;

        (funds) = abi.decode(output, (uint128));
        return funds;
    }

    function callString(address contract_address, string memory tran_name, string memory value) public {
        bytes memory encodedArgs = abi.encode(contract_address, tran_name, value);

        uint256 argsLength = encodedArgs.length;
        bool success;
        assembly {
            success := call(21000, 0x5a494c51, 0, add(encodedArgs, 0x20), argsLength, 0x20, 0)
        }
        require(success);
    }

    function readString(address scilla_contract, string memory field_name) public view returns (string memory retVal) {
        bytes memory encodedArgs = abi.encode(scilla_contract, field_name);
        uint256 argsLength = encodedArgs.length;
        bool success;
        bytes memory output = new bytes(128);
        uint256 output_len = output.length - 4;
        assembly {
            success := staticcall(21000, 0x5a494c92, add(encodedArgs, 0x20), argsLength, add(output, 0x20), output_len)
        }
        require(success);

        (retVal) = abi.decode(output, (string));
        return retVal;
    }
}