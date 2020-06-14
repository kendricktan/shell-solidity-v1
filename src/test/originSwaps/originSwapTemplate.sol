
pragma solidity ^0.5.0;

import "abdk-libraries-solidity/ABDKMath64x64.sol";

import "../../interfaces/IAssimilator.sol";

import "../setup/setup.sol";

import "../setup/methods.sol";

contract OriginSwapTemplate is Setup {

    using ABDKMath64x64 for uint;
    using ABDKMath64x64 for int128;

    using LoihiMethods for Loihi;

    Loihi l;

    function noSlippage_balanced_10DAI_to_USDC_300Proportional () public returns (uint256 targetAmount_) {

        l.proportionalDeposit(300e18);

        targetAmount_ = l.originSwap(
            address(dai),
            address(usdc),
            10e18
        );

    }

    function noSlippage_lightlyUnbalanced_10USDC_to_USDT_with_80DAI_100USDC_85USDT_35SUSD () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 80e18,
            address(usdc), 100e6,
            address(usdt), 85e6,
            address(susd), 35e18
        );

        targetAmount_ = l.originSwap(
            address(usdc),
            address(usdt),
            10e6
        );

    }

    function noSlippage_balanced_10PctWeight_to_30PctWeight () public returns (uint256 targetAmount_) {

        l.proportionalDeposit(300e18);

        targetAmount_ = l.originSwap(
            address(susd),
            address(usdt),
            4e18
        );

    }

    function partialUpperAndLowerSlippage_unbalanced_10PctWeight_to_30PctWeight () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 65e18,
            address(usdc), 90e6,
            address(usdt), 90e6,
            address(susd), 30e18
        );

        targetAmount_ = l.originSwap(
            address(susd),
            address(dai),
            8e18
        );

    }

    function noSlippage_balanced_30PctWeight_to_30PctWeight () public returns (uint256 targetAmount_) {

        l.proportionalDeposit(300e18);

        targetAmount_ = l.originSwap(
            address(dai),
            address(usdc),
            10e18
        );

    }

    function noSlippage_lightlyUnbalanced_30PctWeight_to_10PctWeight () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 80e18,
            address(usdc), 80e6,
            address(usdt), 85e6,
            address(susd), 35e18
        );

        targetAmount_ = l.originSwap(
            address(usdc),
            address(susd),
            3e6
        );

    }

    function partialUpperAndLowerSlippage_balanced_40USDC_to_DAI () public returns (uint256 targetAmount_) {

        l.proportionalDeposit(300e18);

        targetAmount_ = l.originSwap(
            address(usdc),
            address(dai),
            40e6
        );

    }

    function partialUpperAndLowerSlippage_balanced_30PctWeight_CUSDC_to_CDAI () public returns (uint256 targetAmount_) {

        l.proportionalDeposit(300e18);

        uint256 cusdcOf40Numeraire = IAssimilator(cusdcAssimilator).viewRawAmount(40e18);

        uint256 targetAmount = l.originSwap(
            address(cusdc),
            address(cdai),
            cusdcOf40Numeraire
        );

        targetAmount_ = cdaiAssimilator.viewNumeraireAmount(targetAmount).mulu(1e18);

    }

    function partialUpperAndLowerSlippage_balanced_30PctWeight_to_10PctWeight () public returns (uint256 targetAmount_) {

        l.proportionalDeposit(300e18);

        targetAmount_ = l.originSwap(
            address(dai),
            address(susd),
            15e18
        );

    }
    
    function fullUpperAndLowerSlippage_unbalanced_30PctWeight () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 135e18,
            address(usdc), 90e6,
            address(usdt), 60e6,
            address(susd), 30e18
        );

        uint256 gas = gasleft();

        targetAmount_ = l.originSwap(
            address(dai),
            address(usdt),
            5e18
        );

        emit log_uint("gas for swap", gas - gasleft());

    }

    function fullUpperAndLowerSlippage_unbalanced_30PctWeight_NO_HACK () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 135e18,
            address(usdc), 90e6,
            address(usdt), 60e6,
            address(susd), 30e18
        );

        uint256 gas = gasleft();

        targetAmount_ = l.originSwap(
            address(dai),
            address(usdt),
            5e18
        );

        emit log_uint("gas for swap", gas - gasleft());

    }

    function fullUpperAndLowerSlippage_unbalanced_30PctWeight_HACK () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 135e18,
            address(usdc), 90e6,
            address(usdt), 60e6,
            address(susd), 30e18
        );

        uint256 gas = gasleft();

        targetAmount_ = l.originSwapHack(
            address(dai),
            address(usdt),
            5e18
        );

        emit log_uint("gas for swap", gas - gasleft());

    }

    function fullUpperAndLowerSlippage_unbalanced_30PctWeight_to_10PctWeight () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 135e18,
            address(usdc), 90e6,
            address(usdt), 65e6,
            address(susd), 25e18
        );

        targetAmount_ = l.originSwap(
            address(dai),
            address(susd),
            3e18
        );

    }

    function fullUpperAndLowerSlippage_CUSDC_ASUSD_unbalanced_10PctWeight_to_30PctWeight_ASUSD_CUSDC () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 90e18,
            address(usdc), 55e6,
            address(usdt), 90e6,
            address(susd), 35e18
        );

        uint256 asusdOf2Point8Numeraire = IAssimilator(asusdAssimilator).viewRawAmount(2.8e18);

        uint256 targetAmount = l.originSwap(
            address(asusd),
            address(cusdc),
            asusdOf2Point8Numeraire
        );

        targetAmount_ = IAssimilator(cusdcAssimilator).viewNumeraireAmount(targetAmount).mulu(1e18);

    }

    function fullUpperAndLowerSlippage_unbalanced_10PctWeight_to_30PctWeight () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 90e18,
            address(usdc), 55e6,
            address(usdt), 90e6,
            address(susd), 35e18
        );

        targetAmount_ = l.originSwap(
            address(susd),
            address(usdc),
            2.8e18
        );

    }

    function partialUpperAndLowerAntiSlippage_unbalanced_30PctWeight () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 135e18,
            address(usdc), 60e6,
            address(usdt), 90e6,
            address(susd), 30e18
        );

        targetAmount_ = l.originSwap(
            address(usdc),
            address(dai),
            30e6
        );

    }

    function partialUpperAndLowerAntiSlippage_unbalanced_10PctWeight_to_30PctWeight () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 135e18,
            address(usdc), 90e6,
            address(usdt), 90e6,
            address(susd), 25e18
        );

        targetAmount_ = l.originSwap(
            address(susd),
            address(dai),
            10e18
        );

    }

    function partialUpperAndLowerAntiSlippage_unbalanced_10PctWeight_to_30PctWeight_NO_HACK () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 135e18,
            address(usdc), 90e6,
            address(usdt), 90e6,
            address(susd), 25e18
        );

        uint256 gas = gasleft();

        targetAmount_ = l.originSwap(
            address(susd),
            address(dai),
            10e18
        );

        emit log_uint("gas for swap", gas - gasleft());

    }

    function partialUpperAndLowerAntiSlippage_unbalanced_10PctWeight_to_30PctWeight_HACK () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 135e18,
            address(usdc), 90e6,
            address(usdt), 90e6,
            address(susd), 25e18
        );

        uint256 gas = gasleft();

        targetAmount_ = l.originSwapHack(
            address(susd),
            address(dai),
            10e18
        );

        emit log_uint("gas for swap", gas - gasleft());

    }

    function partialUpperAndLowerAntiSlippage_unbalanced_30PctWeight_to_10PctWeight () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 90e18,
            address(usdc), 90e6,
            address(usdt), 58e6,
            address(susd), 40e18
        );

        targetAmount_ = l.originSwap(
            address(usdt),
            address(susd),
            10e6
        );

    }

    function fullUpperAndLowerAntiSlippage_unbalanced_30PctWeight () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 90e18,
            address(usdc), 135e6,
            address(usdt), 60e6,
            address(susd), 30e18
        );

        targetAmount_ = l.originSwap(
            address(usdt),
            address(usdc),
            5e6
        );

    }

    function fullUpperAndLowerAntiSlippage_10PctWeight_to30PctWeight () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 90e18,
            address(usdc), 90e6,
            address(usdt), 135e6,
            address(susd), 25e18
        );

        targetAmount_ = l.originSwap(
            address(susd),
            address(usdt),
            3.6537e18
        );

    }

    function fullUpperAndLowerAntiSlippage_30pctWeight_to_10Pct () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 58e18,
            address(usdc), 90e6,
            address(usdt), 90e6,
            address(susd), 40e18
        );

        targetAmount_ = l.originSwap(
            address(dai),
            address(susd),
            2.349e18
        );

    }

    function CHAI_fullUpperAndLowerAntiSlippage_30pctWeight_to_10Pct () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 58e18,
            address(usdc), 90e6,
            address(usdt), 90e6,
            address(susd), 40e18
        );

        uint256 chaiOf2p349Numeraire = IAssimilator(chaiAssimilator).viewRawAmount(2.349e18);

        targetAmount_ = l.originSwap(
            address(chai),
            address(susd),
            chaiOf2p349Numeraire
        );

    }

    function upperHaltCheck_30PctWeight () public returns (bool success_) {

        l.deposit(
            address(dai), 90e18,
            address(usdc), 135e6,
            address(usdt), 90e6,
            address(susd), 30e18
        );

        ( success_, ) = address(l).call(abi.encodeWithSelector(
            l.swapByOrigin.selector,
            address(usdc),
            address(usdt),
            30e6,
            0,
            1e50
        ));

    }

    function lowerHaltCheck_30PctWeight () public returns (bool success_) {

        l.deposit(
            address(dai), 60e18,
            address(usdc), 90e6,
            address(usdt), 90e6,
            address(susd), 30e18
        );

        ( success_, ) = address(l).call(abi.encodeWithSelector(
            l.swapByOrigin.selector,
            address(usdc),
            address(dai),
            30e6,
            0,
            1e50
        ));

    }

    function upperHaltCheck_10PctWeight () public returns (bool success_) {

        l.proportionalDeposit(300e18);

        ( success_, ) = address(l).call(abi.encodeWithSelector(
            l.swapByOrigin.selector,
            address(susd),
            address(usdt),
            20e18,
            0,
            1e50
        ));

    }

    function lowerhaltCheck_10PctWeight () public returns (bool success_) {

        l.proportionalDeposit(300e18);

        ( success_, ) = address(l).call(abi.encodeWithSelector(
            l.swapByOrigin.selector,
            address(dai),
            address(susd),
            20e18,
            0,
            1e50
        ));

    }

    function megaLowerToUpperUpperToLower_30PctWeight () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 55e18,
            address(usdc), 90e6,
            address(usdt), 125e6,
            address(susd), 30e18
        );

        targetAmount_ = l.originSwap(
            address(dai),
            address(usdt),
            70e18
        );

    }

    function megaLowerToUpperUpperToLower_CDAI_30PctWeight () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 55e18,
            address(usdc), 90e6,
            address(usdt), 125e6,
            address(susd), 30e18
        );

        uint256 cdaiOf70Numeraire = IAssimilator(cdaiAssimilator).viewRawAmount(uint(70e18).divu(1e18));

        targetAmount_ = l.originSwap(
            address(cdai),
            address(usdt),
            cdaiOf70Numeraire
        );

    }

    function megaLowerToUpper_10PctWeight_to_30PctWeight () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 90e18,
            address(usdc), 90e6,
            address(usdt), 100e6,
            address(susd), 20e18
        );

        targetAmount_ = l.originSwap(
            address(susd),
            address(usdt),
            20e18
        );

    }

    function megaUpperToLower_30PctWeight_to_10PctWeight () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 80e18,
            address(usdc), 100e6,
            address(usdt), 80e6,
            address(susd), 40e18
        );

        targetAmount_ = l.originSwap(
            address(dai),
            address(susd),
            20e18
        );

    }

    function greaterThanBalance_30Pct () public {

        l.deposit(
            address(dai), 46e18,
            address(usdc), 134e6,
            address(usdt), 75e6,
            address(susd), 45e18
        );

        l.originSwap(
            address(usdt),
            address(dai),
            50e6
        );

    }

    function greaterThanBalance_10Pct () public {

        l.proportionalDeposit(300e18);

        l.originSwap(
            address(usdc),
            address(susd),
            31e6
        );

    }

    function smartHalt_upper () public returns (bool success_) {

        l.proportionalDeposit(300e18);

        uint256 _rawCUsdc = cusdcAssimilator.viewRawAmount(uint256(110e18).divu(1e18));

        cusdc.transfer(address(l), _rawCUsdc);
        usdc.transfer(address(l), 110e6);

        success_ = l.originSwapSuccess(
            address(usdc),
            address(dai),
            1e6
        );

    }

    function smartHalt_upper_unrelated () public returns (bool success_) {

        l.proportionalDeposit(300e18);

        uint256 _rawCUsdc = cusdcAssimilator.viewRawAmount(uint256(110e18).divu(1e18));

        cusdc.transfer(address(l), _rawCUsdc);
        usdc.transfer(address(l), 110e6);

        success_ = l.originSwapSuccess(
            address(usdt),
            address(susd),
            1e6
        );

    }

    function smartHalt_lower_outOfBounds_to_outOfBounds () public returns (bool success_) {

        l.proportionalDeposit(67e18);

        uint256 _rawCDai = cdaiAssimilator.viewRawAmount(uint256(70e18).divu(1e18));

        cdai.transfer(address(l), _rawCDai);
        dai.transfer(address(l), 70e18);

        usdt.transfer(address(l), 70e6);
        ausdt.transfer(address(l), 70e6);

        susd.transfer(address(l), 23e18);
        asusd.transfer(address(l), 23e18);

        success_ = l.originSwapSuccess(
            address(usdc),
            address(dai),
            1e6
        );

    }

    function smartHalt_lower_outOfBounds_to_inBounds () public returns (bool success_) {

        l.proportionalDeposit(67e18);

        uint256 _rawCDai = cdaiAssimilator.viewRawAmount(uint256(70e18).divu(1e18));

        cdai.transfer(address(l), _rawCDai);
        dai.transfer(address(l), 70e18);

        usdt.transfer(address(l), 70e6);
        ausdt.transfer(address(l), 70e6);

        susd.transfer(address(l), 23e18);
        asusd.transfer(address(l), 23e18);

        success_ = l.originSwapSuccess(
            address(usdc),
            address(dai),
            40e6
        );

    }

    function smartHalt_lower_unrelated () public returns (bool success_) {

        l.proportionalDeposit(67e18);

        uint256 _rawCDai = cdaiAssimilator.viewRawAmount(uint256(70e18).divu(1e18));

        cdai.transfer(address(l), _rawCDai);
        dai.transfer(address(l), 70e18);

        usdt.transfer(address(l), 70e6);
        ausdt.transfer(address(l), 70e6);

        susd.transfer(address(l), 23e18);
        asusd.transfer(address(l), 23e18);

        success_ = l.originSwapSuccess(
            address(usdt),
            address(susd),
            1e6
        );

    }


    function monotonicity_mutuallyInBounds_to_mutuallyOutOfBounds_noHalts () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 2000e18,
            address(usdc), 5000e6,
            address(usdt), 5000e6,
            address(susd), 800e18
        );

        l.setTestHalts(false);

        targetAmount_ = l.originSwap(
            address(usdc),
            address(usdt),
            4900e6
        );

    }

    function monotonicity_mutuallyInBounds_to_mutuallyOutOfBounds_halts () public returns (uint256 targetAmount_) {

        l.deposit(
            address(dai), 2000e18,
            address(usdc), 5000e6,
            address(usdt), 5000e6,
            address(susd), 800e18
        );

        targetAmount_ = l.originSwap(
            address(usdc),
            address(usdt),
            4900e6
        );

    }
    
    function monotonicity_outOfBand_mutuallyOutOfBounds_to_mutuallyOutOfBounds_noHalts_omegaUpdate () public returns (uint256 targetAmount_) {

        l.proportionalDeposit(300e18);

        usdt.transfer(address(l), 4910e6);
        ausdt.transfer(address(l), 4910e6);
        
        l.prime();

        l.setTestHalts(false);

        targetAmount_ = l.originSwap(
            address(usdt),
            address(dai),
            1e6
        );

    }

    function monotonicity_outOfBand_mutuallyOutOfBounds_to_mutuallyOutOfBounds_noHalts_noOmegaUpdate () public returns (uint256 targetAmount_) {

        l.proportionalDeposit(300e18);

        usdt.transfer(address(l), 4910e6);
        ausdt.transfer(address(l), 4910e6);

        l.setTestHalts(false);

        targetAmount_ = l.originSwap(
            address(usdt),
            address(dai),
            1e6
        );

    }

    function monotonicity_outOfBand_mutuallyOutOfBounds_to_mutuallyInBounds_noHalts_updateOmega () public returns (uint256 targetAmount_) {

        l.proportionalDeposit(300e18);

        uint256 _rawCUsdc = cusdcAssimilator.viewRawAmount(uint256(4910e18).divu(1e18));

        usdc.transfer(address(l), 4910e6);
        cusdc.transfer(address(l), _rawCUsdc);

        usdt.transfer(address(l), 9910e6);
        ausdt.transfer(address(l), 9910e6);

        susd.transfer(address(l), 1970e18);
        asusd.transfer(address(l), 1970e18);

        l.setTestHalts(false);

        l.prime();

        targetAmount_ = l.originSwap(
            address(dai),
            address(usdt),
            5000e18
        );

    }

    function monotonicity_outOfBand_mutuallyOutOfBounds_to_mutuallyInBounds_noHalts_noUpdateOmega () public returns (uint256 targetAmount_) {

        l.proportionalDeposit(300e18);

        uint256 _rawCUsdc = cusdcAssimilator.viewRawAmount(uint256(4910e18).divu(1e18));

        usdc.transfer(address(l), 4910e6);
        cusdc.transfer(address(l), _rawCUsdc);

        usdt.transfer(address(l), 9910e6);
        ausdt.transfer(address(l), 9910e6);

        susd.transfer(address(l), 1970e18);
        asusd.transfer(address(l), 1970e18);

        l.setTestHalts(false);

        targetAmount_ = l.originSwap(
            address(dai),
            address(usdt),
            5000e18
        );

    }

    function monotonicity_outOfBand_mutuallyOutOfBound_towards_mutuallyInBound_noHalts_omegaUpdate () public returns (uint256 targetAmount_) {

        l.proportionalDeposit(300e18);

        susd.transfer(address(l), 4970e18);
        asusd.transfer(address(l), 4970e18);

        l.prime();

        l.setTestHalts(false);

        targetAmount_ = l.targetSwap(
            address(usdt),
            address(susd),
            1e18
        );

    }

}