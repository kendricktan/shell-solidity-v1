
pragma solidity ^0.5.0;

import "ds-test/test.sol";

import "./originSwapTemplate.sol";

contract OriginSwapSuiteSixTest is OriginSwapTemplate, DSTest {

    function setUp() public {

        s = getShellSuiteSix();
        s2 = getShellSuiteSixClone();

    }

    function doubleDeposit (
        address w, uint256 wAmt,
        address x, uint256 xAmt,
        address y, uint256 yAmt,
        address z, uint256 zAmt
    ) public {

        s.deposit(w, wAmt, x, xAmt, y, yAmt, z, zAmt);
        s2.deposit(w, wAmt, x, xAmt, y, yAmt, z, zAmt);

    }

    function doubleDeposit (uint256 shells) public {

        s.proportionalDeposit(shells, 1e50);
        s2.proportionalDeposit(shells, 1e50);

    }

    function test_s6_originSwap_continuity_30Pct_to_30Pct () public {

        doubleDeposit(
            address(dai), 145e18,
            address(usdc), 90e6,
            address(usdt), 90e6,
            address(susd), 50e18
        );

        uint256 _targetOfTen = s.originSwap(
            address(dai),
            address(usdt),
            10e18
        );

        uint256 _targetOfFiveAndFive = s2.originSwap(
            address(dai),
            address(usdt),
            5e18
        );

        _targetOfFiveAndFive += s2.originSwap(
            address(dai),
            address(usdt),
            5e18
        );

        assertEq(
            _targetOfTen / 1e2 * 1e2,
            _targetOfFiveAndFive / 1e2 * 1e2
        );

    }

    function test_s6_originSwap_continuity_upperAndLowerFees_30Pct_to_30Pct () public {

        doubleDeposit(300e18);

        uint256 _targetOfForty = s.originSwap(
            address(usdc),
            address(dai),
            40e6
        );

        uint256 _targetOfTwentyAndTwenty = s2.originSwap(
            address(usdc),
            address(dai),
            20e6
        );

        _targetOfTwentyAndTwenty += s2.originSwap(
            address(usdc),
            address(dai),
            20e6
        );

        assertEq(
            _targetOfForty / 1e12,
            _targetOfTwentyAndTwenty / 1e12
        );

    }


    function test_s6_originSwap_continuity_partialUpperAndLowerFees_30Pct_to_10Pct () public {

        doubleDeposit(
            address(dai), 135e18,
            address(usdc), 90e6,
            address(usdt), 65e6,
            address(susd), 25e18
        );

        uint256 _targetOfThree = s.originSwap(
            address(dai),
            address(susd),
            3e18
        );

        uint256 _targetOf1p5And1p5 = s2.originSwap(
            address(dai),
            address(susd),
            1.5e18
        );

        _targetOf1p5And1p5 += s2.originSwap(
            address(dai),
            address(susd),
            1.5e18
        );

        assertEq(
            _targetOfThree / 1e12,
            _targetOf1p5And1p5 / 1e12
        );

    }

    function test_s6_originSwap_continuity_partialUpperAndLowerAntiSlippage_30Pct_to_30Pct () public {

        doubleDeposit(
            address(dai), 135e18,
            address(usdc), 60e6,
            address(usdt), 90e6,
            address(susd), 35e18
        );

        uint256 _targetOf30 = s.originSwap(
            address(usdc),
            address(dai),
            30e6
        );

        uint256 _targetOf15And15 = s2.originSwap(
            address(usdc),
            address(dai),
            15e6
        );

        _targetOf15And15 += s2.originSwap(
            address(usdc),
            address(dai),
            15e6
        );

        assertEq(
            _targetOf30 / 1e12,
            _targetOf15And15 / 1e12
        );

    }

    function test_s6_originSwap_continuity_partialUpperAndLowerAntiSlippage_unbalanced_10Pct_to_30Pct () public {

        doubleDeposit(
            address(dai), 135e18,
            address(usdc), 90e6,
            address(usdt), 90e6,
            address(susd), 25e18
        );

        uint256 _targetOf10 = s.originSwap(
            address(susd),
            address(dai),
            10e18
        );

        uint256 _targetOf5And5 = s2.originSwap(
            address(susd),
            address(dai),
            5e18
        );

        _targetOf5And5 += s2.originSwap(
            address(susd),
            address(dai),
            5e18
        );

        assertEq(
            _targetOf10 / 1e12,
            _targetOf5And5 / 1e12
        );

    }

    function test_s6_originSwap_continuity_partialUpperAndLowerAntiSlippage_unbalanced_30Pct_to_10Pct () public {

        doubleDeposit(
            address(dai), 90e18,
            address(usdc), 90e6,
            address(usdt), 58e6,
            address(susd), 40e18
        );

        uint256 _targetOf7 = s.originSwap(
            address(usdt),
            address(susd),
            7e6
        );

        uint256 _targetOf3p5And3p5 = s2.originSwap(
            address(usdt),
            address(susd),
            3.5e6
        );

        _targetOf3p5And3p5 += s2.originSwap(
            address(usdt),
            address(susd),
            3.5e6
        );

        assertEq(
            _targetOf7 / 1e12,
            _targetOf3p5And3p5 / 1e12
        );

    }

    function test_s6_originSwap_continuity_fullUpperAndLowerAntiSlippage_30Pct_to_30Pct () public {

        doubleDeposit(
            address(dai), 90e18,
            address(usdc), 135e6,
            address(usdt), 60e6,
            address(susd), 30e18
        );

        uint256 _targetOf5 = s.originSwap(
            address(usdt),
            address(usdc),
            5e6
        );

        uint256 _targetOf2p5And2p5 = s2.originSwap(
            address(usdt),
            address(usdc),
            2.5e6
        );

        _targetOf2p5And2p5 += s2.originSwap(
            address(usdt),
            address(usdc),
            2.5e6
        );

        assertEq(
            _targetOf5 / 1e2,
            _targetOf2p5And2p5 / 1e2
        );

    }

    function test_s6_originSwap_continuity_fullUpperAndLowerAntiSlippage_30Pct_to_10Pct () public {

        doubleDeposit(
            address(dai), 90e18,
            address(usdc), 135e6,
            address(usdt), 60e6,
            address(susd), 30e18
        );

        uint256 _targetOf2p349 = s.originSwap(
            address(dai),
            address(susd),
            2.349e18
        );

        uint256 _targetOf1p1745And1p1745 = s2.originSwap(
            address(dai),
            address(susd),
            1.1745e18
        );

        _targetOf1p1745And1p1745 += s2.originSwap(
            address(dai),
            address(susd),
            1.1745e18
        );

        assertEq(
            _targetOf2p349 / 1e12,
            _targetOf1p1745And1p1745 / 1e12
        );

    }

}