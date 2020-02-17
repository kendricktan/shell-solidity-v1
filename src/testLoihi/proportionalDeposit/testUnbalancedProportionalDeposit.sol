pragma solidity ^0.5.6;

import "ds-test/test.sol";
import "ds-math/math.sol";
import "../loihiSetup.sol";
import "../../IAdapter.sol";

contract LoihiTest is LoihiSetup, DSMath, DSTest {

    function setUp() public {

        setupFlavors();
        setupAdapters();
        setupLoihi();
        approveFlavors(address(l));

        uint256 mintedShells = l.proportionalDeposit(100 * (10 ** 18));

        emit log_named_uint("mintedShells", mintedShells);
        uint256 cusdcBal = IERC20(cusdc).balanceOf(address(l)); // 165557372275ish
        uint256 cdaiBal = IERC20(cdai).balanceOf(address(l)); // 163925889326ish
        uint256 usdtBal = IERC20(usdt).balanceOf(address(l)); // 33333333333333333300

        uint256 bal = l.balanceOf(address(this));

        // emit log_named_uint("bal", bal);
        // emit log_named_uint("cusdcBal", cusdcBal);
        // emit log_named_uint("cdaibal", cdaiBal);
        // emit log_named_uint("usdtBal", usdtBal);


        // uint256[] memory amounts = new uint256[](2);
        // address[] memory coins = new address[](2);

        // coins[0] = dai;
        // amounts[0] = 25 * WAD;
        // coins[1] = usdc;
        // amounts[1] = 35 * (10**6);
        // mintedShells = l.selectiveDeposit(coins, amounts, 0, now + 5000);
        // emit log_named_uint("mintedShells", mintedShells);

    }

    // function testproportionalDeposit () public {

        // uint256 mintedShells = l.proportionalDeposit(100 * (10 ** 18));
        // assertEq(mintedShells, 100 * (10 ** 18));

        // uint256 cusdcBal = IERC20(cusdc).balanceOf(address(l)); // 165557372275ish
        // uint256 cdaiBal = IERC20(cdai).balanceOf(address(l)); // 163925889326ish
        // uint256 usdtBal = IERC20(usdt).balanceOf(address(l)); // 33333333333333333300

        // uint256 usdtNumeraireAmount = IAdapter(usdtAdapter).getNumeraireAmount(usdtBal);
        // uint256 cusdcNumeraireAmount = IAdapter(cusdcAdapter).getNumeraireAmount(cusdcBal);
        // uint256 cdaiNumeraireAmount = IAdapter(cdaiAdapter).getNumeraireAmount(cdaiBal);
        
        // assertEq(usdtNumeraireAmount / (10 ** 10), 3333333300);
        // assertEq(cusdcNumeraireAmount / (10 ** 10), 3333333300);
        // assertEq(cdaiNumeraireAmount / (10 ** 10), 3333333333);

    // }

    event log_uints(bytes32, uint256[]);
    event log_bytes4(bytes32, bytes4);

    // function testProportionalDepositIntoSubOnePool () public {
    //     emit log_bytes4("totalreserve", l.totalReserves.selector);

    //     uint256 mintedShells = l.proportionalDeposit(100 * (10 ** 18));
    //     assertEq(mintedShells, 100 * (10 ** 18));
    //     // (uint256 totalBalance, uint256[] memory balances) = l.totalReserves();
    //     // emit log_named_uint("totalBal", totalBalance);
    //     // emit log_uints("balances", balances);

    //     uint256[] memory burnedShells = l.proportionalWithdraw(mintedShells-1);

    //     // (totalBalance, balances) = l.totalReserves();
    //     // emit log_named_uint("totalBal", totalBalance);
    //     // emit log_uints("balances", balances);
    //     // emit log_uints("burnedShells", burnedShells);

    //     mintedShells = l.proportionalDeposit(10*WAD);
    //     emit log_named_uint("mintedShells", mintedShells);
    //     // (totalBalance, balances) = l.totalReserves();
    //     // emit log_named_uint("totalBal", totalBalance);
    //     // emit log_uints("balances", balances);
    //     // emit log_uints("burnedShells", burnedShells);

    //     burnedShells  = l.proportionalWithdraw(mintedShells/2);

    //     // (totalBalance, balances) = l.totalReserves();
    //     // emit log_named_uint("totalBal", totalBalance);
    //     // emit log_uints("balances", balances);
    //     // emit log_uints("burnedShells", burnedShells);



    // }

}