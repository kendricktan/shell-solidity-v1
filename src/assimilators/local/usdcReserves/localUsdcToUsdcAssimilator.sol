// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.5.0;

import "../../../ShellStorage.sol";

import "abdk-libraries-solidity/ABDKMath64x64.sol";

import "../../../interfaces/IAssimilator.sol";

contract LocalUsdcToUsdcAssimilator is IAssimilator, ShellStorage {

    using ABDKMath64x64 for int128;
    using ABDKMath64x64 for uint256;

    constructor (address _usdc) public {

        usdc = IERC20(_usdc);

    }

    function intakeRawAndGetBalance (uint256 _amount) public returns (int128 amount_, int128 balance_) {

        usdc.transferFrom(msg.sender, address(this), _amount);

        uint256 _balance = usdc.balanceOf(address(this));

        amount_ = _amount.divu(1e6);

        balance_ = _balance.divu(1e6);

    }

    function intakeRaw (uint256 _amount) public returns (int128 amount_) {

        usdc.transferFrom(msg.sender, address(this), _amount);

        amount_ = _amount.divu(1e6);

    }

    function intakeNumeraire (int128 _amount) public returns (uint256 amount_) {

        amount_ = _amount.mulu(1e6);

        usdc.transferFrom(msg.sender, address(this), amount_);

    }

    function outputRawAndGetBalance (address _dst, uint256 _amount) public returns (int128 amount_, int128 balance_) {

        usdc.transfer(_dst, _amount);

        uint256 _balance = usdc.balanceOf(address(this));

        amount_ = _amount.divu(1e6);

        balance_ = _balance.divu(1e6);

    }

    function outputRaw (address _dst, uint256 _amount) public returns (int128 amount_) {

        usdc.transfer(_dst, _amount);

        amount_ = _amount.divu(1e6);

    }

    function outputNumeraire (address _dst, int128 _amount) public returns (uint256 amount_) {

        amount_ = _amount.mulu(1e6);

        usdc.transfer(_dst, amount_);

    }

    function viewRawAmount (int128 _amount) public view returns (uint256 amount_) {

        amount_ = _amount.mulu(1e6);

    }

    function viewNumeraireAmount (uint256 _amount) public view returns (int128 amount_) {

        amount_ = _amount.divu(1e6);

    }

    function viewNumeraireBalance (address _addr) public view returns (int128 balance_) {

        uint256 _balance = usdc.balanceOf(_addr);

        balance_ = _balance.divu(1e6);

    }

    function viewNumeraireAmountAndBalance (address _addr, uint256 _amount) public view returns (int128 amount_, int128 balance_) {

        amount_ = _amount.divu(1e6);

        uint256 _balance = usdc.balanceOf(_addr);

        balance_ = _balance.divu(1e6);

    }

}